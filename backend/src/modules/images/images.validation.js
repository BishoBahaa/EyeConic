import { Types } from "mongoose";
import joi from "joi";
const isValidObjectId = (value,helper) =>{
    if (Types.ObjectId.isValid(value)){
        return true;
    } else {
        return helper.message("Invalid objectid!");
    }
};
// create image
export const createImageSchema = joi.object({
    createdBy:joi.string().custom(isValidObjectId),
}) 
.required();



