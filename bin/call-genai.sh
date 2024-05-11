#!/bin/bash
printf '*%.0s' {1..120}
echo ""
echo "Calling GenAI with the error log..."
printf '*%.0s' {1..120}
echo ""

# Call the curl command
response=$(curl -X POST http://localhost:11434/api/generate -d '
{
  "model": "llama3",
  "prompt":"Analyze Maven Build Failure: '"$1"'. Provide 2 potential solutions as line items",
  "stream": false
 }'
)
# Extract the response field from the JSON response
response_field=$(echo "$response" | grep -o '"response":"[^"]*' | grep -o '[^"]*$')

# Replace unicode escape sequences with actual characters
response_field=${response_field//\\u003c/\<}
response_field=${response_field//\\u003e/\>}

printf '*%.0s' {1..120}
echo ""
echo "Some possible fixes from GenAI: "
# print line
printf '*%.0s' {1..120}
echo ""
printf "$response_field"
echo ""
# print line
printf '*%.0s' {1..120}
echo ""