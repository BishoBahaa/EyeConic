import { asyncHandler } from "../../utils/asyncHandler.js";
import bcryptjs from "bcryptjs";
import crypto from "crypto";
import {Patient} from "./../../../DB/models/patient.model.js";
import {Doctor} from "./../../../DB/models/doctor.model.js";
import {sendEmail} from "../../utils/sendEmails.js";
import {resetPassTemp, signUpTemp} from "./../../utils/generateHTML.js";
import jwt from "jsonwebtoken";
import { Token } from "../../../DB/models/token.model.js";
import randomstring from "randomstring";
//register
export const register = asyncHandler(async(req,res,next)=>{
    
    //data from request
    const {pFirstName,pLastName,email,password,gender,phone,birthday} = req.body
    //check user existence
    const isPatient = await Patient.findOne({email})
    if(isPatient) return next(new Error("Email already registered!",{cause: 409}))
    //hash password
    const hashPassword = bcryptjs.hashSync(password,Number(process.env.SALT_ROUND))
    //generate activationCode
    const activationCode = crypto.randomBytes(64).toString("hex")

    // create patient
    const patient = await Patient.create({pFirstName,pLastName,email,password:hashPassword,activationCode,gender,phone,birthday})
    //create confirmationlink
    const link = `http://localhost:3000/patient/confirmEmail/${activationCode}`

    //send email
    const isSent = await sendEmail({to: email, subject: "Activate Account", html: signUpTemp(link)})

    //send response

    return isSent ? res.json({success:true , message:"Please review your email!"}) : next(new Error("Somthing went wrong!"))

})

//activationAccount
export const activateAccount = asyncHandler(async(req,res,next)=>{
    
    //find user , delete the activation code , update isComfirmed
    const patient = await Patient.findOneAndUpdate({activationCode:req.params.activationCode},
        {isConfirmed:true ,$unset:{activationCode: 1}})
    
    
    //check if the user doesnt exist
    if(!patient) {return next(new Error("User not found!"),{cause:404})}
    return res.send("Congratulations,your account is now activated!,try to login now")  //redirect to login page
})

//login
export const login = asyncHandler(async (req,res,next) => {
    //data from requests
    const {email,password} = req.body;
    //check user existence
    const patient = await Patient.findOne({email});
    if(!patient) return next(new Error("Invalid Email!",{cause:400}));

    //check isConfirmed
    if(!patient.isConfirmed) return next(new Error("Unactivated account!" , {cause:400}));

    // check password
    const match = bcryptjs.compareSync(password, patient.password);
    if(!match) return next(new Error("Invalid Password!",{cause:400}));

    //generate token 
    const token = jwt.sign({id: patient._id, email:patient.email},process.env.TOKEN_KEY,
        {
            expiresIn: "2d",
        });
    //save token in token model
    await Token.create({
        token,
        patient:patient._id,
        agent: req.headers["user-agent"],

    });
    //change patient status to online and save patient
    patient.status = "online";
    await patient.save();
    //send response
    return res.json({ success: true, results: token});    
})

//send forget code
export const sendForgetCode = asyncHandler(async(req,res,next)=>{

    //check user
    const patient = await Patient.findOne({email: req.body.email})
    if(!patient) return next(new Error("Invalid email!"));
    
    //generate code
    const code = randomstring.generate({
        length:5,
        charset: "numeric",
    });

    // save code in db
    patient.forgetCode = code;
    await patient.save();

    //send email
    return await sendEmail({to: patient.email, subject: "reset password",html: resetPassTemp(code)})
    ? res.json({success: true,message: "check your email"}) : next(new Error("somthing went wrong!"));
});

//resetpassword
export const resetPassword = asyncHandler(async(req,res,next)=>{
    //check user
    let patient = await Patient.findOne({email:req.body.email});
    if(!patient) return next(new Error("Invalid Email"));

    // check code
    if(patient.forgetCode !== req.body.forgetCode)
        return next(new Error("Invalid code!"));

    patient = await Patient.findOneAndUpdate({email:req.body.email}, {$unset: { forgetCode: 1}});

    patient.password = bcryptjs.hashSync(
        req.body.password,
        Number(process.env.SALT_ROUND)
    );

    await patient.save();

    //invalidate tokens    //logout from all devices
    const tokens = await Token.find({patient:patient._id});

    tokens.forEach(async (token)=>{
        token.isValid = false;
        await token.save();
    });

    // send response
    return res.json({ success: true, message: "try to login!"});
})

//choose doctor and push it to doctor
export const chooseDoctor = asyncHandler(async (req, res) =>{
    const { doctorId } = req.params;

       // Find the patient by ID
    const patient = await Patient.findById(req.patient._id);

       // Check if the patient exists
    if (!patient) {
        return res.status(404).json({ error: 'Patient not found' });
    }

       // If the patient has already chosen a doctor, remove them from the doctor's list of patients
        if (patient.chosenDoctor) {
        const previousDoctor = await Doctor.findById(patient.chosenDoctor);
        if (previousDoctor) {
            previousDoctor.patients = previousDoctor.patients.filter(id => id.toString() !== req.patient._id);
            await previousDoctor.save();
        }
    }

       // Assign the chosen doctor to the patient
        patient.chosenDoctor = doctorId;
        await patient.save();

       // Find the doctor by ID
        const doctor = await Doctor.findById(doctorId);

       // Check if the doctor exists
        if (!doctor) {
        return res.status(404).json({ error: 'Doctor not found' });
    }

       // Add the patient to the new doctor's list of patients
    doctor.patients.push(req.patient._id);
    await doctor.save();

    res.status(200).json({ message: 'Doctor chosen successfully', patient });
});


// get all patients
export const allPatients = asyncHandler(async(req,res,next)=>{
    const patients = await Patient.find();
    return res.json({ success: true, results: patients});
});