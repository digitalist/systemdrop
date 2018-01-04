#!/usr/bin/env bash

pkg install -y bash-completion
printf "[[ $PS1 && -f /usr/local/share/bash-completion/bash_completion.sh ]] && \n source /usr/local/share/bash-completion/bash_completion.sh"\

echo adding ssh host completion:
echo ATTENTION!!! Some people see this feature as a security violation,
echo think if your *NIX is hacked you will, you will leak hosts as a rusty bucket
echo 'echo "HashKnownHosts no" >> ~/.ssh/config'
