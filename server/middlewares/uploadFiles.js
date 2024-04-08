const cloudinary = require("cloudinary").v2;
const multer = require("multer");
const fs = require("fs");
const path = require("path");

cloudinary.config({
    cloud_name: process.env.CLOUD_NAME,
    api_key: process.env.CLOUDINARY_API_KEY,
    api_secret: process.env.CLOUDINARY_API_SECRET
});

const UPLOADS_DIR = path.join(__dirname, 'uploads');

if (!fs.existsSync(UPLOADS_DIR)) {
    fs.mkdirSync(UPLOADS_DIR);
}

const storage = multer.diskStorage({
    destination: (req, file, cb) => {
        cb(null, UPLOADS_DIR);
    }
});

const upload = multer({
    storage: storage,
    limits: { fileSize: 1024 * 1024 }, 
    fileFilter: (req, file, cb) => {
        const allowedMimes = ['image/jpeg', 'image/png', 'image/jpg'];
        if (allowedMimes.includes(file.mimetype)) {
            cb(null, true);
        } else {
            cb(new Error("Unsupported file format"), false);
        }
    }
});

const uploadToCloudinary = (req, res, next) => {
    upload.array('files')(req, res, async (err) => {
        if (err) {
            return res.status(400).json({ success: false, message: "Failed to upload images" });
        }

        try {
            const urls = [];

            for (const file of req.files) {
                const { path } = file;
                const result = await cloudinary.uploader.upload(path, { folder: "Images" });
                urls.push({ url: result.secure_url, id: result.public_id });
                fs.unlinkSync(path);
            }

            req.uploadedImages = urls;
            next();
        } catch (error) {
            console.error(error.message);
            res.status(500).json({ success: false, message: "Server Error" });
        }
    });
};

module.exports = uploadToCloudinary;
