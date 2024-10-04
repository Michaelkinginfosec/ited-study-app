import { IsArray, IsNotEmpty, IsString, ValidateNested, ArrayMinSize } from 'class-validator';
import { Type } from 'class-transformer';

class CreateOptionDto {
    @IsNotEmpty()
    @IsString()
    option: string;
}

class CreateQuestionDto {
    @IsNotEmpty()
    @IsString()
    question: string;

    @IsArray()
    @ArrayMinSize(4)
    @ValidateNested({ each: true })
    @Type(() => CreateOptionDto)
    options: CreateOptionDto[];

    @IsNotEmpty()
    @IsString()
    correctAnswer: string;
}

export class CreateQuestionsDto {
    @IsArray()
    @ValidateNested({ each: true })
    @Type(() => CreateQuestionDto)
    questions: CreateQuestionDto[];
}
