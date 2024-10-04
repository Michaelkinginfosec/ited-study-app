import { BadRequestException, GatewayTimeoutException, Injectable, InternalServerErrorException } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import mongoose, { Model } from 'mongoose';
import { ExamQuestion } from './schema/exam-question.schema';
import { CreateQuestionsDto } from './dto/exam-question.dto';
import { TestQuestion } from './schema/test-question.schema';
import { CreateTestQuestionsDto } from './dto/test-question.dto';
import { CreateYearDTO } from './dto/create-year.dto';
import { CreateYear } from './schema/create-year.schema';





@Injectable()
export class QuestionService {
    constructor(
        @InjectModel(ExamQuestion.name) private examQuestionModel: Model<ExamQuestion>,
        @InjectModel(TestQuestion.name) private testQuestionModel: Model<TestQuestion>,
        @InjectModel(CreateYear.name) private createYearModel: Model<CreateYear>,
    ) { }

    async createExamQuestions(createQuestionsDto: CreateQuestionsDto): Promise<ExamQuestion[]> {
        const questions = createQuestionsDto.questions.map(questionDto => ({
            question: questionDto.question,
            options: questionDto.options,
            correctAnswer: questionDto.correctAnswer,
        }));

        try {
            return this.examQuestionModel.insertMany(questions);
        } catch (error) {
            if (error instanceof BadRequestException) {
                console.log(error)
                throw new BadRequestException(error.message);
            } else if (error instanceof GatewayTimeoutException) {
                throw new GatewayTimeoutException(error.message);
            }
            throw new InternalServerErrorException();

        }


    }

    async getAllQuestions(): Promise<ExamQuestion[]> {


        try {
            return this.examQuestionModel.find().exec();
        } catch (error) {
            if (error instanceof BadRequestException) {
                console.log(error)
                throw new BadRequestException(error.message);
            } else if (error instanceof GatewayTimeoutException) {
                throw new GatewayTimeoutException(error.message);
            }
            throw new InternalServerErrorException();



        }
    }

    async getQuestionById(id: string): Promise<ExamQuestion> {

        try {
            return this.examQuestionModel.findById(id).exec();
        } catch (error) {
            if (error instanceof BadRequestException) {
                console.log(error)
                throw new BadRequestException(error.message);
            } else if (error instanceof GatewayTimeoutException) {
                throw new GatewayTimeoutException(error.message);
            }
            throw new InternalServerErrorException();


        }
    }

    async createTestQuestions(createTestQuestionsDto: CreateTestQuestionsDto): Promise<TestQuestion[]> {
        const questions = createTestQuestionsDto.questions.map(questionDto => ({
            yearId: new mongoose.Types.ObjectId(questionDto.yearId),
            question: questionDto.question,
            options: questionDto.options,
            correctAnswer: questionDto.correctAnswer,

        }));

        try {
            return this.testQuestionModel.insertMany(questions);
        } catch (error) {
            if (error instanceof BadRequestException) {
                console.log(error)
                throw new BadRequestException(error.message);
            } else if (error instanceof GatewayTimeoutException) {
                throw new GatewayTimeoutException(error.message);
            }
            throw new InternalServerErrorException();

        }


    }

    async getAllTestQuestions(): Promise<TestQuestion[]> {


        try {
            return this.testQuestionModel.find().exec();
        } catch (error) {
            if (error instanceof BadRequestException) {
                console.log(error)
                throw new BadRequestException(error.message);
            } else if (error instanceof GatewayTimeoutException) {
                throw new GatewayTimeoutException(error.message);
            }
            throw new InternalServerErrorException();
        }
    }

    async getTestQuestionById(id: string): Promise<TestQuestion> {

        try {
            return this.testQuestionModel.findById(id).exec();

        } catch (error) {
            if (error instanceof BadRequestException) {
                console.log(error)
                throw new BadRequestException(error.message);
            } else if (error instanceof GatewayTimeoutException) {
                throw new GatewayTimeoutException(error.message);
            }
            throw new InternalServerErrorException();
        }
    }

    async createYear(createYearDto: CreateYearDTO) {
        const { year } = createYearDto;
        const existingYear = await this.createYearModel.findOne({ year }).exec();
        if (!existingYear) {

            try {
                const createdYear = await new this.createYearModel(createYearDto);
                return createdYear.save();

            } catch (error) {
                if (error.name === 'ValidationError') {
                    throw new BadRequestException(error.message);
                } else if (error.name === 'MongoNetworkError') {
                    throw new GatewayTimeoutException('Request timed out while saving the year. Please try again later.');
                }
                throw new InternalServerErrorException('An unexpected error occurred. Please try again later.');
            }

        } else {
            throw new BadRequestException('Year already exists');

        }

    }
}

