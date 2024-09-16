import { Prop, Schema, SchemaFactory } from "@nestjs/mongoose";
import { Document } from "mongoose";

@Schema()
export class User extends Document {
    @Prop({ required: true })
    fullName: string;
    @Prop({ required: true })
    level: string;

    @Prop({ required: true })
    department: string;

    @Prop({ required: true, unique: true })
    email: string;

    @Prop({ required: true })
    password: string;

    @Prop({ default: false })
    verified: boolean;
}

export const UserSchema = SchemaFactory.createForClass(User);