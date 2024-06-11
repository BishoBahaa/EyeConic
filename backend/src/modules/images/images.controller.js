import {  image } from "../../../DB/models/image.model.js";
import { asyncHandler } from "../../utils/asyncHandler.js";
import cloudnairy from "../../utils/cloud.js"; 

export const creatImage = asyncHandler(async (req ,res ,next) => {

    //file
    if (!req.file) return next(new Error("image is required!"));

    const {secure_url, public_id} = await cloudnairy.uploader.upload(
        req.file.path, {folder: `${process.env.FOLDER_CLOUD_NAME}/EyeImage`}
    );

    // save image in db
    const Image = await image.create({
        createdBy:req.patient._id,
        image:{id: public_id, url: secure_url}
    });
       // Associate the image with the patient
    req.patient.image.push(Image._id);
    await req.patient.save();
    
    // send response
    return res.status(201).json({success:true, results: Image});
})