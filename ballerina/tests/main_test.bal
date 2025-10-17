import ballerina/http;
import ballerina/test;

// final map<json> mockDB = {
//     "1": { name: "Kamal", age: 24, grade: "B" }
// };

// function getAllStudents() returns json {
//     return mockDB;
// }

// function getStudentById(string id) returns json|error {
//     if mockDB.hasKey(id) {
//         return mockDB[id];
//     }
//     return error("Student not found");
// }

// function createStudent(json student) returns string {
//     string newId = "2";
//     mockDB[newId] = student;
//     return newId;
// }

// function updateStudent(string id, json student) returns boolean|error {
//     if mockDB.hasKey(id) {
//         mockDB[id] = student;
//         return true;
//     }
//     return error("Student not found");
// }

// function deleteStudent(string id) returns boolean|error {
//     if mockDB.hasKey(id) {
//         json _ = mockDB.remove(id);
//         return true;
//     }
//     return error("Student not found");
// }

final string BALL_TEST_URL = "http://localhost:9090/studentService";

final http:Client clientTest = check new(BALL_TEST_URL);

@test:Config {}     // home page
function testHome() returns error? {
    http:Response res = check clientTest->get("/");
    test:assertEquals(res.statusCode,200, msg = "200 ok /");
}

@test:Config {}    // getAll student
function testGetAll() returns error? {
    http:Response res = check clientTest->get("/getAll");
    test:assertEquals(res.statusCode,200, msg = "pass 200 ok /getAll");
}

@test:Config {}
function testGetById() returns error? {
    http:Response res = check clientTest->get("/getById/1");
    test:assertEquals(res.statusCode, 200, msg = "pass 200 ok /getById");
}

@test:Config {}
function testCreateStudent() returns error? {
    json student = {
        name : "kamal",
        age: 24,
        grade: "B"
    };

    http:Response res = check clientTest->post(
        "/createStudent",
        student
    );

    test:assertEquals(res.statusCode, 200, msg = "pass 200 ok /createStudent");
}

@test:Config {}
function testUpdateStudent() returns error? {
    json student = {
        name: "nimal",
        age: 23,
        grade: "A"
    };
    // student id -> 1
    http:Response res = check clientTest->put(
        "/updateStudent/1",
        student
    );
    test:assertEquals(res.statusCode,200, msg = "pass 200 ok updateStudent");
}

@test:Config {}
function testDeleteStudent() returns error? {
    http:Response res = check clientTest->delete("/deleteStudent/1");
    test:assertEquals(res.statusCode, 200, msg = "pass 200 ok deleteStudent");
}

