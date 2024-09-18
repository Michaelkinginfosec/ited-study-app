import { IsDate, IsNotEmpty, IsString } from "class-validator"

export class AccessTokenDTO {
    @IsNotEmpty()
    @IsString()
    userId: string
    @IsString()
    @IsNotEmpty()
    accessToken: string
    @IsDate()
    @IsNotEmpty()
    expiryDate: Date
}