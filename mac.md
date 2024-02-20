Download
# Create a folder
$ mkdir actions-runner && cd actions-runner# Download the latest runner package
$ curl -o actions-runner-osx-arm64-2.313.0.tar.gz -L https://github.com/actions/runner/releases/download/v2.313.0/actions-runner-osx-arm64-2.313.0.tar.gz# Optional: Validate the hash
$ echo "97258c75cf500f701f8549289c85d885a9497f7886c102bf4857eed8764a9143  actions-runner-osx-arm64-2.313.0.tar.gz" | shasum -a 256 -c
# Extract the installer
$ tar xzf ./actions-runner-osx-arm64-2.313.0.tar.gz
Configure
# Create the runner and start the configuration experience
$ ./config.sh --url https://github.com/sebbycorp/github-action-runner-test --token AAJVUNLVCLVM3GIQSVKRIVDF2QX2K
# Last step, run it!
$ ./run.sh
Using your self-hosted runner
# Use this YAML in your workflow file for each job
runs-on: self-hosted