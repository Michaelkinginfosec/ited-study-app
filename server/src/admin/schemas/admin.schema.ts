import { Prop, Schema, SchemaFactory } from "@nestjs/mongoose";
import { Document } from "mongoose";

@Schema()
export class Admin extends Document {
    @Prop({ unique: true, required: true })
    username: string;

    @Prop({ required: true })
    fullName: string;

    @Prop({ unique: true, required: true })
    email: string;

    @Prop({ required: true })
    password: string;


}

export const AdminSchema = SchemaFactory.createForClass(Admin);