import ballerina/http;
import ballerina/io;

string googleSheetServiceUrl = "https://a7b48a3a-0b68-4835-923e-e0cf6f7b20dc-dev.e1-us-east-azure.choreoapis.dev/naib/ballerina-test-service/students-92b/v1.0";
string googleSheetAddEndpoint = "/add";

function writeStudentDetails(string studentName, string studentId, int starredRepoCount) returns error? {
    http:Client cl = check new (googleSheetServiceUrl);
    http:Response res = check cl->post(googleSheetAddEndpoint, {ID: studentId, name: studentName, starredRepoCount});
    if (res.statusCode == 200) {
        io:println("Congratulation!. You completed the exercise successfully");
    } else {
        io:println("OOPS! The Task failed, Please try again!");
    }
}
