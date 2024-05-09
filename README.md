## This is prototype to demonstrate AI-Powered Build Failure Diagnostic Tool

### Install Ollama for executing large language models locally
1. Follow official guide here: https://github.com/ollama/ollama
2. Install model using below command
    ```shell
    ollama pull llama2
    ```
3. Start service locally: `./ollama serve`
    - By default it starts ollama service on port `11434`
    - REST API detail: https://github.com/ollama/ollama?tab=readme-ov-file#rest-api

### Important files
1. `bin/build-with-ai.sh`: This script is used to build the project and interact with Ollama service to get the suggestion to fix the error.
2. `src/main/java/org/epam/hackit/Main.java`: This is the main file where error is introduced to demonstrate the use case.
3. `bin/call-genai.sh`: This script is used to interact with Ollama service to get the suggestion to fix the error.

### How to build this project
1. execute below command
    ```shell
     sh bin/build-with-ai.sh
    ```

### To demonstrate E2E use case
1. Put any error in code. Example rename [Main.java](src%2Fmain%2Fjava%2Forg%2Fepam%2Fhackit%2FMain.java) to 1Main.java
2. Now execute below command
    ```shell
    sh bin/build-with-ai.sh
    ```
3. You will see build will fail and it will interact with Ollama service to get the suggestion to fix the error.
Observe log around: `Some possible fixes from GenAI: xxx`