#!/bin/bash

# Set the threshold (90% in this case)
THRESHOLD=90

# Set the email address that will receive the alert
EMAIL="user@example.org"

# Set the hard disk partition to monitor (in this case, the root partition)
DISK="sda1"

# Set the server Name
SERVER_NAME="MyServer"

# Set The mailtrap API key
MAILTRAP_API_TOKEN="your_mailtrap_api_token_here"


# Get the current disk usage percentage

USAGE=$(df -h | grep $DISK | awk '{ print $5 }' | sed 's/%//')

# Check if usage is above the threshold
if [ $USAGE -gt $THRESHOLD ]; then

	echo "Disk usage is above $THRESHOLD%"

	# Prepare the email content
	SUBJECT="Disk Usage Alert: Server $SERVER_NAME disk is over $THRESHOLD% full"
	BODY="The server's disk $DISK usage is currently at ${USAGE}%."

	# Send the email
	#
	curl --location --request POST \
	'https://send.api.mailtrap.io/api/send' \
	--header "Authorization: Bearer $MAILTRAP_API_TOKEN" \
	--header 'Content-Type: application/json' \
	--data-raw "{\"from\":{\"email\":\"mailtrap@demomailtrap.com\",\"name\":\"Mailtrap Test\"},\"to\":[{\"email\":\"$EMAIL\"}],\"subject\":\"$SUBJECT\",\"text\":\"$BODY\",\"category\":\"Disk Usage\"}"

fi
