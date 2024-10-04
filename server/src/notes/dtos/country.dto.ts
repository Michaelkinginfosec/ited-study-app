import { IsNotEmpty, IsString, } from "class-validator";

export class CountryDTO {
        @IsNotEmpty({ message: 'name is required' })
        @IsString({ message: 'name must be a string' })
        country: string
}