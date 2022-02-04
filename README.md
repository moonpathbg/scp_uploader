# SCP Uploader

Transfer files to remote host over SSH/SCP using key based authentication.

## Required arguments

- `host`: Remote host name or ip address
- `username`: Username for login
- `port`: Port used for SSH connection
- `key`: SSH private key
- `source`: Source files or directories
- `target`: Remote path location

## SSH authentication and configuration

Password auehtentication is considered unsecure and is not implemented.

SSH key generation is done as follows:
```
ssh-keygen -t ed25519 -f ./id_ed25519
```
It will spit the private key in *./id_ed25519* and the public in *./id_ed25519.pub*

Then go to *Settings>Secrets* of your repository in Github and create the following *secrets*:

- `HOST`: Containing the remote server hostname or ip address.
- `PORT`: Containing the remote server SSH port.
- 'USERNAME': Containing username used for SSH/SCP login.
- 'SSH_KEY': Private SSH key.

The public key (id_ed25519.pub) should be stored at *~/.ssh/authorized_keys* on the server where the upload should be done.


## Sample workflow deployment yaml

```yml
name: Site deploy
on:
  push:
    branches: [ main ]
  workflow_dispatch:
jobs:
  upload:
    runs-on: ubuntu-latest
    steps:
    - name: Checkout code to workspace
      uses: actions/checkout@v2
    - name: Deploy to web server
      uses: moonpathbg/scp_uploader@latest
      with:
          host: ${{ secrets.HOST }}
          port: ${{ secrets.PORT }}
          username: ${{ secrets.USERNAME }}
          key : ${{ secrets.SSH_KEY }}
          source: "./"
          target: "~/"
```
