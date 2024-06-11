import mongoose,{Schema,Types,model} from "mongoose"

//schema
const tokenSchema = new Schema({
    token:{
        type: String,
        required: true
    },
    Patient: {
        type: Types.ObjectId,
        ref:"Patient"
    },
    Doctor: {
        type: Types.ObjectId,
        ref:"Doctor"
    },
    isValid:{
        type:Boolean,
        default:true
    },
    agent: { //name
        type: String
    },
    expiredAt:{type:String}
},{timestamps: true})

//model
export const Token = mongoose.model.Token || model("Token",tokenSchema)