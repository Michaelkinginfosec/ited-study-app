import { Injectable } from "@nestjs/common";
import { InjectModel } from "@nestjs/mongoose";
import { Scholarship } from "./schemas/scholarship.schema";
import mongoose, { Model } from "mongoose";
import { ScholarshipDTO } from "./dtos/scholarship.dto";

@Injectable()
export class ScholarshipService {
    constructor(@InjectModel(Scholarship.name) private scholarshipModel: Model<Scholarship>) { }

    async appyForScholarship(scholarshipDto: ScholarshipDTO) {
        const { userId } = scholarshipDto;

        if (!mongoose.Types.ObjectId.isValid(userId)) {
            throw new Error('Invalid user ID');
        }
        const newScholarship = await this.scholarshipModel.create(scholarshipDto);

        return newScholarship
    }


}