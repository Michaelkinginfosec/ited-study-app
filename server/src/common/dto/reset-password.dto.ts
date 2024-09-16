import { IsString, Matches, MinLength } from "class-validator";

export class ResetPasswordDTO {
    @IsString()
    resetToken: string;

    @IsString()
    @MinLength(8)
    @Matches(/^(?=.*[0-9])/, { message: 'Password must conatain at leaset on number' })
    newPassword: string;
}