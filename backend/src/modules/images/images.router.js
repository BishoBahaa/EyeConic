import {Router} from "express";
import { isValid } from "../../middleware/validation.middleware.js";
import { createImageSchema } from "./images.validation.js";
import { isAuthenticatedForPatient } from "../../middleware/authentication.middleware.js";
import { isAuthorized } from "../../middleware/authorization.middleware.js";
import { fileUpload } from "../../utils/multer.js";
import { creatImage } from "./images.controller.js";

const router = Router();

//CRUD
// create image
router.post("/",
isAuthenticatedForPatient,
isAuthorized("patient"),
fileUpload().single("image"),  //form data
isValid(createImageSchema),
creatImage)


export default router;

