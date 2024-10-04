import { IsArray, IsNotEmpty, IsString, ValidateNested, ArrayMinSize } from 'class-validator';
import { Type } from 'class-transformer';

class CreateTestOptionDto {
    @IsNotEmpty()
    @IsString()
    option: string;
}

class CreateTestQuestionDto {
    @IsNotEmpty()
    @IsString()
    yearId: string;

    @IsNotEmpty()
    @IsString()
    question: string;

    @IsArray()
    @ArrayMinSize(4)
    @ValidateNested({ each: true })
    @Type(() => CreateTestOptionDto)
    options: CreateTestOptionDto[];

    @IsNotEmpty()
    @IsString()
    correctAnswer: string;
}

export class CreateTestQuestionsDto {
    @IsArray()
    @ValidateNested({ each: true })
    @Type(() => CreateTestQuestionDto)
    questions: CreateTestQuestionDto[];
}
