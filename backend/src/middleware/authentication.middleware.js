import {asyncHandler} from "./../utils/asyncHandler.js"
import {Token} from "./../../DB/models/token.model.js"
import{Patient} from "./../../DB/models/patient.model.js"
import jwt from 'jsonwebtoken';
export const isAuthenticatedForPatient = asyncHandler(async(req,res,next) =>{
    
    //check token existence and type
    let token = req.headers["token"];
    if(!token || !token.startsWith(process.env.BEARER_KEY))
    return next(new Error("Valid token is required!",400));
    //check payload
    token = token.split(process.env.BEARER_KEY)[1];
    const decoded = jwt.verify(token, process.env.TOKEN_KEY);
    if(!decoded) return next(new Error("Invalid token!"));
    //check token in DB
    const tokenDB = await Token.findOne({token, isValid: true});
    if(!tokenDB) return next(new Error("Token expired!"));
    //check user existence
    const patient = await Patient.findOne({email:decoded.email});
    if(!patient) return next(new Error("Patient not found!"));
    //pass user
    req.patient = patient;
    //return next
    
    return next();
});