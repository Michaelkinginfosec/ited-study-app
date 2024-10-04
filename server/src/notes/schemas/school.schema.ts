import { Prop, Schema, SchemaFactory } from "@nestjs/mongoose";
import mongoose from "mongoose";
import { Country } from "./country.schema";

@Schema()

export class School {
        @Prop({ required: true, ref: Country.name })
        countryId: string

        @Prop({ required: true, unique: true })
        school: string


}
export const SchoolSchema = SchemaFactory.createForClass(School)