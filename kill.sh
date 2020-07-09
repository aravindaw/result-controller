#!/bin/bash
# Gather the output of "ps -e". This will also gather the PIDs of this
# process and of ps process and its subshell.
id=$(ps aux | grep 'allure' | awk '{print $2}')
PSS=$( ps -e )
# Extract PIDs, excluding this one PID and excluding a process called "ps".
# Don't need to expunge 'grep' since no grep was running when getting PSS.
PIDS=$( echo "$PSS" | grep -v "\<ps\>" | grep "$id" | awk '{print $1}' | grep -v "^$$\$" )
if [ -n "$PIDS" ]; then
    kill -s SIGINT $PIDS
else
    echo "No process found matching $1"
fi
echo "Done sending signal."