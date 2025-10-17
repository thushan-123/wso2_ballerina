import ballerina/http;
import ballerina/log;

final string API_URL = "http://localhost:3000/api/students";

final string HOME_URL = "http://localhost:3000";

final http:Client stuApiClient = check new (API_URL, {
    timeout: 10
});

final http:Client homeEntry = check new (HOME_URL, {
    timeout: 10
});

service /studentService on new http:Listener(9090) {

    resource function get .() returns json|error {
        log:printInfo("Requesting home page");
        return getHomePage();
    }

    resource function get getAll() returns json|error {
        return fetchAllStudents();
    }

    resource function get getById(string id) returns json|error {
        return fetchStudentById(id);
    }

    resource function post createStudent(@http:Payload json studentData) returns json|error {
        return createNewStudent(studentData);
    }

    resource function put updateStudent(string id, @http:Payload json studentUpdateData) returns json|error {
        return updateExistingStudent(id, studentUpdateData);
    }

    resource function delete deleteStudent(string id) returns json|error {
        return deleteStudentById(id);
    }
}

function getHomePage() returns json|error {
    json home = check homeEntry->get("/");
    return home;
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
