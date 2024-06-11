import mongoose, {Types,model, Schema} from "mongoose";

//schema 
const imageSchema = new Schema({
    slug: {type:String},
    image:{
        url: {type: String, required:true},
        id: {type: String, required:true},
    },
    createdBy: {type: Types.ObjectId, ref:"Patient", required: true},
},
    {timestamps: true}
);
//model
export const image = mongoose.models.image || model("image",imageSchema);