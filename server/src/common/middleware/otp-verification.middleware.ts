// otp-verification.middleware.ts

import { Injectable, NestMiddleware, HttpException, HttpStatus } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import { SendVerificationCode } from "src/users/schema/otp.schema";
import { Request, Response, NextFunction } from 'express';

@Injectable()
export class OTPVerificationMiddleware implements NestMiddleware {
    constructor(
        @InjectModel(SendVerificationCode.name) private SendVerificationCodeModel: Model<SendVerificationCode>,
    ) { }

    async use(req: Request, res: Response, next: NextFunction) {
        const { otp } = req.body;

        if (!otp) {
            throw new HttpException('OTP is required', HttpStatus.BAD_REQUEST);
        }

        // Find the OTP record using the OTP provided by the user
        const otpRecord = await this.SendVerificationCodeModel.findOneAndDelete({ code: otp });

        if (!otpRecord || otpRecord.expiryDate < new Date()) {
            throw new HttpException('Invalid or expired OTP', HttpStatus.UNAUTHORIZED);
        }

        // Attach the found OTP record to the request object for further use
        req['otpRecord'] = otpRecord;

        next();
    }
}

