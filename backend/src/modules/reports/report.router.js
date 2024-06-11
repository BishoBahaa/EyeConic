import {Router} from "express";
import { isValid } from "../../middleware/validation.middleware.js";
import { createreportSchema } from "./report.validation.js";
import { isAuthenticatedForPatient } from "../../middleware/authentication.middleware.js";
import { isAuthorized } from "../../middleware/authorization.middleware.js";
import { fileUpload, filterObject } from "../../utils/multer.js";
import { createReport } from "./report.controller.js";

const router = Router();

//CRUD
// create report
router.post("/",
isAuthenticatedForPatient,
isAuthorized("doctor"),
fileUpload(filterObject.report).single("report"),  //form data
isValid(createreportSchema),
createReport)


export default router;