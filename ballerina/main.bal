import ballerina/http;

final string API_URL = "http://localhost:3000/api/students";

final http:Client stuApiClient = check new (API_URL, {
    timeout: 10
});

service /studentService on new http:Listener(9090) {

    resource function get getAll() returns json|error {
        json students = check stuApiClient->get("/");
        return students;
    }

    resource function get getById(string id) returns json|error {
        json student = check stuApiClient->get("/" + id);
        return student;
    }

    resource function post createStudent(@http:Payload json studentData) returns json|error {
        json studentCreate = check stuApiClient->post("/", studentData);
        return studentCreate;
    }

    resource function put updateStudent(string id, @http:Payload json studentUpdateData) returns json|error {
        json studentUpdate = check stuApiClient->put("/" + id, studentUpdateData);
        return studentUpdate;
    }

    resource function delete deleteStudent(string id) returns json|error {
        json studentDel = check stuApiClient->delete("/" + id);
        return studentDel;
    }
}
