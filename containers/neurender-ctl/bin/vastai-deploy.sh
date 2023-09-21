#!/bin/bash

VASTAI_DIR=$HOME/.vastai

if [ ! -d "$VASTAI_DIR" ]; then
  mkdir "$VASTAI_DIR"
fi

function usage() {
    echo "Usage: $0 <offer-id> [image] [disk_size]"
    echo "offer-id: VastAI Offer ID"
    echo "image: The docker image to deploy"
    echo "disk_size: Requested disk size in GB"
    exit 1
}

if [ "$#" -lt 2 ]
then
  usage
fi

OFFER_ID=$1
IMAGE_ID=$2
DISK_SIZE=32

if [ "$#" -gt 3 ]
then
    DISK_SIZE=$3
fi



result=$(vastai create instance $OFFER_ID --image $IMAGE_ID --disk $DISK_SIZE)
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
