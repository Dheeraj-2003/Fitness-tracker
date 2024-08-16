import { Request, Response } from "express";
import dotenv from "dotenv";
import OpenAI from "openai";
dotenv.config({path: 'C:/Users/HP/FlutterProjects/chat_gpt/server/config.env'});

const api_key = process.env.OPENAI_API_KEY

const openai = new OpenAI({
  apiKey: api_key,
});

export const openAiResponseController = async (req: Request, res: Response) => {
  try {
    const reqBody = req.body;
    const messages = reqBody['messages'];
    const stream = await openai.chat.completions.create({
        model: "gpt-3.5-turbo",
        messages: messages,
        temperature: 1,
        max_tokens: 256,
        top_p: 1,
        frequency_penalty: 0,
        presence_penalty: 0,
        stream: true
      });

    res.set({"Content-Type": "text/event-stream"});
    
    for await (const chunk of stream){
        const data = chunk.choices[0].delta.content || "";
        const response = `data: ${JSON.stringify({data})}\n\n`
        res.write(response);
    }
  } catch (error) {
    res.status(500).json({ data: error });
  }
};
