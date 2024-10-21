import { Body, Controller, Delete, Get, HttpException, HttpStatus, Param, Patch, Post, Query, Req, Res, UseGuards, } from "@nestjs/common";
import { UserService } from "./user.service";
import { UserDTO } from "src/users/dtos/user.dto";
import { ForgotPasswordDTO } from "src/common/dto/forgot-password.dto";
import { ResetPasswordDTO } from "./dtos/reset-password.dto";
import { Request, Response } from "express";
import { LoginDTO } from "./dtos/login.dto";
import { resendVerificationDTO } from "./dtos/verification.dto";
import { UpdateUserDTO } from "./dtos/update-user.dto";
import { AuthGuard } from "@nestjs/passport";
import { UpdatePasswordDTO } from "./dtos/update_user.dto";

@Controller('users')
export class UserController {
    constructor(private userService: UserService) { }

    @Post('create-account')
    async createUser(@Body() userDto: UserDTO) {
        try {
            const user = this.userService.createuser(userDto);
            return user;
        } catch (error) {
            throw new HttpException(
                error.message || 'An error occurred while creating your account',
                error.getStatus ? error.getStatus() : HttpStatus.INTERNAL_SERVER_ERROR,
            );
        }
    }
    @UseGuards(AuthGuard('local'))
    @Patch('update/:userId')
    async updateUser(@Param('userId') userId: string, @Body() updateUserDto: UpdateUserDTO,) {
        return this.userService.updateUser(updateUserDto, userId);
    }

    @Post('resend-verification')
    async resendVerification(@Body() resendVerificationDto: resendVerificationDTO) {

        await this.userService.resendVerification(resendVerificationDto);
        return { message: 'Verification code resent successfully.' };
    }
    @Get()
    async getAllUser() {
        return this.userService.getAllUser();
    }


    @Post('forgot-password')
    async userForgotPassword(@Body() forgotPasswordDto: ForgotPasswordDTO) {
        return this.userService.forgotPassword(forgotPasswordDto.email)


    }

    @Post('verify-otp')
    async verifyOTP(@Req() req: Request) {
        return this.userService.verifyOTP(req);
    }

    @Post('send-reset-link')
    async sendResetPasswordLink(@Body() forgotPasswordDto: ForgotPasswordDTO) {

        return await this.userService.sendResetPasswordLink(forgotPasswordDto.email);
    }
    @Patch('reset-password')
    async resetPassword(
        @Param('token') resetToken: string,
        @Body('newPassword') newPassword: string,
        @Res() res: Response,) {
        return await this.userService.resetPassword(newPassword, resetToken);
    }

    @Post('login')
    async login(@Body() loginDto: LoginDTO) {
        return await this.userService.login(loginDto);
    }


    @Get("token/:id")
    async getUserAccessToken(@Param("id") userId: string) {
        return await this.userService.getUserAccessToken(userId);
    }
    @Delete('delete/:id')
    async logOut(@Param('id') userId: string) {
        return await this.userService.logOut(userId);
    }

    @Patch('change-password/:id')
    async changePassword(@Body() updatePasswordDto: UpdatePasswordDTO, @Param('id') userId: string) {
        const { oldPassword, newPassword } = updatePasswordDto
        return await this.userService.changePassword(updatePasswordDto, userId)
    }

    @Get(':id')
    async getUserById(@Param('id') userId: string) {
        return await this.userService.findUserById(userId);
    }

}