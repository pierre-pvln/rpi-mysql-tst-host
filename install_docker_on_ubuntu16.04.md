## Install Docker on Ubuntu 16.04
```shell
# remove old versions
sudo apt-get remove docker docker-engine docker.io
cd ~/myDocker
# get the convenience script 
curl -fsSL get.docker.com -o get-docker.sh
# and run it
sudo sh get-docker.sh
```

If you would like to use Docker as a non-root user, you should now consider
adding your user (tester) to the "docker" group with something like:

```script
sudo usermod -aG docker tester
```

Remember that you will have to log out and back in for this to take effect!

