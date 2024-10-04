import { Module } from "@nestjs/common";
import { MongooseModule } from "@nestjs/mongoose";
import { NotesService } from "./notes.service";
import { NotesController } from "./notes.controller";
import { MulterModule } from "@nestjs/platform-express";
import storage from "src/common/config/multa-storage.config";
import { Country, CountrySchema } from "./schemas/country.schema";
import { School, SchoolSchema } from "./schemas/school.schema";
import { Course, CourseSchema } from "./schemas/course.schema";



@Module({
    imports: [
        MulterModule.register({
            storage,
        }),
        MongooseModule.forFeature(
            [
                {
                    name: Country.name,
                    schema: CountrySchema
                },
                {
                    name: School.name,
                    schema: SchoolSchema
                },
                {
                    name: Course.name,
                    schema: CourseSchema
                },

            ],
        ),
    ],
    controllers: [
        NotesController
    ],
    providers: [
        NotesService
    ],

})
export class NotesModule { }