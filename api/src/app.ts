import "dotenv/config";
import express from "express";
import * as ReptileRoutes from "./routes/reptiles";

const cors = require("cors");

const app = express();
app.use(cors());

app.get("/", (req, res) => {
  res.send("Hello World!");
});

app.use(ReptileRoutes.router);

export default app;