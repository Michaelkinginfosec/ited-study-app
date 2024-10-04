import { IsNotEmpty, IsString } from "class-validator";

export class CreateCourseDTO {
    // @IsString()
    // schoolId: string;

    @IsString({ message: 'name must be a string' })
    @IsNotEmpty({ message: 'name is required' })
    courseName: string;

    @IsString({ message: 'name must be a string' })
    @IsNotEmpty({ message: 'name is required' })
    courseTitle: string;

    @IsString({ message: 'name must be a string' })
    @IsNotEmpty({ message: 'name is required' })
    courseCode: string;

    @IsString({ message: 'name must be a string' })
    @IsNotEmpty({ message: 'name is required' })
    courseImage: string
}