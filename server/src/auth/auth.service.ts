import { Injectable, InternalServerErrorException, NotFoundException, UnauthorizedException } from "@nestjs/common";
import { JwtService } from '@nestjs/jwt'
import { InjectModel } from "@nestjs/mongoose";
import { Model } from "mongoose";
import { AdminService } from "src/admin/admin.service";

import { Admin, AdminSchema } from "src/admin/schemas/admin.schema";

import { comparePassword, encodePassword } from "src/common/utils/bcrypt";
import { RefreshToken } from "src/admin/schemas/refresh-token.schema";
import { AdminModule } from "src/admin/admin.module";
import { nanoid } from "nanoid";
import { ResetToken } from "src/admin/schemas/admin-reset-token.schema";

import { UserService } from "src/users/user.service";
import { EmailService } from "src/common/service/mail.service";
import { UserResetToken } from "src/users/schema/reset-token.schema";
import { User } from "src/users/schema/user.schema";

@Injectable()
export class AuthService {
    constructor(
        private readonly adminService: AdminService,
        private jwtService: JwtService,
        private emailService: EmailService,


        @InjectModel(RefreshToken.name) private RefreshTokenModel: Model<RefreshToken>,
        @InjectModel(Admin.name) private AdminSchemaModel: Model<Admin>,

        @InjectModel(ResetToken.name) private resetTokenModel: Model<ResetToken>

    ) { }
    async validateAdmin(username: string, password: string) {

        //find user 
        const adminUser = await this.adminService.findAdminByUsername(username);
        if (!adminUser) {
            throw new UnauthorizedException("Wrong Credentials")
        }
        //compare user 

        const passwordMatch = comparePassword(password, adminUser.password);
        if (!passwordMatch) {
            throw new UnauthorizedException("Wrong Credentials")
        }


        return this.generateAdminToken(adminUser._id);

    }
    //refresh token 
    async refreshTokens(refreshToken: string) {
        const token = await this.RefreshTokenModel.findOne({
            token: refreshToken,
            expiryDate: { $gte: new Date() }
        })
        if (!token) {
            throw new UnauthorizedException();
        }
        return this.generateAdminToken(token.adminId)
    }

    //function to generate admin token
    async generateAdminToken(adminId) {
        //generate access token
        const payload = { adminId };
        const accessToken = this.jwtService.sign(payload, { expiresIn: '10h' });
        const refreshToken = nanoid(64);

        await this.storeRefreshToken(refreshToken, adminId)
        return { accessToken, refreshToken };
    }

    //store refresh token
    async storeRefreshToken(token: string, adminId) {

        const expiryDate = new Date();
        expiryDate.setDate(expiryDate.getDate() + 3)
        await this.RefreshTokenModel.updateOne({ adminId }, { $set: { expiryDate, token } }, {
            upsert: true,
        })
    }

    //change admin password
    async changeAdminPassword(userId, oldPassword: string, newPassword: string) {
        const admin = await this.AdminSchemaModel.findById(userId);
        if (!admin) {
            throw new NotFoundException('User not found...');
        }

        const passwordMatch = await comparePassword(oldPassword, admin.password);
        if (!passwordMatch) {
            throw new UnauthorizedException("Wrong Credential")
        }
        const newHashPassword = await encodePassword(newPassword);
        admin.password = newHashPassword;
        await admin.save();

    }
    async forgotPassword(email: string) {
        //find admin
        const isAdmin = await this.AdminSchemaModel.findOne({ email });
        if (isAdmin) {
            //generate a reset password link
            const expiryDate = new Date();
            expiryDate.setHours(expiryDate.getHours() + 1)
            const resetToken = nanoid(64);
            await this.resetTokenModel.create({
                token: resetToken,
                adminId: isAdmin._id,
                expiryDate
            });

            //send the link to thesuer
            this.emailService.sendMailResetEmail(email, resetToken)

        }
        return { message: "If the user exist, they will receive an email " }
    }


    async resetPassword(newPassword: string, resetToken: string) {
        //find a valid resettoken

        const token = await this.resetTokenModel.findOneAndDelete({
            token: resetToken,
            expiryDate: { $gte: new Date() }
        });
        if (!token) {
            throw new UnauthorizedException('Invalid Link');
        }

        //change admin password 

        const admin = await this.AdminSchemaModel.findById(token.adminId);
        if (!admin) {
            throw new InternalServerErrorException();
        }
        admin.password = await encodePassword(newPassword)
        await admin.save();

    }

}

