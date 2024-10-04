import { Prop, Schema, SchemaFactory } from "@nestjs/mongoose";
import mongoose, { Document, } from "mongoose";

@Schema()
class Option {
    @Prop({ type: String, required: true })
    option: string;
}

@Schema()
export class TestQuestion extends Document {
    @Prop({ type: mongoose.Types.ObjectId, required: true })
    yearId: mongoose.Types.ObjectId;

    @Prop({ type: String, required: true })
    question: string;

    @Prop({ type: [Option], required: true })
    options: Option[];

    @Prop({ type: String, required: true })
    correctAnswer: string;
}

export const TestQuestionSchema = SchemaFactory.createForClass(TestQuestion);

