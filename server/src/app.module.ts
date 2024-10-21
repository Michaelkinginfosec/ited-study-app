import { MiddlewareConsumer, Module, NestModule } from '@nestjs/common';
import { MongooseModule } from '@nestjs/mongoose';
import { ConfigModule, ConfigService } from '@nestjs/config';
import Configuration from './common/config/config'
import { AdminModule } from './admin/admin.module';
import { AuthModule } from './auth/auth.module';
import { JwtModule } from '@nestjs/jwt';
import { ThrottlerModule, ThrottlerGuard } from '@nestjs/throttler';
import { APP_GUARD } from '@nestjs/core';
import { UserModule } from './users/user.module';
import { EmailService } from './common/service/mail.service';
import { OTPVerificationMiddleware } from './common/middleware/otp-verification.middleware';
import { SendVerificationCode, SendVerificationCodeSchema } from './users/schema/otp.schema';
import { NotesModule } from './notes/notes.module';
import { configureCloudinary } from './common/config/cloudinary.config';
import { PastQuestionModule } from './questions/past-question.module';
import { ScholarshipModule } from './scholarship/scholarship.module';



@Module({
  imports: [

    ConfigModule.forRoot({
      load: [Configuration,],
      isGlobal: true,
    }),
    JwtModule.registerAsync({
      imports: [ConfigModule],
      useFactory: async (config) => ({
        secret: config.get('jwt.secret')
      }),
      global: true,
      inject: [ConfigService]
    }),
    MongooseModule.forFeature([
      {
        name: SendVerificationCode.name,
        schema: SendVerificationCodeSchema
      }
    ]),
    MongooseModule.forRootAsync({
      imports: [ConfigModule],
      useFactory: async (config) => ({
        uri: config.get('database.connectionString'),
      }),

      inject: [ConfigService],
    }),
    ThrottlerModule.forRoot([
      {

        ttl: 60000,
        limit: 100
      }
    ]),
    AdminModule,
    AuthModule,
    UserModule,
    NotesModule,
    PastQuestionModule,
    ScholarshipModule,
  ],
  providers: [
    EmailService,
    OTPVerificationMiddleware,
    {
      provide: APP_GUARD,
      useClass: ThrottlerGuard,
    },
    {
      provide: 'CLOUDINARY', // Provide the configured Cloudinary instance
      useValue: configureCloudinary(), // Use the configureCloudinary function
    },],
  exports: [EmailService],
  controllers: [],

})
export class AppModule implements NestModule {
  configure(consumer: MiddlewareConsumer) {
    consumer
      .apply(OTPVerificationMiddleware)
      .forRoutes('users/verify-otp');
  }
}