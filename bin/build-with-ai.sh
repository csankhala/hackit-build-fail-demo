#!/bin/bash

# Run the Maven command
mvn clean package 2>&1 | tee maven_build_logs.txt

awk '
/INFO] BUILD FAILURE/ {flag=1; next}
  flag {print}
' maven_build_logs.txt > build_failure_logs.txt

# Initialize an empty array to store the lines that start with "[ERROR]"
error_lines=()
while IFS= read -r line; do
    if [[ "$line" == *"To see the full stack trace of the errors, re-run Maven with the -e switch."* ]]; then
      break
    fi
    # If the line starts with "[ERROR]", save it in the array
    if [[ "$line" == \[ERROR\]* ]]; then
        error_lines+=("${line:8}")
    fi
done < build_failure_logs.txt

IFS=' '; error_payload="${error_lines[*]}"

if [ -n "$error_payload" ]; then
    echo "Maven build has failed!"
    echo "For more details, please check the build logs"
    # Call GenAI script here, passing the error message as an argument
    bin/call-genai.sh "$error_payload"
fi

# Remove the temporary file
rm maven_build_logs.txt
rm build_failure_logs.txt

echo "Build completed."
