# git-histimport.sh

A quick tool that can import git repos into each other and bring history along.

## Usage

The simplest way to use this script is to use it to import a remote repository
into an already locally cloned repository.

The more slightly advanced usage allows you to import a source remote repository
into a specific target remote or local repository by simply specifying the target
remote repository url or the target local repository path. If you specify a remote
repository url, the result will be found at `/tmp/<repo_name>`.

### Simple

`git-histimport.sh <remote_source_repository_url>`

### Advanced

`git-histimport.sh <remote_source_repository_url> <remote_target_repository_url|local_target_repository_path>`

## Caveats

It is **highly** recommended and advised for the purpose of simplicity and understanding
that an import action like this be the only major change in a pull request or commit.
You should import the git repository and ensure it's checked into the default/primary/release
branch of whatever you're working on before branching off of that. Dabbling my
hands in a current commit after a recent import has awoken quite the git demons
that I'd advise we just stay away from. Just keep it simple, and get it merged in.
