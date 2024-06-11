import joi from "joi"
//register
export const registerSchema = joi.object({
    pFirstName: joi.string().min(3).max(20).required(),
    pLastName:  joi.string().min(3).max(20).required(),
    email: joi.string().email().required(),
    password: joi.string().required(),
    confirmPassword:joi.string().valid(joi.ref("password")).required(),
    gender:joi.string().required(),
    phone:joi.string().pattern(/^\+?[0-9]+$/).min(8).max(15).required(),
    birthday : joi.date().iso().max('now')
    
}).required() 

//activation 

export const activateSchema = joi.object({
    activationCode: joi.string().required()
}).required()

//login
export const loginSchema = joi.object({
    email: joi.string().email().required(),
    password: joi.string().required(),
})
.required();

// send forget code
export const forgetcodeShema = joi.object({
    email: joi.string().email().required(),
})

//reset password
export const resetPasswordSchema = joi.object({
    email: joi.string().email().required(),
    forgetCode: joi.string().required(),
    password: joi.string().required(),
    confirmPassword: joi.string().valid(joi.ref("password")).required(),
}).required()