import { Module } from '@nestjs/common';
import { MongooseModule } from '@nestjs/mongoose';
import { Mongoose } from 'mongoose';
import { Scholarship, ScholarshipSchema } from './schemas/scholarship.schema';
import { ScholarshipController } from './scholarship.controller';
import { ScholarshipService } from './scholarship.service';

@Module({
    imports: [
        MongooseModule.forFeature(
            [
                {
                    name: Scholarship.name,
                    schema: ScholarshipSchema,
                }
            ],
        ),
    ],
    controllers: [ScholarshipController],
    providers: [ScholarshipService],

})
export class ScholarshipModule { }