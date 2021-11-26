import ballerina/http;
import ballerina/log;
import ballerina/io;

const KEY = "xyzzy";

public function main() {
    log:printInfo("githubClient -> getIssuesWithLabel()");

    float v1 = sumForTestingForLoop([10.5, 20.5, 30.5]);
    
    getIssuesForLabel("Type/Bug");
    log:printInfo("Finished getting bugs");
    getIssuesForLabel("Area/AST");
    log:printInfo("Finished getting AST");
    getIssuesForLabel("Priority/High");
    log:printInfo("Finished getting Priority/High");

    io:println(matchTest("str"));
    io:println(matchTest(17));
    io:println(matchTest(20.5));
}

function getIssuesForLabel(string label) {
    http:Client httpClient = checkpanic new ("https://api.github.com/");

    http:Response|error responseOrError = httpClient->get(string `repos/ballerina-platform/ballerina-lang/issues?labels=${label}`);
    // http:Response|error responseOrError = httpClient->get(string `repos/wso2-enterprise/ballerina-central/issues?labels=${label}`, {"Authorization": "token __token__"});
    if (responseOrError is error) {
        log:printError("error getting issues", responseOrError);
    } else {
        http:Response response = <http:Response> responseOrError;
        io:println(response.getJsonPayload());
    }
}

function sumForTestingForLoop(float[] v) returns float {
    float r = 0.0;

    foreach float x in v {
        r += x;
    }

    return r;
}

function matchTest(any v) returns string {

    match v {
        17 => {
            return "number";
        }
        true => {
            return "boolean";
        }
        "str" => {
            return "string";
        }
        KEY => {
            return "constant";
        }
        0|1 => {
            return "or";
        }
        _ => {
            return "any";
        }
    }

}
