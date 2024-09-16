import { Module } from "@nestjs/common";
import { adminController } from "src/admin/admin.controller";
import { AdminService } from "src/admin/admin.service";

import { MongooseModule } from "@nestjs/mongoose";
import { Admin, AdminSchema, } from "src/admin/schemas/admin.schema";

@Module({
    imports: [
        MongooseModule.forFeature([
            {
                name: Admin.name,
                schema: AdminSchema
            }
        ])
    ],
    controllers: [adminController],
    providers: [AdminService]

})
export class AdminModule { }
