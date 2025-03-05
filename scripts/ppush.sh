#!/bin/bash

## This script creates a PR from the current branch to the base branch
## Usage: ./ppush.sh [-d] [-r reviewer]
##   -d: create a deploy branch (e.g. deploy/branch-name) instead of using the user's email prefix (e.g. wadinj/branch-name)
##   -r: reviewer's GitHub username (e.g. -r wadinj -r pcorpet)

BOLD_RED="\033[1;31m"
BOLD_WHITE="\033[1;37m"
BOLD_GREEN="\033[1;32m"
RESET="\033[0m"

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

base=$(git ref-branch HEAD^ | tail -n1)

if [[ -z $base ]]; then
  echo "Could not find the previous commit's base branch. Have you created a commit?"
  exit 1
fi

echo -e "${BOLD_WHITE}> Based on ${BOLD_RED}${base}${RESET}"

## Ask for branch name
commit_message=$(git log -1 --pretty=%B | head -n1)
branch=$(echo $commit_message | tr -dc '[:alnum:][:blank:]' | tr '[:upper:]' '[:lower:]' | sed 's/ /-/g')

readonly remote_branch=$prefix/$branch
readonly remote=$(git config branch.$base.remote)

echo -e "${BOLD_WHITE}> Branch name: ${BOLD_RED}${remote_branch}${RESET}"
echo -e "${BOLD_WHITE}> Pushing to ${BOLD_RED}${remote}/${remote_branch}${RESET}"

git branch $remote_branch HEAD
git push origin "$remote_branch:$remote_branch"

# Ask user if they want to attach a linear ticket
read -p $'\033[1;37mAttach a linear ticket ID?\033[0m ' -n 1 -r
echo -e
if [[ $REPLY =~ ^[Yy]$ ]]
then
    TICKET_ID=$(sh get-linear-tickets.sh)
    if [[ -z "$TICKET_ID" ]]; then
        echo -e "Ticket ID not extracted, continuing ..."
    else
        read -p $'\033[1;37mDo you want the PR to close the ticket? \033[0m' -n 1 -r
        echo -e
        if [[ $REPLY =~ ^[Yy]$ ]]
        then
            PR_BODY="Closes $TICKET_ID."
        else

            PR_BODY="Related to $TICKET_ID."
        fi
    fi
fi


echo -e "${BOLD_WHITE}> Creating PR${RESET}"
if [[ -z "$PR_BODY" ]]; then
    PR_URL=$(gh pr create --fill --base $base $reviewer --head $remote_branch)
else
    PR_URL=$(gh pr create --fill --base $base $reviewer --head $remote_branch --body "$PR_BODY")
fi

echo -e "${BOLD_WHITE}Pull request created!${RESET}"
echo -e $PR_URL
echo -e "${BOLD_WHITE}> Setting auto merge${RESET}"
gh pr merge $PR_URL --squash --auto --delete-branch

# Ask user if they want to delete the local branch
read -p $'\033[1;37mDelete local branch?\033[0m ' -n 1 -r
echo -e
if [[ $REPLY =~ ^[Yy]$ ]]
then
    git branch -D $remote_branch
fi

# Ask user if they want to delete the latest commit
read -p $'\033[1;37mDelete latest commit?\033[0m ' -n 1 -r
echo -e
if [[ $REPLY =~ ^[Yy]$ ]]
then
    git reset --hard HEAD~1
fi

# Ask user if they want to post a message to the channel
#read -p "Post in #pr-requests?" -n 1 -r
#echo -e
#if [[ $REPLY =~ ^[Yy]$ ]]
#then
  #read -p "Enter your message to the channel: " -r
  #MESSAGE=$REPLY
  #bash post-pr-message.sh "$MESSAGE\n$PR_URL"
  #echo -e "Posted message to channel"
#fi
