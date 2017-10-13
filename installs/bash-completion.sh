#!/usr/bin/env bash

pkg install -y bash-completion
printf "[[ $PS1 && -f /usr/local/share/bash-completion/bash_completion.sh ]] && \n source /usr/local/share/bash-completion/bash_completion.sh"\

# adding ssh host completion:
# ATTENTION!!! Some people see this feature as a security violation,
# I think if your *NIX is hacked you will, you will leak hosts as a rusty bucket
echo "HashKnownHosts no" >> ~/.ssh/config
