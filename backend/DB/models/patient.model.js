import mongoose, { Schema , model} from "mongoose"


//schema
const PatientSchema = new Schema({
    pFirstName : {
        type: String,
        required:true,
        min:3,
        max:20 
    },
    pLastName : {
        type: String,
        required:true,
        min:3,
        max:20 
    },
    email :{
        type: String,
        unique: true,
        required:true,
        lowercase:true
    },
    password: {
        type: String,
        required: true 
    },
    gender: {
        type: String,
        enum: ["Male","Female"]
    },
    phone:{
        type: String
    },
    birthday:Date,
    
    status: {
        type: String,
        enum: ["online","offline"],
        default:"offline"
    },
    isConfirmed:{
        type:Boolean,
        default:false
    },forgetCode:String,
    activationCode:String,
    role: {
        type: String,
        default: 'patient', // Default role for patients
        
    },
    image: [{ type: mongoose.Schema.Types.ObjectId, ref: 'image' }],
    report: [{ type: mongoose.Schema.Types.ObjectId, ref: 'report' }],
    chosenDoctor:String,
    
    

},{timestamps : true})

//model
export const Patient = mongoose.models.Patient || model("Patient" , PatientSchema)

