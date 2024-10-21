import { Prop, Schema, SchemaFactory } from "@nestjs/mongoose";
import mongoose, { Document } from "mongoose";

@Schema()
export class Scholarship extends Document {
    @Prop({ required: true, type: mongoose.Types.ObjectId })
    userId: string;

    @Prop({ required: true })
    fullName: string;

    @Prop({ required: true })
    email: string;

    @Prop({ required: true })
    department: string;

    @Prop({ required: true })
    matricNumber: string;


}
export const ScholarshipSchema = SchemaFactory.createForClass(Scholarship)