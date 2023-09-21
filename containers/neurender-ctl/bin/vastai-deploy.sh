#!/bin/bash

VASTAI_DIR=$HOME/.vastai

if [ ! -d "$VASTAI_DIR" ]; then
  mkdir "$VASTAI_DIR"
fi

function usage() {
    echo "Usage: $0 OFFER_ID [IMAGE_ID]"
    echo "VastAI Offer ID"
    echo "IMAGE_ID: The docker image to deploy"
    exit 1
}

if [ "$#" -ne 2 ]
then
  usage
fi

OFFER_ID=$1
IMAGE_ID=$2

if [ "$#" -gt 2 ]
then
    IMAGE_ID=$2
fi


result=$(vastai create instance ${OFFER_ID} --image ${IMAGE_ID} --ssh)
echo "Create instance result: $result"

# Parse the result. Example result: 'Started. {'success': True, 'new_contract': 7053615}'
json_data=$(echo "$result" | grep -o -P '{.*')    # Select only the JSON
json_data=${json_data//\'/\"}                   # Replace single quotes with double quotes
json_data=${json_data//True/true}      # Replace capitalized True with lowercase true

# Try to parse the JSON data
parsed_json=$(echo "$json_data" | jq '.' 2>/dev/null)

# If the JSON could not be parsed, assume failure
if [ $? -ne 0 ]; then
    echo "Operation failed."
    exit 1
fi

SUCCESS=$(echo "$json_data" | jq '.success')
VASTAI_INSTANCE=$(echo "$json_data" | jq '.new_contract')

if [ "$SUCCESS" = "true" ]; then
    echo "Operation Successfully finished."
    echo "New Contract: $VASTAI_INSTANCE"
    echo "$VASTAI_INSTANCE" > "$VASTAI_DIR/instance_id"
else
    echo "Not successful."
    exit 1
fi
