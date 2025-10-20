import ballerina/http;
import ballerina/log;

// Use the service name 'express-api' for container-to-container communication.
final string API_URL = "http://express-api:3000/api/students";
final string HOME_URL = "http://express-api:3000";


final http:Client stuApiClient = check new (API_URL, {
    timeout: 10
});

final http:Client homeEntry = check new (HOME_URL, {
    timeout: 10
});

service /studentService on new http:Listener(9090) {

    resource function get .() returns json|error {
        log:printInfo("Requesting home page from express-api");
        json home = check homeEntry->get("/");
        return home;
    }

    resource function get getAll() returns json|error {
        log:printInfo("Requesting all students from express-api");
        return fetchAllStudents();
    }

    resource function get getById(string id) returns json|error {
        log:printInfo("Requesting student by ID from express-api: " + id);
        return fetchStudentById(id);
    }

    resource function post createStudent(@http:Payload json studentData) returns json|error {
        log:printInfo("Creating a new student via express-api");
        return createNewStudent(studentData);
    }

    resource function put updateStudent(string id, @http:Payload json studentUpdateData) returns json|error {
        log:printInfo("Updating student via express-api: " + id);
        return updateExistingStudent(id, studentUpdateData);
    }

    resource function delete deleteStudent(string id) returns json|error {
        log:printInfo("Deleting student via express-api: " + id);
        return deleteStudentById(id);
    }
}

function fetchAllStudents() returns json|error {
    json students = check stuApiClient->get("/");
    return students;
}

function fetchStudentById(string id) returns json|error {
    json student = check stuApiClient->get("/" + id);
    return student;
}

function createNewStudent(json studentData) returns json|error {
    json studentCreate = check stuApiClient->post("/", studentData);
    return studentCreate;
}

function updateExistingStudent(string id, json studentUpdateData) returns json|error {
    json studentUpdate = check stuApiClient->put("/" + id, studentUpdateData);
    return studentUpdate;
}

function deleteStudentById(string id) returns json|error {
    json studentDel = check stuApiClient->delete("/" + id);
    return studentDel;
}
