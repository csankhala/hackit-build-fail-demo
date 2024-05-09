#!/bin/bash

# Run the Maven command
mvn clean test 2>&1 | tee maven_build_logs.txt

# Initialize an empty array to store the lines that start with "[ERROR]"
error_lines=()
# Read the input file line by line
while IFS= read -r line; do
    # If the line starts with "[ERROR]", save it in the array
    if [[ "$line" == \[ERROR\]* ]]; then
        error_lines+=("${line:8}")
    fi
done < "maven_build_logs.txt"

IFS=' '; error_payload="${error_lines[*]}"

if [ -n "$error_payload" ]; then
    echo "Maven build has failed!"
    echo "For more details, please check the build logs: $error_payload"
    # Call GenAI script here, passing the error message as an argument
    bin/call-genai.sh "$error_payload"
fi

# Remove the temporary file
rm maven_build_logs.txt

echo "Build completed."
