#!/bin/bash
printf '*%.0s' {1..120}
echo ""
echo "Calling GenAI with the error log..."
printf '*%.0s' {1..120}
echo ""

# Call the curl command
response=$(curl -X POST http://localhost:11434/api/generate -d '
{
  "model": "llama2",
  "prompt":"Analyzing Maven Build Failure: '"$1"'. Provide 3 potential solutions or quick fixes.",
  "stream": false
 }'
)
# Extract the response field from the JSON response
response_field=$(echo "$response" | grep -o '"response":"[^"]*' | grep -o '[^"]*$')

escaped_response=$(printf '%b\n' "$response_field")

printf '*%.0s' {1..120}
echo ""
echo "Some possible fixes from GenAI: "
# print line
printf '*%.0s' {1..120}
echo "$escaped_response"
# print line
printf '*%.0s' {1..120}
echo ""