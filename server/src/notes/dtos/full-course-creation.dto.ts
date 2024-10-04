import { IsNotEmpty, IsString } from "class-validator";

export class FullCourseCreationDTO {

    @IsString()
    @IsNotEmpty()
    country: string


    // countryId?: string;

    @IsString()
    @IsNotEmpty()
    school: string;


    // schoolId?: string;

    @IsString()
    @IsNotEmpty()
    courseName: string;

    @IsString()
    @IsNotEmpty()
    courseTitle: string;

    @IsString()
    @IsNotEmpty()
    courseCode: string;

    @IsString()
    @IsNotEmpty()
    courseImage: string
}