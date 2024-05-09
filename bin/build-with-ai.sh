#!/bin/bash
# Run the Maven command and save the output and error messages to a file
if ! mvn clean test > maven_build_output.txt 2>&1; then
  # If the Maven command fails, extract the lines that start with "[ERROR]"
  error_lines=()
  while IFS= read -r line; do
    if [[ "$line" == \[ERROR\]* ]]; then
      error_lines+=("${line:8}")
    fi
  done < maven_build_output.txt

  # If there are any lines that start with "[ERROR]", pass them to the GenAI script
  if [ -n "${error_lines[*]}" ]; then
    echo "Maven build has failed!."
    bin/call-genai.sh "${error_lines[*]}"
  fi
fi
#Remove the temporary file
rm maven_build_output.txt
echo "\nBuild completed"