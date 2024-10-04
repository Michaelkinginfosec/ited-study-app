import { Body, Controller, Get, Param, Post } from '@nestjs/common';
import { ExamQuestion } from './schema/exam-question.schema';
import { CreateQuestionsDto } from './dto/exam-question.dto';
import { QuestionService } from './past-question.service';
import { TestQuestion } from './schema/test-question.schema';
import { CreateTestQuestionsDto } from './dto/test-question.dto';
import { CreateYearDTO } from './dto/create-year.dto';


@Controller('questions')
export class QuestionController {
    constructor(private readonly questionService: QuestionService) { }

    @Post('exam-questions')
    async create(@Body() createQuestionsDto: CreateQuestionsDto): Promise<ExamQuestion[]> {
        return this.questionService.createExamQuestions(createQuestionsDto);
    }

    @Get()
    async findAll(): Promise<ExamQuestion[]> {
        return this.questionService.getAllQuestions();
    }

    @Get(':id')
    async findOne(@Param('id') id: string): Promise<ExamQuestion> {
        return this.questionService.getQuestionById(id);
    }

    @Post('test-questions')
    async createTestQuestions(@Body() createTestQuestionsDto: CreateTestQuestionsDto): Promise<TestQuestion[]> {
        return this.questionService.createTestQuestions(createTestQuestionsDto);
    }

    @Get()
    async findAllTestQuestions(): Promise<TestQuestion[]> {
        return this.questionService.getAllTestQuestions();
    }

    @Get(':id')
    async findTestQuestionById(@Param('id') id: string): Promise<TestQuestion> {
        return this.questionService.getTestQuestionById(id);
    }

    @Post('create-year')
    async createYear(@Body() createYearDto: CreateYearDTO) {
        return this.questionService.createYear(createYearDto);
    }
}
