#!/bin/bash

# Bitbucket credentials
USERNAME=$1
PASSWORD=$2

# Repository details
WORKSPACE=$3
REPO_SLUG=$4

# Pull request details
SOURCE_BRANCH=$5
DESTINATION_BRANCH=$6
TITLE="Creating Pull Request For $SOURCE_BRANCH TO $DESTINATION_BRANCH"
DESCRIPTION="Creating Pull Request For $SOURCE_BRANCH TO $DESTINATION_BRANCH"

# Bitbucket API URL
BITBUCKET_API="https://api.bitbucket.org/2.0/repositories/$WORKSPACE/$REPO_SLUG/pullrequests"

# Create JSON payload for the pull request
DATA=$(cat <<EOF
{
  "title": "$TITLE",
  "description": "$DESCRIPTION",
  "source": {
    "branch": {
      "name": "$SOURCE_BRANCH"
    }
  },
  "destination": {
    "branch": {
      "name": "$DESTINATION_BRANCH"
    }
  }
}
EOF
)

# Make API call to create the pull request
RESPONSE=$(curl -s -X POST -u "$USERNAME:$PASSWORD" -H "Content-Type: application/json" -d "$DATA" "$BITBUCKET_API")

# Check if the response contains an error message
if [[ $RESPONSE == *"error"* ]]; then
    echo "Error encountered:"
    echo "$RESPONSE"
else
    echo "Pull request created successfully."
    echo "Response:"
    echo "$RESPONSE"
fi
