import { isNotEmpty, IsNotEmpty, IsString } from "class-validator";

export class SchoolDTO {
    @IsString()
    countryId: string

    @IsString()
    @IsNotEmpty()
    school: string
}