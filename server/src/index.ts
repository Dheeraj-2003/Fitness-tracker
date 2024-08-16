import express, { Express } from "express";
import http from  "http";
import cors from "cors";
import dotenv from "dotenv";
import bodyParser from "body-parser";
import router from "./routes/routes";

require('dotenv').config();
const app: Express = express();
dotenv.config({path: 'C:/Users/HP/FlutterProjects/chat_gpt/server/config.env'});
const server = http.createServer(app);

app.use(cors());
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({extended: true}));
app.set("PORT",3000);
app.set("BASE_URL","localhost");
app.use("/api/v1",router);


try{
    const port: number = app.get("PORT");
    server.listen(port,(): void => {
        console.log(`Server is listening on PORT ${port}`);
    })
} catch(err){
    console.log(err);
}

export default server;