import { IsString, MinLength, } from "class-validator";

export class ChangePasswordDTO {
    @IsString()
    oldPassword: string;

    @IsString()
    @MinLength(6)
    newPassword: string;
}