const express = require("express");
const bodyParser = require("body-parser");
const logger = require("./middleware/logger");
const studentRoutes = require("./routes/students");

const app = express();
const PORT = 3000;

app.use(bodyParser.json());
app.use(logger);

app.use("/api/students", studentRoutes);

app.get("/", (req, res) => {
  res.send("Welcome to Student API 🚀");
});


app.listen(PORT, () => {
  console.log(`Server running on http://localhost:${PORT}`);
});