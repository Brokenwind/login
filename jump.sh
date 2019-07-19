# remove all history agent
ps aux | grep "ssh-agent" | grep -v "grep" | awk '{print $2}' | xargs kill -9
# start a new agent
eval `ssh-agent`
# add current private key
ssh-add -k ~/.ssh/id_rsa
# login with agent
ssh -p 1046 user@223.252.216.168 -A
