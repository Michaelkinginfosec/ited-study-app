import { Body, Controller, Post, Get, HttpException, HttpStatus } from "@nestjs/common";
import { AdminService } from "src/admin/admin.service";
import { AdminDTO } from "src/admin/dtos/admin.dto";


@Controller('admin')
export class adminController {
    constructor(private adminService: AdminService) { }
    @Post()
    async createadmin(@Body() adminDto: AdminDTO) {
        try {

            const newAdmin = await this.adminService.createAmin(adminDto);
            return newAdmin;
        } catch (error) {

            throw new HttpException(
                error.message || 'An error occurred while creating the admin',
                error.getStatus ? error.getStatus() : HttpStatus.INTERNAL_SERVER_ERROR,
            );
        }
    }


    @Get()
    getAdminUser() {
        return this.adminService.getAdminUser();
    }
}