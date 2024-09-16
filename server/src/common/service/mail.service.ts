import { Injectable } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import * as nodemailer from 'nodemailer';
import Mail from 'nodemailer/lib/mailer';


@Injectable()
export class EmailService {
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

    async sendMailResetEmail(to: string, token: string) {

        const resetLink = `http://myapp.com/reset-password?token=${token}`;
        const mailOptions = {
            from: this.configService.get<string>('default.address'),
            to: to,
            subject: 'Password Reset Request',
            html: `<p> You requested a password reset. Click the link below to reset your password:<p/><a href="${resetLink}">Reset Password</a>`

        }
        try {
            const result = await this.transporter.sendMail(mailOptions);
            console.log('Email Sent: ', result);
            return result;
        } catch (error) {
            console.error('Error sending email:', error);

        };

    }

}



