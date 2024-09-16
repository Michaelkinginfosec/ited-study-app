import { HttpException, HttpStatus, Injectable } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import * as nodemailer from 'nodemailer';

@Injectable()
export class SendOTPService {
    private transporter;
    constructor(private readonly configService: ConfigService) {
        this.transporter = this.createTransport();
    }

    private createTransport() {
        return nodemailer.createTransport({
            host: this.configService.get<string>('emailService.host'),
            port: this.configService.get<number>('emailService.port'),
            secure: false,
            auth: {
                user: this.configService.get<string>('emailService.user'),
                pass: this.configService.get<string>('emailService.pass'),
            },
        });
    }

    async sendOTP(to: string, code: string) {
        const mailOptions = {
            to: to,
            from: this.configService.get<string>('default.address'),
            subject: 'Verify Your Account',
            html: `
                <p>Dear User,</p>
                <p>Thank you for registering with our application. Please use the following code to verify your account:</p>
                <h2>${code}</h2>
                <p>The code is valid for 5 minutes.</p>
                <p>If you did not request this code, please ignore this email.</p>
                <p>Best regards,</p>
                <p>Your Application Team</p>
            `,
        };

        try {
            const result = await this.transporter.sendMail(mailOptions);
            return result;
        } catch (error) {


            // Handle specific error codes or messages
            if (error.code === 'ETIMEDOUT') {
                throw new HttpException('Failed to send OTP due to network timeout', HttpStatus.SERVICE_UNAVAILABLE);
            } else if (error.code === 'ECONNREFUSED') {
                throw new HttpException('Failed to connect to email service', HttpStatus.SERVICE_UNAVAILABLE);
            } else if (error.responseCode === 535) { // 535 is for authentication errors
                throw new HttpException('Email service authentication failed', HttpStatus.UNAUTHORIZED);
            }

            // Handle other errors
            throw new HttpException('Error sending OTP', HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
}
