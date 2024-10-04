// src/config/multer.config.ts
import { CloudinaryStorage } from 'multer-storage-cloudinary';
import { configureCloudinary } from './cloudinary.config'; // Adjust the path as necessary

const cloudinary = configureCloudinary(); // Invoke the function to get the Cloudinary instance

const storage = new CloudinaryStorage({
    cloudinary: cloudinary, // Use the configured Cloudinary instance
    params: async (req, file) => {

        return {
            folder: 'Course Images',  // Specify your folder in Cloudinary
            format: 'png',            // Specify the format
            public_id: file.originalname // Use the original file name
        };
    },
});

export default storage;
