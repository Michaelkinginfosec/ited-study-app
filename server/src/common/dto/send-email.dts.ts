import { Address } from "nodemailer/lib/mailer"

export type sendEmailDTO = {
    from?: Address;
    receipients: Address[];
    subject: string;
    html: string;
    text?: string;
    placeholderReplacement?: Record<string, string>


}