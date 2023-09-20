#!/bin/bash
INSTANCEID_FILE=$HOME/.vastai/instance_id
vastai destroy instance $(cat $INSTANCEID_FILE)
rm $INSTANCEID_FILE