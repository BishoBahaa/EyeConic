import joi from "joi"
//doctor register
export const doctorRegisterSchema = joi.object({
    dFirstName: joi.string().min(3).max(20).required(),
    dLastName:  joi.string().min(3).max(20).required(),
    email: joi.string().email().required(),
    password: joi.string().required(),
    confirmPassword:joi.string().valid(joi.ref("password")).required(),
    address:joi.string().required(),
    qualifications : joi.string(),
    profileImage: joi.string(),
    gender:joi.string().required(),
    phone:joi.string().pattern(/^\+?[0-9]+$/).min(8).max(15).required(),
    birthday : joi.date().iso().max('now').required()
}).required() 

//doctor activation 

export const doctorActivateSchema = joi.object({
    activationCode: joi.string().required()
}).required()

//doctor login
export const doctorLoginSchema = joi.object({
    email: joi.string().email().required(),
    password: joi.string().required(),
})
.required();

// send forget code (for doctor)
export const doctorForgetcodeShema = joi.object({
    email: joi.string().email().required(),
})

//reset password  (for doctor)
export const doctorResetPasswordSchema = joi.object({
    email: joi.string().email().required(),
    forgetCode: joi.string().required(),
    password: joi.string().required(),
    confirmPassword: joi.string().valid(joi.ref("password")).required(),
}).required()