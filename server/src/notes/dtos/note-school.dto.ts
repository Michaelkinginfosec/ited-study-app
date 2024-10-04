import { IsNotEmpty, IsString } from "class-validator"

export class NoteSchoolDTO {
    @IsString()
    countryId: string;

    @IsString()
    @IsNotEmpty()
    school: string
}