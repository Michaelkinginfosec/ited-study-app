import { Prop, Schema, SchemaFactory } from "@nestjs/mongoose";
import mongoose, { Document } from "mongoose";

@Schema()
export class UserResetToken extends Document {
    @Prop({ Type: mongoose.Types.ObjectId, required: true })
    userId: mongoose.Types.ObjectId;

    @Prop({ required: true })
    token: string;

    @Prop({ required: true })
    expiryDate: Date;
}

export const UserResetTokenSchema = SchemaFactory.createForClass(UserResetToken);