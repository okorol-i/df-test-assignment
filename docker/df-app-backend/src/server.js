const express = require("express");
const { Client } = require("pg");

const app = express();
const port = process.env.PORT || 8000;

app.get("/health", async (_req, res) => {
  const client = new Client({
    host: process.env.DB_HOST,
    port: Number(process.env.DB_PORT || 5432),
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_NAME,
  });

  try {
    await client.connect();
    const result = await client.query("SELECT NOW() AS now");
    await client.end();

    res.json({
      status: "ok",
      message: "Backend is healthy and PostgreSQL is reachable.",
      dbTime: result.rows[0].now,
    });
  } catch (error) {
    res.status(500).json({
      status: "error",
      message: "Could not connect to PostgreSQL.",
      details: error.message,
    });
  }
});

app.listen(port, () => {
  console.log(`Backend listening on port ${port}`);
});
