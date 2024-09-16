import { Module } from "@nestjs/common";
import { AuthController } from "./auth.controller";
import { AuthService } from "./auth.service";
import { AdminService } from "src/admin/admin.service";
import { PassportModule } from "@nestjs/passport";
import { LocalStrategy } from "src/common/utils/local.strategy";
import { MongooseModule } from "@nestjs/mongoose";
import { Admin, AdminSchema } from "src/admin/schemas/admin.schema";
import { RefreshToken, RefreshTokenSchema } from "src/admin/schemas/refresh-token.schema";
import { ResetToken, ResetTokenSchema } from "src/admin/schemas/admin-reset-token.schema";

import { UserService } from "src/users/user.service";
import { EmailService } from "src/common/service/mail.service";
import { User, UserSchema } from "src/users/schema/user.schema";
import { SendVerificationCode, SendVerificationCodeSchema } from "src/users/schema/otp.schema";
import { SendOTPService } from "src/common/service/send-otp.service";
import { UserResetToken, UserResetTokenSchema } from "src/users/schema/reset-token.schema";

import { UserRefreshToken, UserRefreshTokenSchema } from "src/users/schema/user-refresh-token.schema";


@Module({
    imports: [
        PassportModule,
        MongooseModule.forFeature([
            {
                name: Admin.name,
                schema: AdminSchema
            },
            {
                name: RefreshToken.name,
                schema: RefreshTokenSchema
            },
            {
                name: ResetToken.name,
                schema: ResetTokenSchema
            },
            {
                name: User.name,
                schema: UserSchema
            },
            {
                name: SendVerificationCode.name,
                schema: SendVerificationCodeSchema
            },
            {
                name: UserResetToken.name,
                schema: UserResetTokenSchema
            },
            {
                name: UserRefreshToken.name,
                schema: UserRefreshTokenSchema
            }
        ])
    ],
    providers: [
        EmailService,
        AuthService,
        AdminService,
        LocalStrategy,
        UserService,
        SendOTPService,

    ],

    controllers: [AuthController,]


})

export class AuthModule { }