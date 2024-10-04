export default () => ({
    database: {
        connectionString: process.env.DB_CONNECTION_STRING,
    },
    jwt: {
        secret: process.env.JWT_SECRET,
    },
    emailService: {
        host: process.env.SMTP_HOST,
        port: parseInt(process.env.SMTP_PORT, 587),
        user: process.env.SMTP_USER,
        pass: process.env.SMTP_PASS,
    },
    default: {
        name: process.env.APP_NAME,
        address: process.env.DEFAULT_MAIL_FROM,
    },
    cloudinary: {
        cloudName: process.env.CLOUDINARY_CLOUD_NAME,
        apiKey: parseInt(process.env.CLOUDINARY_API_KEY),
        apiSecret: process.env.CLOUDINARY_API_SECRET,
    },
});
