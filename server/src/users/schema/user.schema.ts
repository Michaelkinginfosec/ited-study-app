import { Prop, Schema, SchemaFactory } from "@nestjs/mongoose";
import mongoose, { Document } from "mongoose";

@Schema()
export class User extends Document {
    @Prop({ required: true, type: mongoose.Types.ObjectId })
    schoolId: mongoose.Types.ObjectId;

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