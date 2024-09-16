import { Prop, Schema, SchemaFactory } from "@nestjs/mongoose";
import mongoose, { Document } from "mongoose";

@Schema()
export class SendVerificationCode extends Document {
    @Prop({ required: true })

    email: string;
    @Prop({ required: true, type: mongoose.Types.ObjectId })
    userId: mongoose.Types.ObjectId;

    @Prop({ required: true })
    code: string;

    @Prop({ required: true })
    expiryDate: Date;
}

export const SendVerificationCodeSchema = SchemaFactory.createForClass(SendVerificationCode);