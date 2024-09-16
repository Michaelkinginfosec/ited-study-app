import { IsEmail, IsNotEmpty, IsString } from "class-validator";

export class resendVerificationDTO {
    @IsEmail()
    @IsString()
    @IsNotEmpty()
    email: string;
}