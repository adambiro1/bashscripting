#!/bin/bash
#Generate key and name it with hostname and a day the key was created 
a="${HOME}/.ssh/id_ed25519_$(hostname)_$(date +"%Y-%m-%d")"
ssh-keygen -t ed25519 -f $a -C $a
