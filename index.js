const express = require("express");
require("dotenv").config();

const authRoutes = require("./routes/authRoutes");

const app = express();
const PORT = 8080;

app.use(express.json());
app.use("/user", authRoutes);

app.get("/", (req, res) => {
  res.send("Hello World");
});

app.listen(PORT, () => {
  console.log(`서버 실행 중: http://localhost:${PORT}`);
});
