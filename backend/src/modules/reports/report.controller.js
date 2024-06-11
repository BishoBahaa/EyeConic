import {  report } from "../../../DB/models/report.model.js";
import { asyncHandler } from "../../utils/asyncHandler.js";
import cloudnairy from "./../../utils/cloud.js"; 

export const createReport = asyncHandler(async (req ,res ,next) => {

    //file
    if (!req.file) return next(new Error("report is required!"));

    const {secure_url, public_id} = await cloudnairy.uploader.upload(
        req.file.path, {folder: `${process.env.FOLDER_CLOUD_NAME}/report`}
    );

    // save report in db
    const Report = await report.create({
        createdBy:req.report._id,
        report:{id: public_id, url: secure_url}
    });
    // Associate the report with the patient
    req.patient.report.push(report._id);
    await req.patient.save();
    // send response
    return res.status(201).json({success:true, results: Report});
})