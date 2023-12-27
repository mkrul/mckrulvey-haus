import express from 'express';
import path from 'path';
import env from "./util/validateEnv";
import { Pool } from 'pg';
import app from './app';

const pool = new Pool({
  user: env.DB_USER,
  host: env.DB_HOST,
  database: env.DB_NAME,
  password: env.DB_PASSWORD,
  port: Number(env.DB_PORT)
});

(async () => {
  const client = await pool.connect();

  if (env.NODE_ENV === 'staging' || env.NODE_ENV === 'production') {
    app.use(express.static(path.join(__dirname, '../../client/build')));
    app.get("*", (req, res) => {
      res.sendFile(path.join(__dirname, '../../client/build/index.html'));
    });
  }

  try {
    const { rows } = await client.query('SELECT current_user');
    const currentUser = rows[0]['current_user'];

    console.log(`Connected to database as ${currentUser}`);

    app.listen(env.PORT, () => {
      console.log(`Server listening on port ${env.PORT}`);
    });
  } catch (err) {
    console.error(err);
  } finally {
    client.release();
  }
})()
