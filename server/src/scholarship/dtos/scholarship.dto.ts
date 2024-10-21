import { IsEmail, IsNotEmpty, IsString } from "class-validator";

export class ScholarshipDTO {
    @IsString()
    @IsNotEmpty()
    userId: string;

    @IsString()
    @IsNotEmpty()
    fullName: string;
    @IsString()
    @IsNotEmpty()
    department: string;


    @IsNotEmpty()
    @IsString()
    @IsEmail()
    email: string;

    @IsNotEmpty()
    @IsString()
    matricNumber: string;

}