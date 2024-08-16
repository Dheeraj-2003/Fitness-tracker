import { Router, Request, Response } from "express";
import { openAiResponseController } from "../controllers/open_ai_controller";

const openAiRouter = Router();

openAiRouter.post("/",openAiResponseController);

export default openAiRouter;