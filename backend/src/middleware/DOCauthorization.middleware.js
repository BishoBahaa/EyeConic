import { asyncHandler } from "../utils/asyncHandler.js";

export const isAuthorizedforDoc = (role) =>{
    return asyncHandler( async (req, res, next) =>{
        //check user
        if(role !== req.doctor.role)
        
        
            return next(new Error("you are not doctor!there is no access",{ cause:403}));
        return next();
        
    });
};