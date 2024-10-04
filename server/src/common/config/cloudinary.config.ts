
// import { v2 as cloudinary } from 'cloudinary';
// import { ConfigService } from '@nestjs/config';

// const configService = new ConfigService();

// cloudinary.config({
//     cloud_name: configService.get('cloudinary.cloudName'),
//     api_key: configService.get('cloudinary.apiKey'),
//     api_secret: configService.get('cloudinary.apiSecret'),
// });

// export default cloudinary;
// export const CLOUDINARY = 'Cloudinary';

// import { v2 } from 'cloudinary';


// export const CloudinaryProvider = {
//   provide: CLOUDINARY,
//   useFactory: (): void => {
//     return v2.config({
//       cloud_name: 'Your cloud name',
//       api_key: 'Your api key',
//       api_secret: 'Your api secret',
//     });
//   },
// };
// src/config/cloudinary.config.ts
// import { v2 as cloudinary } from 'cloudinary';
// import { ConfigService } from '@nestjs/config';

// const configService = new ConfigService();

// cloudinary.config({
//     cloud_name: configService.get('cloudinary.cloudName'),
//     api_key: configService.get('cloudinary.apiKey'),
//     api_secret: configService.get('cloudinary.apiSecret'),
// });

// export default cloudinary;


// src/config/cloudinary.config.ts
// src/config/cloudinary.config.ts
import { v2 as cloudinary } from 'cloudinary';
import { ConfigService } from '@nestjs/config';

// Export the configureCloudinary function
export const configureCloudinary = () => {
    const configService = new ConfigService();

    cloudinary.config({
        cloud_name: configService.get('CLOUDINARY_CLOUD_NAME'),
        api_key: configService.get('CLOUDINARY_API_KEY'),
        api_secret: configService.get('CLOUDINARY_API_SECRET'),
    });

    return cloudinary; // Return the configured Cloudinary instance
};
