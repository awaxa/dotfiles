# dotfiles - TODO.md

### branch: script
* check to dotfiles.sh for last pull
* use backup branch instead of directory

### branch: agent
* separate ssh-agent management script
* check for process `ssh-agent -l` or `[ "$(uname)" == "Darwin" ]`
  * refuse to launch an agent if true
* http://talk.maemo.org/showthread.php?t=36188
    ```shell
    unset SSH_AUTH_SOCK
    unset SSH_AGENT_PID
    
    if [[ -f ~/.ssh-agent ]]
    then
            source ~/.ssh-agent >> /dev/null
    fi
    
    ssh-add -l 2>&1 > /dev/null
    r=$?
    if [[ $r == 2 ]]
    then
            echo No agent.
            pkill ssh-agent
            ssh-agent -t 5400 > ~/.ssh-agent
            source ~/.ssh-agent > /dev/null
    fi
    ```
    ```shell
    unset SSH_AUTH_SOCK
    unset SSH_AGENT_PID
    
    agentfile="/home/user/.ssh/agent"
    
    if [[ -f ${agentfile} ]]; then
            source ${agentfile} >> /dev/null
    fi
    
    ssh-add -l 2> /dev/null > /dev/null
    r=$?
    if [[ $r == 2 ]]
    then
            pkill ssh-agent
            ssh-agent -t 900 > ${agentfile}
            source ${agentfile}> /dev/null
            chmod 600 ${agentfile}
    fi
    
    unset agentfile
    
    alias idlist="ssh-add -l"
    alias idrsa="ssh-add /home/user/.ssh/id_rsa"
    alias idrsadel="ssh-add -d /home/user/.ssh/id_rsa"
    ```

### general
* moar
