import { Prop, Schema, SchemaFactory } from "@nestjs/mongoose";
import { Document } from "mongoose";

@Schema()
class Option {
    @Prop({ type: String, required: true })
    option: string;
}

@Schema()
export class ExamQuestion extends Document {
    @Prop({ type: String, required: true })
    question: string;

    @Prop({ type: [Option], required: true })
    options: Option[];

    @Prop({ type: String, required: true })
    correctAnswer: string;
}

export const ExamQuestionSchema = SchemaFactory.createForClass(ExamQuestion);
