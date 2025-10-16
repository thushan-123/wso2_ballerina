const express = require("express");
const fs = require("fs");
const path = require("path");

const router = express.Router();
const filePath = path.join(__dirname, "../data/students.json");


const readData = () => {
  const data = fs.readFileSync(filePath, "utf8");
  return JSON.parse(data);
};

const writeData = (data) => {
  fs.writeFileSync(filePath, JSON.stringify(data, null, 2));
};


router.get("/", (req, res) => {
  const students = readData();
  res.json(students);
});

//student by ID
router.get("/:id", (req, res) => {
  const students = readData();
  const student = students.find((s) => s.id === parseInt(req.params.id));

  if (!student) return res.status(404).json({ message: "Student not found" });

  res.json(student);
});


//create new student
router.post("/", (req, res) => {
  const students = readData();
  const newStudent = {
    id: students.length ? students[students.length - 1].id + 1 : 1,
    name: req.body.name,
    age: req.body.age,
    grade: req.body.grade,
  };

  students.push(newStudent);
  writeData(students);

  res.status(201).json({ message: "Student added", student: newStudent });
});

//update student
router.put("/:id", (req, res) => {
  const students = readData();
  const index = students.findIndex((s) => s.id === parseInt(req.params.id));

  if (index === -1) return res.status(404).json({ message: "Student not found" });

  students[index] = { ...students[index], ...req.body };
  writeData(students);

  res.json({ message: "Student updated", student: students[index] });
});

// delete student
router.delete("/:id", (req, res) => {
  const students = readData();
  const filtered = students.filter((s) => s.id !== parseInt(req.params.id));

  if (filtered.length === students.length)
    return res.status(404).json({ message: "Student not found" });

  writeData(filtered);
  res.json({ message: "Student deleted" });
});

module.exports = router;