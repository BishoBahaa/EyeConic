import { Types } from "mongoose";
import joi from "joi";
const isValidObjectId = (value,helper) =>{
    if (Types.ObjectId.isValid(value)){
        return true;
    } else {
        return helper.message("Invalid objectid!");
    }
};
// create report
export const createreportSchema = joi.object({
    text: joi.string().required().custom(isValidObjectId),
}) 
.required();

