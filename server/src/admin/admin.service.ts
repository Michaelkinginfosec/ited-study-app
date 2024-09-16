import { HttpException, HttpStatus, Injectable } from "@nestjs/common";
import { InjectModel } from "@nestjs/mongoose";
import { Admin, AdminSchema } from "src/admin/schemas/admin.schema";
import { Model } from "mongoose";
import { AdminDTO } from "src/admin/dtos/admin.dto";
import { comparePassword, encodePassword } from "src/common/utils/bcrypt";

@Injectable()
export class AdminService {
    constructor(@InjectModel(Admin.name) private adminModel: Model<Admin>) { }
    async createAmin(adminDto: AdminDTO) {
        const hashPassword = encodePassword(adminDto.password);
        const admin = new this.adminModel({ ...adminDto, password: hashPassword });

        try {
            return await admin.save();
        } catch (error) {
            if (error.code === 11000) {
                // Handle duplicate key error
                if (error.message.includes('username')) {
                    throw new HttpException('Username already exists', HttpStatus.CONFLICT);
                }
                if (error.message.includes('email')) {
                    throw new HttpException('Email already exists', HttpStatus.CONFLICT);
                }
                // Handle other types of duplicate key errors if necessary
                throw new HttpException('Username or email already exists', HttpStatus.CONFLICT);
            }

            // Handle other errors
            throw new HttpException('An error occurred while creating admin', HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }


    async validateAdmin(username: string,) {
        return this.adminModel.findOne({ username });
    }

    getAdminUser() {
        return this.adminModel.find();
    }

    findAdminByUsername(username) {
        return this.adminModel.findOne({ username });
    }



}

