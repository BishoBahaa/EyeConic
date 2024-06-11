import express from"express"
import dotenv from "dotenv"
import { appRouter } from "./src/app.router.js"
import {connectDB} from "./DB/connection.js"
import cors from "cors"

dotenv.config()
const app = express()
app.use(cors())
const port = process.env.PORT

//DB
connectDB()

//routing
appRouter(app,express)


app.listen(port, () => console.log(`Example app listening on port ${port}!`))