#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Check if the template argument is provided
if [ -z "$1" ]; then
    echo "Error: template file is not provided."
    echo "Usage: $0 cf/template.yaml"
    exit 1
fi
# Set the CF_TEMPLATE value from the command line argument
CF_TEMPLATE="$1"


# Check if the stack argument is provided
if [ -z "$2" ]; then
    echo "Error: stack name is not provided."
    echo "Usage: $0 cf/template.yaml sample-app"
    exit 1
fi

# Set the STACK value from the command line argument
STACK="$2"

if [ -z "$3" ]; then
    echo "Error: env is not provided."
    echo "Usage: $0 cf/template.yaml sample-app bhub"
    exit 1
fi

APP="$3"

if [ -z "$4" ]; then
    echo "Error: env is not provided."
    echo "Usage: $0 cf/template.yaml sample-app bhub d1"
    exit 1
fi

ENV="$4"

echo "Pamaters in action"
echo "CF_TEMPLATE: $CF_TEMPLATE"
echo "STACK: $STACK"
echo "APP: $APP"
echo "ENV: $ENV"


# Replace placeholder in the template file
if [[ $OSTYPE == "darwin"* ]]; then
    sed -i '' 's/<app>/'$APP'/g' $CF_TEMPLATE
    sed -i '' 's/<env>/'$ENV'/g' $CF_TEMPLATE
else
    sed -i 's/<app>/'$APP'/g' $CF_TEMPLATE
    sed -i 's/<env>/'$ENV'/g' $CF_TEMPLATE
fi


# Apply the CloudFormation template
aws cloudformation deploy --template-file $CF_TEMPLATE --stack-name $STACK
