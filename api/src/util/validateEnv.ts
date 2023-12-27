import { cleanEnv } from 'envalid';
import { str, port } from 'envalid/dist/validators';
import path from 'path';
import dotenv from "dotenv";

const environment = process.env.NODE_ENV || 'development';

dotenv.config({
  path: path.join(__dirname, `../../${environment}.env`),
});

export default cleanEnv(process.env, {
  DB_USER: str(),
  DB_HOST: str(),
  DB_NAME: str(),
  DB_PASSWORD: str(),
  NODE_ENV: str(),
  DB_PORT: port(),
  PORT: port(),
});