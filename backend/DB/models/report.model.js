import mongoose, {model, Schema} from "mongoose";

//schema 
const reportsSchema = new Schema({
    report: [{type: String, required:true}],
    patient: { type: mongoose.Schema.Types.ObjectId, ref: 'Patient' },
    doctor: { type: mongoose.Schema.Types.ObjectId, ref: 'Doctor' }

}

,
    {timestamps: true}
);
//model
export const report = mongoose.models.report || model("report",reportsSchema);

