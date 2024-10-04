import { IsNotEmpty, IsString } from "class-validator";

export class CreateYearDTO {
    @IsNotEmpty()
    @IsString()
    year: string;
}