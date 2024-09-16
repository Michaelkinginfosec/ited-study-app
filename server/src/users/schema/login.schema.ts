import { Prop, Schema, SchemaFactory } from "@nestjs/mongoose";

Schema()
export class Login extends Document {
    @Prop({ required: true, })
    email: string;


    @Prop({ required: true, })
    password: string;

}

export const LoginSchema = SchemaFactory.createForClass(Login);