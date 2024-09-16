import { Body, Controller, Get, Patch, Post, Req, Request, UseGuards } from "@nestjs/common";
import { AuthGuard } from "@nestjs/passport";
import { RefreshTokenDTO } from "src/common/dto/refresh-token.dto";
import { AuthService } from "./auth.service";
import { JWTAuthGuard } from "src/common/guards/auth.guard";
import { ChangePasswordDTO } from "src/common/dto/change-password.dto";
import { ForgotPasswordDTO } from "src/common/dto/forgot-password.dto";
import { ResetPasswordDTO } from "src/common/dto/reset-password.dto";



@Controller('auth')
export class AuthController {
    constructor(private readonly authService: AuthService) { }
    @UseGuards(AuthGuard('local'))
    @Post('login')
    async login(@Request() req,) {

        const admin = req.user;
        return admin;

    }

    //refresh endpoint
    @Post('refresh')
    async refreshTokens(@Body() refreshTokenDto: RefreshTokenDTO) {
        return this.authService.refreshTokens(refreshTokenDto.token)
    }
    @UseGuards(JWTAuthGuard)
    @Get()
    someProtectedRoute(@Req() req) {
        return { message: "accessed Resouces" };
    }

    @UseGuards(JWTAuthGuard)
    @Patch('change-password')
    async changeAdminPassword(@Body() changePasswordDto: ChangePasswordDTO, @Req() req,) {
        return this.authService.changeAdminPassword(
            req.user.adminId,
            changePasswordDto.oldPassword,
            changePasswordDto.newPassword
        )
    }

    @Post('forgot-password')
    async forgotPassword(@Body() forgotPasswordDto: ForgotPasswordDTO) {
        return this.authService.forgotPassword(forgotPasswordDto.email)



    }


    // @UseGuards(JWTAuthGuard)
    @Patch('reset-password')
    async resetPassword(@Body() resetPasswordDto: ResetPasswordDTO) {
        return this.authService.resetPassword(
            resetPasswordDto.newPassword,
            resetPasswordDto.resetToken

        )
    }





}