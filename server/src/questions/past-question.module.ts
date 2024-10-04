import { MongooseModule } from "@nestjs/mongoose";
import { ExamQuestion, ExamQuestionSchema } from "./schema/exam-question.schema";
import { TestQuestion, TestQuestionSchema } from "./schema/test-question.schema";
import { QuestionController } from "./past-question.controller";
import { QuestionService } from "./past-question.service";
import { CreateYear, CreateYearSchema } from "./schema/create-year.schema";
import { Module } from "@nestjs/common";

@Module({
    imports: [
        MongooseModule.forFeature(

            [
                {
                    name: ExamQuestion.name,
                    schema: ExamQuestionSchema,
                },
                {
                    name: TestQuestion.name,
                    schema: TestQuestionSchema
                },
                {
                    name: CreateYear.name,
                    schema: CreateYearSchema
                }

            ],
        ),
    ],
    controllers: [QuestionController],
    providers: [QuestionService],
})
export class PastQuestionModule { }