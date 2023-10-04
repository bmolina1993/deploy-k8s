#!/bin/bash
# source .env # load env variables

# conditional to check if argument is "delete" or no argument is given:
if [ "$*" != "delete" ] && [ $# -gt 0 ]; then
    echo "Invalid argument 🚫: [$*], [delete] or no argument is allowed"
    exit 1
fi

# Assign argument to variable ARGS (default: apply if no argument is given)
if [ $# -eq 0 ]; then
    ARGS="apply"
else
    ARGS="delete"
fi

if [ "$ARGS" == "delete" ]; then
    echo "Shutting down services...🙃"
    kubectl $ARGS -f service.yml
    kubectl $ARGS -f deployment.yml
else
    echo "Deploying services...🚀"
    kubectl $ARGS -f service.yml
    kubectl $ARGS -f deployment.yml
fi
