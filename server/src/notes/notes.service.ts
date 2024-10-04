import { BadRequestException, Body, Injectable, InternalServerErrorException, Param } from "@nestjs/common";
import { InjectModel } from "@nestjs/mongoose";
import mongoose, { Model } from "mongoose";
import { v2 as cloudinary } from 'cloudinary';
import { CreateCourseDTO } from "./dtos/create-course.dto";
import { Country } from "./schemas/country.schema";
import { School } from "./schemas/school.schema";
import { CountryDTO } from "./dtos/country.dto";
import { SchoolDTO } from "./dtos/schoo.dto";
import { FullCourseCreationDTO } from "./dtos/full-course-creation.dto";
import { Course, CourseDocument } from "./schemas/course.schema";
import { title } from "process";




@Injectable()
export class NotesService {
    constructor(
        @InjectModel(Country.name) private countryModel: Model<Country>,
        @InjectModel(School.name) private schoolModel: Model<School>,
        @InjectModel(Course.name) private courseModel: Model<CourseDocument>,
    ) { }
    async createCountry(@Body() countryDto: CountryDTO) {
        const { country } = countryDto;
        const existingCountry = await this.countryModel.findOne({ country });
        if (existingCountry) {
            throw new BadRequestException('Country already exists');
        }
        const createcountry = await this.countryModel.create(countryDto)
        return {
            message: "country created",
            countryId: createcountry._id,
            country: createcountry.country
            
        };
    }
    async createNoteSchool(@Body() schoolDto: SchoolDTO) {
        const { school, countryId } = schoolDto;
        const existingCounryId = await this.countryModel.findOne({ _id: countryId });
        const existingSchool = await this.schoolModel.findOne({ school });
        if (existingSchool) {
            throw new BadRequestException('School already exists');
        }
        if (!existingCounryId) {
            throw new BadRequestException('Country does not exist');
        }

        const noteSchool = await this.schoolModel.create(schoolDto)
        return {
            message: "school created",
            schoolId: noteSchool._id,
            school: noteSchool.school
        };
    }

    async getSchoolsByCountryId(@Body() countryId: string) {
        const schools = await this.schoolModel.find({ countryId })
        return { message: schools };
    }

    async uploadImage(file: Express.Multer.File) {
        const result = await cloudinary.uploader.upload(file.path);

        if (!result) {
            throw new BadRequestException('file not uploaded')
        }

        const imageUrl = result.secure_url;
        return { url: imageUrl };

    }

    async createCourse(@Body() createCourseDto: CreateCourseDTO, @Param('id') schoolId: string) {

        const { courseName, courseTitle, courseCode } = createCourseDto;

        const existingCouseName = await this.courseModel.findOne({ courseName });
        const existingCourseTitle = await this.courseModel.findOne({ courseTitle });
        const existingCourseCode = await this.courseModel.findOne({ courseCode });

        if (existingCouseName) {
            throw new BadRequestException('Course already exists');
        }
        if (existingCourseTitle) {
            throw new BadRequestException('Course  already exists');
        }
        if (existingCourseCode) {
            throw new BadRequestException('Course already exists');
        }


        try {

            const createCourse = await this.courseModel.create({ ...createCourseDto, schoolId });
            if (createCourse) {
                return {
                    name: createCourse.courseName,
                    title: createCourse.courseTitle,
                    code: createCourse.courseCode,
                    image: createCourse.courseImage,
                    message: "course created successfully"
                };
            }
        } catch (error) {
            throw new InternalServerErrorException('Unknow error occured');
        }


    }
    async fullCourseCreation(@Body() fullCourseCreationDto: FullCourseCreationDTO) {

        const { country, school, courseTitle, courseCode, } = fullCourseCreationDto;
        const existingCountry = await this.countryModel.findOne({ country });
        const existingSchool = await this.schoolModel.findOne({ school });
        const existingCourseTitle = await this.courseModel.findOne({ courseTitle });
        const existingCourseCode = await this.courseModel.findOne({ courseCode });
        if (existingCountry) {
            throw new BadRequestException('Country already exists');
        }

        if (existingSchool) {
            throw new BadRequestException('School already exists');
        }


        if (existingCourseTitle) {
            throw new BadRequestException('Course  already exists');
        }
        if (existingCourseCode) {
            throw new BadRequestException('Course already exists');
        }


        try {
            const newCountry = await this.countryModel.create({ country });
            const newSchool = await this.schoolModel.create({ countryId: newCountry._id, school });

            const newCourse = await this.courseModel.create({ ...fullCourseCreationDto, schoolId: newSchool._id });

            return { newCountry, newSchool, newCourse };
        } catch (error) {
            throw new InternalServerErrorException('Unknow error occured');
        }


    }



}
