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
    echo "Removing services...🙃"
    kubectl $ARGS -f service.yml
    kubectl $ARGS -f ingress.yml
    kubectl $ARGS -f deployment.yml
else
    echo "Deploying services...🚀"
    kubectl $ARGS -f service.yml
    kubectl $ARGS -f ingress.yml
    kubectl $ARGS -f deployment.yml

    echo ""
    echo "App running at 🌐:"
    echo "- Local:   http://localhost:3000/"
    echo "- Network: http://127.0.0.1:3000/"
    echo ""
    echo "Checking if pods is ready 👀 and running port-forward...🔎"
    # check if pod with label app=server is ready when deploying and
    # forward port 3000 to 80 (server) for testing purposes only (not for production)
    # wait for 60 seconds.
    kubectl wait --for=condition=ready pod -l app=server --timeout=60s && 
    kubectl port-forward service/ingress-nginx-controller -n ingress-nginx 3000:80
fi
