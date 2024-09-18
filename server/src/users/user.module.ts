import { Controller, Module } from "@nestjs/common";
import { UserService } from "./user.service";
import { UserController } from "./user.controller";

import { MongooseModule } from "@nestjs/mongoose";
import { User, UserSchema } from "src/users/schema/user.schema";
import { SendVerificationCode, SendVerificationCodeSchema } from "src/users/schema/otp.schema"
import { SendOTPService } from "src/common/service/send-otp.service";
import { UserResetToken, UserResetTokenSchema } from "src/users/schema/reset-token.schema";
import { EmailService } from "src/common/service/mail.service";
import { UserRefreshToken, UserRefreshTokenSchema } from "./schema/user-refresh-token.schema";
import { JwtService } from "@nestjs/jwt";
import { AccessToken, AccessTokenSchema } from "./schema/access-token.schema";

@Module({
    imports: [
        MongooseModule.forFeature([
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
            },
            {
                name: AccessToken.name,
                schema: AccessTokenSchema
            }
        ])
    ],
    controllers: [UserController],
    providers: [UserService, SendOTPService, EmailService,]
})

export class UserModule { }