To install a GitHub Actions runner on a Linux machine, you can create a Bash script that automates the download, configuration, and installation process. This script assumes you're setting up a runner for a repository (the process is slightly different for organization or enterprise runners). Before you begin, ensure you have administrative access to the Linux machine and you've obtained a registration token from your GitHub repository's settings under Actions > Runners > New runner.

Here's a basic Bash script to set up a GitHub Actions runner on Linux. Replace YOUR_TOKEN with your actual registration token and YOUR_REPOSITORY_URL with your GitHub repository URL (e.g., https://github.com/username/repo).

```bash
#!/bin/bash

# Variables
RUNNER_NAME="my-runner"
REPO_URL="YOUR_REPOSITORY_URL"
TOKEN="YOUR_TOKEN"
RUNNER_VERSION="latest"
RUNNER_FOLDER="/home/$(whoami)/actions-runner"
GITHUB_RUNNER_URL="https://github.com/actions/runner/releases/download"

# Download the latest runner package
echo "Downloading the latest GitHub Actions Runner..."
mkdir ${RUNNER_FOLDER}
cd ${RUNNER_FOLDER}
curl -o actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz -L ${GITHUB_RUNNER_URL}/v${RUNNER_VERSION}/actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz

# Extract the installer
echo "Extracting the GitHub Actions Runner..."
tar xzf ./actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz

# Create the runner and start the configuration experience
echo "Configuring the GitHub Actions Runner..."
./config.sh --url ${REPO_URL} --token ${TOKEN} --name ${RUNNER_NAME} --unattended

# Install the runner service
echo "Installing the GitHub Actions Runner service..."
sudo ./svc.sh install

# Start the runner service
echo "Starting the GitHub Actions Runner service..."
sudo ./svc.sh start

echo "GitHub Actions Runner installation is complete."
```


##Instructions to use the script:

Open a text editor and paste the above script.
Replace YOUR_REPOSITORY_URL with your GitHub repository URL.
Replace YOUR_TOKEN with your runner registration token.
Save the file as install_github_runner.sh.
Open a terminal and navigate to the directory where you saved the script.
Make the script executable by running chmod +x install_github_runner.sh.
Execute the script by running ./install_github_runner.sh.
This script will download, configure, and start the GitHub Actions runner on your Linux machine. Make sure to monitor the runner's log for any errors and verify it appears in your GitHub repository's settings under Actions > Runners.





