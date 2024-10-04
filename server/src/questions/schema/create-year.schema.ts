import { Prop, Schema, SchemaFactory } from "@nestjs/mongoose";
import { Document } from "mongoose";

@Schema()
export class CreateYear extends Document {
    @Prop({ required: true, unique: true })
    year: string;

}

export const CreateYearSchema = SchemaFactory.createForClass(CreateYear)