import multer from "multer"
export const filterObject = {
    
    pdf:["application/pdf"]
}

// Define a function to filter image files
const imageFilter = (req, file, cb) => {
    // Check if the file is an image
    if (!file.mimetype.startsWith('image/')) {
        // Reject file if it's not an image
        return cb(new Error('Invalid file format. Only images are allowed.'), false);
    }
    // Accept file if it's an image
    cb(null, true);
};

// Configure multer to use disk storage and the image filter
export const fileUpload = () => {
    return multer({
        storage: multer.diskStorage({}),
        fileFilter: imageFilter
    });
};