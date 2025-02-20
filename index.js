const express = require("express");
const PORT = 8080;
require("dotenv").config();

const app = express();

app.get("/", (request, response) => {
  try {
    response.send(
      "Hello World"
    );
  } catch (error) {
    return response.status(500).json({ error: error.message });
  }
});

app.use(require("./routes/managerRoutes"));

app.listen(PORT, () => console.log(`server is running on ${PORT}`));
