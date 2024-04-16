#!/bin/bash

## This script creates a PR from the current branch to the base branch
## Usage: ./ppush.sh [-d] [-r reviewer]
##   -d: create a deploy branch (e.g. deploy/branch-name) instead of using the user's email prefix (e.g. wadinj/branch-name)
##   -r: reviewer's GitHub username (e.g. -r wadinj -r pcorpet)

prefix=$(git config user.email | cut -f1 '-d@' | cut -f2 '-d+')

# Parse options
while getopts "dr:" opt; do
  case $opt in
    d)
      prefix=deploy
      ;;
    r)
      reviewer="--reviewer $OPTARG"
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
    :)
      echo "Option -$OPTARG requires an argument." >&2
      exit 1
      ;;
  esac
done
shift $((OPTIND-1))

base=$(git ref-branch HEAD^ | head -n1)

if [[ -z $base ]]; then
  echo "Could not find the previous commit's base branch. Have you created a commit?"
  exit 1
fi

echo "> Based on $base"

## Ask for branch name
commit_message=$(git log -1 --pretty=%B | head -n1)
branch=$(echo $commit_message | tr -dc '[:alnum:][:blank:]' | tr '[:upper:]' '[:lower:]' | sed 's/ /-/g')

echo "> Branch name: $branch"

readonly remote_branch=$prefix/$branch
readonly remote=$(git config branch.$base.remote)

echo "> Pushing to $remote/$remote_branch"

git branch $remote_branch HEAD
git push origin "$remote_branch:$remote_branch"

echo "> Creating PR"
PR_URL=$(gh pr create --fill --base $base $reviewer --body "copilot:all" --head $remote_branch)
echo $PR_URL
gh pr merge $PR_URL --squash  --delete-branch

# Ask user if they want to delete the local branch
read -p "Delete local branch? " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
  git branch -D $remote_branch
fi

# Ask user if they want to delete the latest commit
read -p "Delete latest commit? " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
  git reset --hard HEAD~1
fi

# Ask user if they want to post a message to the channel
#read -p "Post in #pr-requests?" -n 1 -r
#echo
#if [[ $REPLY =~ ^[Yy]$ ]]
#then
  #read -p "Enter your message to the channel: " -r
  #MESSAGE=$REPLY
  #bash post-pr-message.sh "$MESSAGE\n$PR_URL"
  #echo "Posted message to channel"
#fi
