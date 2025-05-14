#!/bin/bash

# Session Name
SESSION="god"
SESSIONEXISTS=$(tmux list-sessions | grep $SESSION)

if [ "$SESSIONEXISTS" = "" ]
then
    # Start New Session with our name
    tmux new-session -d -s $SESSION

    # Create and setup pane for fo server
    tmux rename-window 'main'

    # Create and setup pane for sdxl
    tmux new-window -t $SESSION:1 -n 'sdxl'
    tmux send-keys -t 'sdxl' 'conda deactivate;venvactivate sdxl-cn-lcm;export PYTHONPATH=~/code/bigbang:~/code/bigbang-sdxl;cd ~/code/bigbang-sdxl/app/model-inference' C-m
fi

# Attach Session, on the Main window
tmux attach-session -t $SESSION:0
