import { Body, Controller, Post } from "@nestjs/common";
import { ScholarshipService } from "./scholarship.service";
import { ScholarshipDTO } from "./dtos/scholarship.dto";

@Controller('scholarship')
export class ScholarshipController {
    constructor(readonly scholarshipService: ScholarshipService) { }


    @Post('apply-scholarship')
    async applyForScholarship(@Body() scholarshipDto: ScholarshipDTO) {
        return await this.scholarshipService.appyForScholarship(scholarshipDto);
    }
}