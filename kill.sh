#!/bin/bash
id=$(ps aux | grep 'allure' | awk '{print $2}')

PSS=$( ps -e )
PIDS=$( echo "$PSS" | grep -v "\<ps\>" | grep "$id" | awk '{print $1}' | grep -v "^$$\$" )
if [ -n "$PIDS" ]; then
    kill -s SIGINT "$PIDS"
else
    echo "No process found matching $1"
fi
echo "Done sending signal."