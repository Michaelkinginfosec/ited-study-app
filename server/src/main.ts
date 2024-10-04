import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import 'dotenv/config';
import { ValidationPipe } from '@nestjs/common';


async function bootstrap() {
  const app = await NestFactory.create(AppModule);
  //enable cors
  app.enableCors(

  )
  //global validation pips
  app.useGlobalPipes(new ValidationPipe({
    transform: true,
    whitelist: true,
    forbidNonWhitelisted: true,
  }))
  //global prefix
  app.setGlobalPrefix('api/v1');
  await app.listen(3000);
}
bootstrap();
