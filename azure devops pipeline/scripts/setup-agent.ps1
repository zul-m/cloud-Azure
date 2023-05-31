#download setup
wget https://vstsagentpackage.azureedge.net/agent/3.218.0/vsts-agent-linux-x64-3.218.0.tar.gz

mkdir myagent

cd myagent

#extract the setup
tar zxvf ~/Downloads/vsts-agent-linux-x64-3.218.0.tar.gz 

#run this file to start the configuration
./config.sh

 1 - request azure devops organization : https://dev.azure.com/organization/
 2 - enter the PAT that you have created
 3 - enter the name of the agent pool that we have created