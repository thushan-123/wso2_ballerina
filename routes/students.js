const express = require("express");
const fs = require("fs");
const path = require("path");

const router = express.Router();
const filePath = path.join(__dirname, "../data/students.json");


const readData = () => {
  const data = fs.readFileSync(filePath, "utf8");
  return JSON.parse(data);
};