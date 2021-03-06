#SETTINGS
myDockerDir=$HOME"/myDocker"

# Check if top level folder exists if not create it
[ ! -d "$myDockerDir" ] && mkdir -p "$myDockerDir" || echo "$myDockerDir present ..."

# Check if SSH key exists if not create it
[ ! -f ~/.ssh/id_rsa.pub ] && ssh-keygen -f $HOME/.ssh/id_rsa -t rsa -b 4096 -C "pierre@pvln.nl" || echo "SSH key found ..."
# TODO: add option to not ask for passphrase

# Attempts to ssh to GitHub
ssh -T git@github.com
sshexitstatus=$?
#echo "exitstatus = $sshexitstatus"
if [ $sshexitstatus -ne 1 ]; then
   echo "Exiting, first copy your public key to github account";
#       add generated ssh key to github account
#       https://help.github.com/articles/adding-a-new-ssh-key-to-your-github-account/
   exit
else
   echo "SSH into github works ...";
fi

# TODO: check if git is already installed
#       if not installed then

git config --global user.name Pierre Veelen
git config --global user.email pierre@pvln.nl
git config --global color.ui auto

#
# create folders and files for docker host scripts
#
[ ! -d "$myDockerDir/on_host" ] && mkdir -p "$myDockerDir/on_host" || echo "$myDockerDir/on_host present ..."
cd "$myDockerDir/on_host"
[ ! -d "$myDockerDir/on_host/.git" ] && git init || echo "git repository present ..."
# Set remote
git remote add origin git@github.com:pierre-pvln/compose-on_host.git
# Verify new remote
git remote -v
git pull origin master
#set execute bit for all *.sh files
find . -name '*.sh' -type f | xargs chmod +x

#
# create folders and files for services provided through docker containers
# folders hold the Dockerfile files
#
[ ! -d "$myDockerDir/services" ] && mkdir -p "$myDockerDir/services" || echo "$myDockerDir/services present ..."
cd "$myDockerDir/services"
[ ! -d "$myDockerDir/services/.git" ] && git init || echo "git repository present ..."
# Set remote
git remote add origin git@github.com:pierre-pvln/compose-services.git
# Verify new remote
git remote -v
git pull origin master
#set execute bit for all *.sh files
find . -name '*.sh' -type f | xargs chmod +x

#
# create folders and files for the integrations
# folders hold the docker compose yaml files
#
[ ! -d "$myDockerDir/integrations" ] && mkdir -p "$myDockerDir/integrations" || echo "$myDockerDir/integrations present ..."
cd "$myDockerDir/integrations"
[ ! -d "$myDockerDir/integrations/.git" ] && git init || echo "git repository present ..."
# Set remote
git remote add origin git@github.com:pierre-pvln/compose-integrations.git
# Verify new remote
git remote -v
git pull origin master
#set execute bit for all *.sh files
find . -name '*.sh' -type f | xargs chmod +x
