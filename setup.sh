#!/usr/bin/env bash

echo "Starting setup....."

for user in dev1 dev2 intern
do
	sudo useradd -m $user
done

if [[ $? -eq 0 ]]; then
	echo "Users created"
else
	echo "User already exists or failed"
fi
sudo groupadd devteam

if [[ $? -eq 0 ]]; then
	echo "Group created"
else
	echo "Group already exists or failed"
fi
for user in dev1 dev2
do
	sudo usermod -aG devteam $user
done
if [[ $? -eq 0 ]]; then
	echo "User added to group"
else
	exit 1
fi
sudo mkdir -p /project
if [[ $? -eq  0 ]]; then
	echo "Project directory created"
else
	exit 1
fi
sudo chown dev1:devteam /project
echo "Ownership set"
sudo chmod 750 /project
echo "Permission set."
echo "Setup complete!"


