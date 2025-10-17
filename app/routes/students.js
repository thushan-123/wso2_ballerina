const express = require("express");
const router = express.Router();


let students = [
  { id: 1, name: "Alice", age: 20, grade: "A" },
  { id: 2, name: "Bob", age: 22, grade: "B" },
];

// all student
router.get("/", (req, res) => {
  res.json(students);
});

//student by id
router.get("/:id", (req, res) => {
  const student = students.find((s) => s.id === parseInt(req.params.id));
  if (!student) return res.status(404).json({ message: "Student not found" });
  res.json(student);
});

// create new student
router.post("/", (req, res) => {
  const newStudent = {
    id: students.length ? students[students.length - 1].id + 1 : 1,
    name: req.body.name,
    age: req.body.age,
    grade: req.body.grade,
  };

  students.push(newStudent);
  res.status(201).json({ message: "Student added", student: newStudent });
});

// 🟢 Update student
router.put("/:id", (req, res) => {
  const index = students.findIndex((s) => s.id === parseInt(req.params.id));
  if (index === -1) return res.status(404).json({ message: "Student not found" });

  students[index] = { ...students[index], ...req.body };
  res.json({ message: "Student updated", student: students[index] });
});

// gelete student
router.delete("/:id", (req, res) => {
  const initialLength = students.length;
  students = students.filter((s) => s.id !== parseInt(req.params.id));

  if (students.length === initialLength)
    return res.status(404).json({ message: "Student not found" });

  res.json({ message: "Student deleted" });
});

module.exports = router;
