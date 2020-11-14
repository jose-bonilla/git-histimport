#!/bin/bash
#############################################################
# Import script to bring/import a git repository as a directory in another repository.
# This process imports all history on the files that are part of the repository that is imported.
#############################################################
# REQUIREMENTS: git
#############################################################
# ARGUMENTS: $1: Source Repo (The Repo to import)
#            $2: [Target Repo] (The repo we are importing into)
#############################################################
# Check for arguments
#############################################################

# Check for requirements
function requirements {
  if ! command -v git &> /dev/null; then
      echo "COMMAND/PROGRAM git could not be found."
      exit 1
  fi
}

function strip_dot_git {
  # Remove .git substring
  echo "lol"
}

function import_git_repository {
  echo "Source Repo: $1"
  echo "Address: $2"
  echo "Target Repo: $3"
  echo "Target Repo Address: $4"
  echo "Importing $1 into $3"
  git remote add "$1"_remote "$2"
  git fetch "$1"_remote
  git merge -s ours --no-commit "$1"_remote/master --allow-unrelated-histories
  git read-tree --prefix="$1"/ -u "$1"_remote/master
  git commit -m "Imported ""$1"" as a subtree."
  git remote rm "$1"_remote
  echo "Import of ""$1"" into ""$3"" is complete"
  echo "The result can be found at $4"
}

function main {
  requirements
  # Check for valid first argument
  if [[ "$1" == '' ]]; then
    echo "You must pass in a valid repository as an argument. No argument passed, exiting"
    echo "For more help run 'git-histimport help'"
    exit 1
  elif [[ "$1" == 'help' ]]; then
    echo "General usage"
    echo "git-histimport SOURCE [TARGET]"
    echo "ARGUMENTS: \$1: Source Repo (The Repo to import)
           \$2: [Target Repo] (The repo we are importing into)"
    exit 0
  fi;
  SOURCE_REPO_NAME=$(basename "$1" | cut -d '.' -f1)
  SOURCE_REPO_ADDRESS="$1"

  # Check for 2nd argument
  if [[ "$2" == '' ]]; then 
    if ! git status &> /dev/null
    then
      echo "No target Git repository found. And current directory isn't a git repository"
      exit 1
    fi
    TARGET_REPO_NAME=$(basename "$PWD" | cut -d'.' -f1)
    TARGET_REPO_ADDRESS="$PWD"
  else
    TARGET_REPO_ADDRESS=$2
    TARGET_REPO_NAME=$(basename "$2" | cut -d '.' -f1)
  fi

  # Logic for curred directory.
  if [[ "$PWD" != "$TARGET_REPO_ADDRESS" ]]; then
    # if address is url not local address
    if [[ "$TARGET_REPO_ADDRESS" == *".git"* ]]; then
      git clone "$TARGET_REPO_ADDRESS" "/tmp/$TARGET_REPO_NAME"
      TARGET_REPO_ADDRESS="/tmp/$TARGET_REPO_NAME"
    fi
    cd "$TARGET_REPO_ADDRESS" || exit 1
  fi
  import_git_repository "$SOURCE_REPO_NAME" "$SOURCE_REPO_ADDRESS" "$TARGET_REPO_NAME" "$TARGET_REPO_ADDRESS"
}


main "$@"
