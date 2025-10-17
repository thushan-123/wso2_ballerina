import ballerina/http;
import ballerina/test;


final string BALL_TEST_URL = "http://localhost:9090/studentService";

final http:Client clientTest = check new(BALL_TEST_URL);

@test:Config {}     // home page
function testHome() returns error? {
    http:Response res = check clientTest->get("/home");
    test:assertEquals(res.statusCode,200, msg = "200 ok /home");
}

@test:Config {}    // getAll student
function testGetAll() returns error? {
    http:Response res = check clientTest->get("/getAll");
    test:assertEquals(res.statusCode,200, msg = "pass 200 ok /getAll");
}


