#!/bin/bash

# Check if correct number of arguments are passed
if [ "$#" -ne 2 ]; then
  echo "Usage: $0 <branch> <versionFile>"
  exit 1
fi

branch="$1"
versionFile="$2"

echo "Branch: $branch"

if [ ! -f "$versionFile" ]; then
  echo "Version file not found!"
  exit 1
fi

fileVersion=$(cat "$versionFile")

IFS='.' read -r major minor patch <<< "$fileVersion"
IFS='/' read -r branchType _ <<< "$branch"
branchType=$(echo "$branchType" | tr '[:upper:]' '[:lower:]')

case "$branchType" in
  release)
    major=$((major + 1))
    minor=0
    patch=0
    ;;
  feature)
    minor=$((minor + 1))
    patch=0
    ;;
  bug|bugfix)
    patch=$((patch + 1))
    ;;
esac

version="$major.$minor.$patch"
echo "Version: $version"
echo "$version" > "$versionFile"