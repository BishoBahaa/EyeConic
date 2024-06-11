import mongoose from "mongoose"

export const connectDB = async ()=>{
    await mongoose.connect(process.env.CONNECTION_URL).then(()=>console.log("DB connected"))
    .catch(()=>console.log("somthing went wrong!"))
}