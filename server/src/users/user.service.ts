import { BadRequestException, Body, HttpException, HttpStatus, Injectable, InternalServerErrorException, NotFoundException, Param, Req, UnauthorizedException } from "@nestjs/common";
import { InjectModel } from "@nestjs/mongoose";
import mongoose, { Model, Mongoose, Types } from "mongoose";

import { UserDTO } from "src/users/dtos/user.dto";

import { User } from "src/users/schema/user.schema";
import { comparePassword, encodePassword } from "src/common/utils/bcrypt";
import { Request, Response } from "express";
import { JwtService } from "@nestjs/jwt";


import { SendOTPService } from "src/common/service/send-otp.service";

import { nanoid } from "nanoid";
import { EmailService } from "src/common/service/mail.service";
import { UserResetToken } from "src/users/schema/reset-token.schema";
import { SendVerificationCode } from "src/users/schema/otp.schema";

import { LoginDTO } from "./dtos/login.dto";
import { UserRefreshToken } from "./schema/user-refresh-token.schema";
import { access } from "fs";
import { resendVerificationDTO } from "./dtos/verification.dto";
import { AccessToken } from "./schema/access-token.schema";
import { UpdateUserDTO } from "./dtos/update-user.dto";
import { Type } from "class-transformer";
import { UpdatePasswordDTO } from "./dtos/update_user.dto";




@Injectable()
export class UserService {
    constructor(
        @InjectModel(User.name) private userModel: Model<User>,
        @InjectModel(UserResetToken.name) private userResetTokenModel: Model<UserResetToken>,
        @InjectModel(UserRefreshToken.name) private userRefreshTokenModel: Model<UserRefreshToken>,
        @InjectModel(SendVerificationCode.name) private SendVerificationCodeModel: Model<SendVerificationCode>,
        @InjectModel(AccessToken.name) private accessTokenModel: Model<AccessToken>,
        private readonly sendOtpService: SendOTPService,
        private readonly emailService: EmailService,
        private readonly jwtService: JwtService

    ) { }

    async createuser(userDto: UserDTO) {


        const { email } = userDto;

        const existingUser = await this.userModel.findOne({ email });
        if (existingUser) {
            throw new HttpException('Email already exists', HttpStatus.CONFLICT);
        }

        const hashPassword = encodePassword(userDto.password);
        const user = new this.userModel({ ...userDto, password: hashPassword });

        try {


            const code = this.generateNumericOTP(5);
            if (!code) {
                throw new HttpException("Could not generate OTP", HttpStatus.BAD_REQUEST);
            }

            const expiryDate = new Date();
            expiryDate.setMinutes(expiryDate.getMinutes() + 5);
            const otpSent = await this.sendOtpService.sendOTP(email, code);
            if (otpSent) {
                await user.save();
                await this.SendVerificationCodeModel.create({
                    email,
                    userId: user._id,
                    code,
                    expiryDate
                });
                return { message: 'User registered successfully. Please verify your email.' };

            } else {
                throw new BadRequestException("Could not create user");
            }

            throw new BadRequestException("Could not create user");

        } catch (error) {

            if (error.code === 11000) {
                if (error.message.includes('email')) {
                    throw new HttpException('Email already exists', HttpStatus.CONFLICT);
                }
                throw new HttpException('Username or email already exists', HttpStatus.CONFLICT);
            }

            throw new BadRequestException("An error occur while creating your account please try again later")
        }
    }



    async updateUser(updateUserDto: UpdateUserDTO, userId: string) {

        if (!mongoose.Types.ObjectId.isValid(userId)) {
            throw new BadRequestException('Invalid User');
        }

        const existingUser = await this.userModel.findById(new mongoose.Types.ObjectId(userId));
        if (!existingUser) {
            throw new NotFoundException('User not found');
        }
        try {
            const updatedUser = await this.userModel.findByIdAndUpdate(
                userId,
                updateUserDto,
                { new: true }
            );

            return { message: 'User updated successfully', updatedUser };
        } catch (error) {
            if (error.code === 'ECONNRESET') {
                throw new InternalServerErrorException('Connection was reset, please try again later.');
            } else {

                throw new InternalServerErrorException('An error occurred while updating the user');
            }
        }
    }

    async changePassword(updatePasswordDto: UpdatePasswordDTO, userId: string) {
        const { oldPassword, newPassword } = updatePasswordDto;
        if (!mongoose.Types.ObjectId.isValid(userId)) {
            throw new BadRequestException('Invalid User');
        }
        const user = await this.userModel.findById(new mongoose.Types.ObjectId(userId));
        if (!user) {
            throw new NotFoundException('User not found');
        }


        if (typeof user.password !== 'string') {
            throw new BadRequestException('User password is not valid');
        }


        const passwordMatch = await comparePassword(oldPassword, user.password);
        if (!passwordMatch) {
            throw new BadRequestException('Old Password is incorrect');
        }


        const updatedUser = await this.userModel.updateOne(
            { _id: user._id },
            { password: encodePassword(newPassword) }
        );
        return { message: "Password changed successfully" };
    }


    async getAllUser() {
        const users = this.userModel.find();

        return users;
    }

    async findUserById(userId: string) {
        try {
            if (!Types.ObjectId.isValid(userId)) {
                throw new BadRequestException('Invalid User')
            }
            const user = await this.userModel.findById(userId);
            return user;
        } catch (error) {
            if (error.name === 'CastError') {
                console.log(error)
                throw new BadRequestException('Invalid User ID format!');

            }

            if (error instanceof BadRequestException) {
                throw new BadRequestException(error.message);
            }
            throw error;
        }



    }


    async resendVerification(resendVerificationDto: resendVerificationDTO) {
        const { email } = resendVerificationDto


        const user = await this.userModel.findOne({ email });


        if (!user) {
            throw new HttpException('User not found', HttpStatus.NOT_FOUND);
        }


        if (user.verified) {
            throw new HttpException('User is already verified', HttpStatus.BAD_REQUEST);
        }


        const code = this.generateNumericOTP(5);
        if (!code) {
            throw new HttpException("Could not generate OTP", HttpStatus.BAD_REQUEST);
        }


        const expiryDate = new Date();
        expiryDate.setMinutes(expiryDate.getMinutes() + 5);


        await this.SendVerificationCodeModel.findOneAndUpdate(

            { email, userId: user._id },
            { code, expiryDate, },
            { upsert: true, new: true }
        );


        await this.sendOtpService.sendOTP(email, code);
    }





    private generateNumericOTP(length: number): string {
        const digits = '0123456789';
        let otp = '';
        for (let i = 0; i < length; i++) {
            otp += digits.charAt(Math.floor(Math.random() * digits.length));
        }
        return otp;
    }

    async forgotPassword(email: string) {
        const isUser = await this.userModel.findOne({ email })
        const isVerified = isUser.verified;
        if (!isVerified) {
            throw new UnauthorizedException("kindly verify your account before you can reset your password")
        }

        if (isUser && isUser.verified) {
            const forgotPasswordToken = nanoid(64);

            const expiryDate = new Date();
            expiryDate.setMinutes(expiryDate.getMinutes() + 30);


            await this.userResetTokenModel.create({
                token: forgotPasswordToken,
                expiryDate,
                userId: isUser._id
            })
            this.emailService.sendMailResetEmail(email, forgotPasswordToken)
        }
        return { message: "If the user exist, they will receive an email " }
    }

    async verifyOTP(@Req() req: Request) {

        const otpRecord = req['otpRecord'];

        if (!otpRecord) {
            throw new HttpException('Invalid OTP verification request', HttpStatus.BAD_REQUEST);
        }


        const user = await this.userModel.findById(otpRecord.userId);
        if (!user) {
            throw new HttpException('User not found', HttpStatus.NOT_FOUND);
        }


        user.verified = true;
        await user.save();


        return { message: 'Email successfully verified' };
    }

    async sendResetPasswordLink(email: string) {

        const isUser = await this.userModel.findOne({ email });
        if (isUser) {
            const expiryDate = new Date();
            expiryDate.setMinutes(expiryDate.getDate() + 30);
            const resettoken = nanoid(64);

            await this.userResetTokenModel.create({
                userId: isUser._id,
                token: resettoken,
                expiryDate: expiryDate
            })
            await this.emailService.sendMailResetEmail(email, resettoken);
        }
        return { message: "If the email exist you will receive a reset link" }


    }

    async resetPassword(resetToken: string, newPassword: string) {

        const token = await this.userResetTokenModel.findOneAndDelete({
            token: resetToken,
            expiryDate: { $gte: new Date() }
        });
        if (!token) {
            throw new UnauthorizedException('Invalid Link');
        }
        const user = await this.userModel.findById(token.userId);
        if (!user) {
            throw new InternalServerErrorException();
        }

        user.password = await encodePassword(newPassword);
        await user.save()
        return { message: 'Password successfully reset' };

    }

    async login(@Body() loginDto: LoginDTO) {
        const { email, password } = loginDto;
        try {
            const user = await this.userModel.findOne({ email });
            if (!user) {
                throw new UnauthorizedException("Invalid Credentials");
            }

            const passwordMatch = await comparePassword(password, user.password);
            if (!passwordMatch) {
                throw new UnauthorizedException("Invalid Credentials");
            }
            const userId = user._id

            const verified = user.verified;
            if (verified === true) {
                const { accessToken } = await this.generateUsersToken(user._id);
                if (accessToken) {
                    return { message: "login successful", accessToken, userId };
                }


            } else {
                throw new UnauthorizedException("User is not verified, verify your account to login");
            }
        } catch (error) {



            if (error instanceof UnauthorizedException) {
                throw error;
            }


            throw new BadRequestException("An unknown error occurred");
        }
    }




    async storeRefreshToken(token: string, userId) {
        const expiryDate = new Date();
        expiryDate.setDate(expiryDate.getDate() + 100);
        await this.userRefreshTokenModel.updateOne({ userId }, { $set: { expiryDate, token } }, { upsert: true });
    }
    async storeAccessToken(accessToken: string, userId) {
        const expiryDate = new Date();
        expiryDate.setDate(expiryDate.getDate() + 100);
        await this.accessTokenModel.updateOne({ userId }, { $set: { expiryDate, accessToken } }, { upsert: true });
    }




    async generateUsersToken(userId) {
        const payload = { userId };
        const accessToken = this.jwtService.sign(payload, { expiresIn: '40H' });
        const refreshToken = nanoid(64);
        await this.storeRefreshToken(refreshToken, userId);
        await this.storeAccessToken(accessToken, userId);

        return { accessToken }
    }


    async refreshTokens(refreshToken: string) {
        const token = await this.userRefreshTokenModel.findOne({
            token: refreshToken,
            expiryDate: { $gte: new Date(), }
        })
        if (!token) {
            throw new UnauthorizedException();
        }
        return this.generateUsersToken(token.userId);
    }

    async getUserAccessToken(userId: string) {
        try {
            if (!Types.ObjectId.isValid(userId)) {
                throw new BadRequestException('User not found!');

            }
            const user = await this.accessTokenModel.findOne({ userId: new Types.ObjectId(userId) });
            if (!user) {
                throw new NotFoundException('User not found!!!');
            }
            return user;
        } catch (error) {
            if (error.name === 'CastError') {
                console.log(error)
                throw new BadRequestException('Invalid User ID format!');

            }

            if (error instanceof BadRequestException) {
                throw new BadRequestException(error.message);
            }
            throw error;
        }

    }

    async logOut(userId: string) {
        const accessToken = await this.accessTokenModel.findOne({ expiryDate: { $gte: new Date() }, userId: new Types.ObjectId(userId) });

        if (accessToken) {
            await this.deleteAccessToken(userId);
            return { message: 'Logged out successfully' };
        } else {
            return { message: 'No active sessions found' };
        }



    }
    async deleteAccessToken(userId: string) {
        return await this.accessTokenModel.deleteMany({ userId: new Types.ObjectId(userId) });
    }
}
