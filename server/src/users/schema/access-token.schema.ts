import { Prop, Schema, SchemaFactory } from "@nestjs/mongoose";
import mongoose, { Document } from "mongoose";

@Schema()

export class AccessToken extends Document {
    @Prop({ required: true, Type: mongoose.Types.ObjectId })
    userId: mongoose.Types.ObjectId;

    @Prop({ required: true })
    accessToken: string;

    @Prop({ required: true })
    expiryDate: Date;
}
export const AccessTokenSchema = SchemaFactory.createForClass(AccessToken);