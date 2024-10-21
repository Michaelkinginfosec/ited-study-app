import { IsEmail, IsOptional, IsString } from "class-validator";

export class UpdateUserDTO {
    @IsOptional()
    @IsString()
    fullName: string;

    @IsOptional()
    @IsString()
    department: string;

    @IsOptional()
    @IsString()
    level: string;


}