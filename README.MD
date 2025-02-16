# Designli Challenge

## Overview

**The easy one:**

Create a Docker container with a Linux server (Ubuntu or Alpine preferred) and install Node.js.

1. Create a script that sets up a remote Git repository on the server, including a post-receive hook that allows automatic deployment when code is pushed. (Example: DigitalOcean Guide). You should be able to do something like git push docker main, being docker a remote url configured to point to the Docker container.

2. Create a simple React application displaying Hello XXX, where the value of XXX is read from an .env file.

3. Push your React application to the remote repository on the server and verify that it is automatically deployed and running.

Proposals will be evaluated based on the following criteria:

- Correctness
- Simplicity
- Documentation

Steps of our implementation:

## Automated Deployment

1. We create a Dockerfile to build our image. This docker file is based on the ubuntu:latest image and installs git, curl, openssh-server, and nodejs. We also create the necessary directories for the git repository and the website. We initialize a git repository and configure SSH for access. We also configure SSHD and expose port 22. Make sure to copy the authorized_keys file to the container to allow access. This authorized_keys file contains the public key of the machine that will push the code to the repository.

2. Then we create our docker-compose file to run our container. We expose port 2222 to access the SSH server. We also mount the post-receive hook and the website directory to the container. This way, we can push the code to the repository and see the changes in the website directory.

3. Then we create the post-receive hook. This script is executed when code is pushed to the repository. It receives the code and copies it to the website directory. It also installs the dependencies and builds the React application.

[!IMPORTANT] Ensure that the post-receive hook has the correct permissions to execute. You can do this by running chmod +x post-receive.

```bash
chmod +x post-receive
```

## Client Application

We have created a simple React application that displays Hello XXX, where XXX is read from an .env file. We have also created a .env file with the value of XXX.

```bash
npx create-react-app client
```

Create a .env file with the following content:

```bash
REACT_APP_NAME=World
```

Modify the App.js file to read the value of REACT_APP_NAME from the .env file.

```javascript
import React from 'react';

function App() {
  return (
    <div>
      <h1>Hello {process.env.REACT_APP_NAME}</h1>
    </div>
  );
}

export default App;
```

## Configure the Remote Repository

We configure the remote repository on the server to point to the Docker container. We add the remote repository to the client application and push the code to the server.

```bash
git init
git remote add docker ssh://docker@localhost:2222/var/repo/site.git
git remote set-url docker "ssh://root@localhost:2222/var/repo/site.git" # Specify private key to git
```

## Execute the Deployment

We push the code to the remote repository on the server and verify that it is automatically deployed and running.

```bash
docker-compose up
```

```bash
git add .
git commit -m "Deploy"
GIT_SSH_COMMAND='ssh -i ~/.ssh/id_rsa' git push docker main
```
