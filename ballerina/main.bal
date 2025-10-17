import ballerina/http;

final string API_URL = "http://api-express/api/student";

final http:Client stuApiClient = check new (API_URL, {
    timeout: 10
});

service /studentServise on new http:Listener(9090) {
    
    resource function get getAll() returns json|error {
        json students = check stuApiClient->get("/");
        return students;
    }

    resource function get getById(string id) returns json|error {
        json student = check stuApiClient->get("/" + id);
        return student;
    }

    resource function post createstudent(@http:Payload json studentData) returns json|error {
        json student = check stuApiClient->post("/", studentData);
        return student;
    }

    
    
    
}