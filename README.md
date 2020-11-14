# git-histimport.sh
A quick tool that can import git repos into each other and bring history along.

## Usage
The default use of this script is to call it from the root of the repository that you are importing Into. If you want, you can pass in a path to a repository or a url to a repo that you have access to as the target. If you pass in a repo url, it will be clone the repo at `/tmp/<repo_name>`.

## Import into local repo
The source repository needs to be a path to a repository that you currently have access to.

`git-histimport.sh <source_repository>`

Ex: `git-histimport.sh https://github.com/something/hello_world`

NOTE: If you're within a git repository, but not at the root level, we assume you want to import the source repository into the current directory. If you want to target a specific directory of the repository, please continue reading

NOTE: It's highly advised to check in these changes as their own commit/merge/whatever. Sometimes making changes on top of running this script can mess with established history (Don't tempt the beasts of this, I won't help)

## Import into specific repository
This method requires two arguments: source_repository and target_repository

Both have to have one of the following requirements:
* A path to a repository on your local computer
* A path to a repository that you currently have access to

`git-histimport.sh <source_repository> <target_repository>`

## Import into specific directory
