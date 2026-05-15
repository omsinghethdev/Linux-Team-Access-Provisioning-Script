#!/usr/bin/env bash

echo "Starting setup....."
read -p "Enter the users name to create:" -a  users
read -p "Enter the groups name to create:" -a groups

echo "Creating the group..."

for group in "${groups[@]}"; do
	if  getent group "${group}" ; then
		echo "Group "${group}" already exist."
	else
		echo "Creating "${group}". "
		sudo groupadd "${group}"
 	fi
done

echo "Creating the user..."

for user in "${users[@]}"; do
	if getent passwd "${user}" ; then
		echo "User "${user}" alreay exits."
	else
		echo "Creating "${user}"."
		sudo useradd -m "${user}"
	fi
done
echo "All users and groups are created"


