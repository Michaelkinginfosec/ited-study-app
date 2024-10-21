import { BadRequestException, Body, Controller, Get, Param, Post, UploadedFile, UseInterceptors } from "@nestjs/common";
import { NotesService } from "./notes.service";
import { FileInterceptor } from "@nestjs/platform-express";
import { CreateCourseDTO } from "./dtos/create-course.dto";
import { CountryDTO } from "./dtos/country.dto";
import { SchoolDTO } from "./dtos/schoo.dto";
import { FullCourseCreationDTO } from "./dtos/full-course-creation.dto";



@Controller('notes')
export class NotesController {

    constructor(private readonly noteService: NotesService) { }


    @Post('create-country')
    async createCountry(@Body() countryDto: CountryDTO) {
        return await this.noteService.createCountry(countryDto)
    }
    //DONE: get country
    @Get('get-country')
    async getCountry() {
        return await this.noteService.getCountry()
    }
    @Post('create-school')
    async createNoteSchool(@Body() schoolDto: SchoolDTO) {
        return await this.noteService.createNoteSchool(schoolDto)
    }

    @Get("schools/:id")
    async getSchoolsByCountryId(@Param('id') @Body() countryId: string) {
        return await this.noteService.getSchoolsByCountryId(countryId)
    }

    @Post('upload-image')
    @UseInterceptors(FileInterceptor('file'))
    async uploadImage(@UploadedFile() file: Express.Multer.File) {
        if (!file) {
            throw new BadRequestException('File not provided');
        }
        return await this.noteService.uploadImage(file);
    }

    @Post('create-course/:id')
    async createCourse(@Body() createCourseDto: CreateCourseDTO, @Param('id') schoolId: string) {
        return await this.noteService.createCourse(createCourseDto, schoolId);
    }

    @Post('full-course-creation')
    async fullCourseCreation(@Body() fullCourseCreationDto: FullCourseCreationDTO) {
        return await this.noteService.fullCourseCreation(fullCourseCreationDto)
    }
    @Get()
    async getCourse() {
        return await this.noteService.fetchCourse()
    }

}