#!/usr/bin/env bash

echo "Starting setup....."
echo "-------------------------------------------------"
read -p "Enter  users :" -a  users
read -p "Enter groups :" -a groups
	
if [[ "${#users[@]}" -eq 0 && "${#groups[@]}" -eq 0 ]]; then
		echo "Both user and group is empty.Exiting..."
		exit 1
fi

	
if [[ "${#groups[@]}" -eq 0 ]]; then
	echo "No group entered.Skipping group creation..."
else
echo "Creating group..."
for group in "${groups[@]}"; do
	if  getent group "${group}" > /dev/null ; then
		echo "Group ${group} already exist."
	else
		echo "Creating ${group}. "
		
		if sudo groupadd "${group}"; then
			echo "${group} created."
		else
			echo "Error! in creating group ${group}"
		fi

 	fi
done
fi

echo "------------------------------------------------"

if [[ "${#users[@]}" -eq 0 ]]; then
	echo "No user entered.Skipping user creation..."
else
echo "Creating the user..."

for user in "${users[@]}"; do
	if getent passwd "${user}" > /dev/null; then
		echo "User ${user} already exists."
	else
		echo "Creating ${user}."
		if sudo useradd -m "${user}"; then	
			echo "${user} is created."
		else
			echo "ERROR! in creating user ${user}."
		fi
	fi
done
fi
echo "------------------------------------------------"

echo "Entered Users."
usernum=1
for display_user in "${users[@]}"; do
	echo "${usernum}.${display_user}"
	((usernum+=1))
done
groupnum=1
echo "Avilable Group"
for display_group in "${groups[@]}"; do
	echo "${groupnum}.${display_group}"
done

while true; do
	read -p "Enter the user:" selected_user
	read -p "Enter the groups(space seperated):" -a selected_groups
	echo "Adding user to groups..."
	sudo usermod -aG "$(IFS=,; echo "${selected_groups[*]}")" "$selected_user"
	if [[ $? -eq 0 ]]; then
		echo "Added ${selectded_user} to selected groups."
	else
		echo "Failed to add user."
	fi
	read -p "Do you want to continue(yes/no)?" confirm

	if [[ ${confirm} == "yes" ]]; then
		continue
	else
		echo "Exiting Script.."
		break
	fi
done

