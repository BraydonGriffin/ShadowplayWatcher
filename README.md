# ShadowplayWatcher

Simple powershell script to watch a Shadowplay recording directory for changes and copy the saved clips to a network path

Shadowplay starts on boot before network drive is mapped, continiously disabling shadowplay after a restart (due to 'invalid' destination path)

This script allows a local recording directory but automaticaly moving files to the remote server on file creation
Files saved on the local drive are deleted on script start to regain space
