import { Body, Controller, Delete, Get, HttpException, HttpStatus, Param, Patch, Post, Query, Req, Res, } from "@nestjs/common";
import { UserService } from "./user.service";
import { UserDTO } from "src/users/dtos/user.dto";
import { ForgotPasswordDTO } from "src/common/dto/forgot-password.dto";
import { ResetPasswordDTO } from "./dtos/reset-password.dto";
import { Request, Response } from "express";
import { LoginDTO } from "./dtos/login.dto";
import { resendVerificationDTO } from "./dtos/verification.dto";

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

    // @Get(':id')
    // async getUser(@Param("id") userId: string) {
    //     return await this.userService.getUser(userId);
    // }
    @Get(":id")
    async getUserAccessToken(@Param("id") userId: string) {
        return await this.userService.getUserAccessToken(userId);
    }
    @Delete('delete/:id')
    async logOut(@Param('id') userId: string) {
        return await this.userService.logOut(userId);
    }

}