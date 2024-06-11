import { asyncHandler } from "../../utils/asyncHandler.js";
import bcryptjs from "bcryptjs";
import crypto from "crypto";
import {Doctor} from "./../../../DB/models/doctor.model.js";
import {sendEmail} from "../../utils/sendEmails.js";
import {resetPassTemp, signUpTemp} from "./../../utils/generateHTML.js";
import jwt from "jsonwebtoken";
import { Token } from "../../../DB/models/token.model.js";
import randomstring from "randomstring";
import { Patient } from "../../../DB/models/patient.model.js";
import cloudnairy from "./../../utils/cloud.js"; 
//doctor register
export const doctorRegister = asyncHandler(async(req,res,next)=>{
    //data from request
    const {dFirstName,dLastName,email,password,gender,phone,birthday,qualifications,address} = req.body
    //check user existence
    const isDoctor = await Doctor.findOne({email})
    if(isDoctor) return next(new Error("Email already registered!",{cause: 409}))
    //hash password
    const hashPassword = bcryptjs.hashSync(password,Number(process.env.SALT_ROUND))
    //generate activationCode
    const activationCode = crypto.randomBytes(64).toString("hex")

    let profileImage = {
        url: "https://res.cloudinary.com/dz8am1i8t/image/upload/v1709753928/Default_avatar_profile_icon_vector_image_on_VectorStock_fzu64z.jpg",
        id: "Default_avatar_profile_icon_vector_image_on_VectorStock_fzu64z"
    };
  // Upload the profile image to Cloudinary if provided
    if (req.file) {
    const result = await cloudnairy.uploader.upload(
        req.file.path, { folder: `${process.env.FOLDER_CLOUD_NAME}/DocProfilePic` }
    );
    profileImage = {
        url: result.secure_url,
        id: result.public_id,
    };
}


    // create doctor
    const doctor = await Doctor.create({dFirstName,dLastName,email,password:hashPassword,activationCode,
        gender,phone,birthday,qualifications,address,profileImage})
        await doctor.save();
        
    //create confirmationlink
    const link = `http://localhost:3000/doctor/confirmEmail/${activationCode}`

    //send email
    const isSent = await sendEmail({to: email, subject: "Activate Account", html: signUpTemp(link)})

    //send response

    return isSent ? res.json({success:true , message:"Please review your email!"}) : next(new Error("Somthing went wrong!"))

})

//ClinicPassword
export const ClinicPassword = asyncHandler(async(req,res,next)=>{
    const {clinicPassword } = req.body;

    // Check if clinic password matches
    if (clinicPassword !== process.env.CLINIC_PASSWORD) {
        console.log(clinicPassword)
        console.log( process.env.CLINIC_PASSWORD)
        return res.status(401).json({ error: 'Invalid clinic password' });
    }
    res.status(200).json({ message: 'Welcome to Eyeconic!...continue for registration' });
});

//doctor activationAccount
export const doctorActivateAccount = asyncHandler(async(req,res,next)=>{
    
    //find user , delete the activation code , update isComfirmed
    const doctor = await Doctor.findOneAndUpdate({activationCode:req.params.activationCode},
        {isConfirmed:true,$unset:{activationCode: 1}},{new:true})
    
    
    //check if the user doesnt exist
    if(!doctor) {return next(new Error("Doctor not found!"),{cause:404})}
    return res.send("Congratulations,your account is now activated!,try to login now")  //redirect to login page
})

//doctor login
export const doctorLogin = asyncHandler(async (req,res,next) => {
    //data from requests
    const {email,password} = req.body;
    //check user existence
    const doctor = await Doctor.findOne({email});
    if(!doctor) return next(new Error("Invalid Email!",{cause:400}));

    //check isConfirmed
    if(!doctor.isConfirmed) return next(new Error("Unactivated account!" , {cause:400}));

    // check password
    const match = bcryptjs.compareSync(password, doctor.password);
    if(!match) return next(new Error("Invalid Password!",{cause:400}));

    //generate token 
    const token = jwt.sign({id: doctor._id, email:doctor.email},process.env.TOKEN_KEY,
        {
            expiresIn: "2d",
        });
    //save token in token model
    await Token.create({
        token,
        doctor:doctor._id,
        agent: req.headers["user-agent"],

    });
    //change patient status to online and save patient
    doctor.status = "online";
    await doctor.save();
    //send response
    return res.json({ success: true, results: token});    
})

//send forget code (for doctor)
export const sendForgetCodeForDoctor = asyncHandler(async(req,res,next)=>{

    //check user (doctor)
    const doctor = await Doctor.findOne({email: req.body.email})
    if(!doctor) return next(new Error("Invalid email!"));
    
    //generate code
    const code = randomstring.generate({
        length:5,
        charset: "numeric",
    });

    // save code in db
    doctor.forgetCode = code;
    await doctor.save();

    //send email
    return await sendEmail({to: doctor.email, subject: "reset password",html: resetPassTemp(code)})
    ? res.json({success: true,message: "check your email"}) : next(new Error("somthing went wrong!"));
});

//resetpassword
export const resetPasswordForDoctor = asyncHandler(async(req,res,next)=>{
    //check user
    let doctor = await Doctor.findOne({email:req.body.email});
    if(!doctor) return next(new Error("Invalid Email"));

    // check code
    if(doctor.forgetCode !== req.body.forgetCode)
        return next(new Error("Invalid code!"));

        doctor = await Doctor.findOneAndUpdate({email:req.body.email}, {$unset: { forgetCode: 1}});

        doctor.password = bcryptjs.hashSync(
        req.body.password,
        Number(process.env.SALT_ROUND)
    );

    await doctor.save();

    //invalidate tokens    //logout from all devices
    const tokens = await Token.find({docotr:doctor._id});

    tokens.forEach(async (token)=>{
        token.isValid = false;
        await token.save();
    });

    // send response
    return res.json({ success: true, message: "try to login!"});
})

// get all doctor
export const allDoctor = asyncHandler(async(req,res,next)=>{
    const doctors = await Doctor.find();
    return res.json({ success: true, results: doctors});
});






// Logic to retrieve a doctor's patient history
export const getDoctorHistory = asyncHandler(async (req, res) => {
    
    
    // Find the doctor by ID and populate with selected fields
    const doctor = await Doctor.findById(req.doctor._id).populate({
        path: 'patients',
        select: 'pFirstName pLastName email image report', // Add other fields as needed
    });
    
    if (!doctor) {
        return res.status(404).json({ error: 'Doctor not found' });
    }
    
    // Check if there are no patients associated with the doctor
    if (doctor.patients.length === 0) {
        return res.status(200).json({ message: 'No patients associated with this doctor yet'});
    }
    
    // Extract only patient information
    const patientHistory = doctor.patients.map(patient => {
        return {
            
            pFirstName: patient.pFirstName,
            pLastName: patient.pLastName,
            email:patient.email,
            image:patient.image,
            report:patient.report,
            
            // Add other patient fields as needed
        };
    });
    
    res.status(200).json({ doctor: { DoctorName: `${doctor.dFirstName} ${doctor.dLastName}`}, patientHistory });
});

