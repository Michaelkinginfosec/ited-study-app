import { Prop, Schema, SchemaFactory } from "@nestjs/mongoose";

@Schema()
export class Country {
        @Prop({required:true, unique: true })
        country: string;
}
export const CountrySchema = SchemaFactory.createForClass(Country)