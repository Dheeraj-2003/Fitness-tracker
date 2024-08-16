import { Router } from "express";
import helloRouter from "./hello_routes";
import openAiRouter from "./open_ai_routes";
import { openAiResponseController } from "../controllers/open_ai_controller";

const router:Router = Router();

router.use("/hello",helloRouter);
router.use("/generate_response",openAiRouter);

export default router 