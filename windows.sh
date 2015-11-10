#!/bin/bash

ANSIBLE_PATH="$(find /vagrant -name 'windows.sh' -printf '%h' -quit)"

# placeholder file for the Windows provisioning script
echo hello
echo $ANSIBLE_PATH

echo "whoohoo!"
