import ballerinax/github;
import ballerina/io;

final string studentName = "Sasindu";
final string studentUniversityID = "170024R";
//TODO: Enter your personal access token here. 
//      If you haven't a token, please obtain it using the guidelines in
//      https://docs.github.com/en/enterprise-server@3.6/authentication/keeping-your-account-and-data-secure/managing-your-personal-access-tokens#creating-a-personal-access-token
final string githubToken = ?;

int repositoryCount = 0;
string[] orgs = ["ballerina-platform"];

public function main() returns error? {
    check starRepository(githubToken);
}

function starRepository(string token) returns error? {
    final github:Client ghClient = check new ({auth: {token}});
    foreach string org in orgs {
        stream<github:Repository, github:Error?> repos = check ghClient->getRepositories(org, true);
        check repos.forEach(function(github:Repository repo) {
            string repoName = repo.name;
            github:Error? starRepository = ghClient->starRepository(repo.owner.login, repoName);
            if (starRepository is github:Error) {
                io:println("Error occurred while starring the repo : " + repoName + " " + starRepository.message() + " " + repo.owner.login + " ");
                return;
            }
            io:println("Starred the repo : ", repoName);
            repositoryCount = repositoryCount + 1;
        });
        io:println("Finished processing the org : ", org);
    }

    check writeStudentDetails(studentName, studentUniversityID, repositoryCount);
}