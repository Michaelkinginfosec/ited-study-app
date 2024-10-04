import { Prop, Schema, SchemaFactory } from "@nestjs/mongoose";
import mongoose, { Document } from "mongoose";
import { School } from "./school.schema";


export type CourseDocument = Course & Document;

@Schema()
export class Course {

    // @Prop({ ref: School.name, required: true, type: String })
    // schoolId: string;

    @Prop({ required: true })
    courseName: string;

    @Prop({ required: true, unique: true })
    courseTitle: string;

    @Prop({ required: true, unique: true })
    courseCode: string;

    @Prop({ required: true })
    courseImage: string;
}
export const CourseSchema = SchemaFactory.createForClass(Course);