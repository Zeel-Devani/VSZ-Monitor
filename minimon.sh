#!/bin/bash

get_vsz_usage()
{
	local username=$1
	
	# Find List of all process
	local ps_output=$(ps aux)

	# Filter the lines for the given username
	local user_process=$(echo "$ps_output" | awk -v user="$username" '$1 == user')

	# Extract the VSZ values from column 5
	local vsz_values=$(echo "$user_process" | awk '{print $5}')

	# Filter for numeric VSZ values
	local numeric_vsz=$(echo "$vsz_values" | grep -E '^[0-9]+$')
	
	# Echo the final VSZ values
	echo "$numeric_vsz"
}


combine_vsz_usage()
{
	local username=$1
	
	# Get VSZ values using get_vsz_usage
	local vsz_values=$(get_vsz_usage "$username")	

	local total=0

	if [ -z "$vsz_values" ]; then
		echo "ERROR: No VSZ values found for user $username."
		exit 1
	fi

	# Loop through each VSZ values
	for vsz in $vsz_values; do
		total=$((total + vsz))
	done
	
	# Echo the total sum
	echo "$total"
}


find_largest_vsz()
{
	local username=$1

	# Get VSZ values for the user using get_vsz_usage
	local vsz_values=$(get_vsz_usage "$username")

	if [ -z "$vsz_values" ]; then
		echo "ERROR: No VSZ values found for user $username"
		exit 1
	fi

	local largest=0

	# Loop through each vsz values and compare each
	for vsz in $vsz_values; do
		if [ "$vsz" -gt "$largest" ]; then
			largest=$vsz
		fi
	done
	

	# Echo largest value
	echo "$largest"
}

main()
{
	# Main function
	local username=$1
	local threshold=$2

	# Checks if username is provided
	if [ -z "$username" ]; then
		echo "ERROR: username is required"
		exit 1
	fi

	# Checks if threshold is provided
	
	if [ -z "$threshold" ]; then
		echo "ERROR: threshold is required."
		exit 1
	fi
	
	# Get total VSZ and largest VSZ
	vsz_values=$(get_vsz_usage "$username")

	if [ -z "$vsz_values" ]; then
		echo "ERROR: Failed to get VSZ usage for user $username."
		exit 1
	fi
	
	total_vsz=$(combine_vsz_usage "$username")
	peak_vsz=$(find_largest_vsz "$username")

	# Echo total VSZ	
	echo "$username: $total_vsz $peak_vsz"

	# Alert for Total and Peak
	if [ "$total_vsz" -gt "$threshold" ]; then
		echo "ALERT: $username: exceeded VSZ threshold ($total_vsz total)" 1>&2
	fi

	# check if peak exceeds the threshold
	if [ "$peak_vsz" -gt "$threshold" ]; then
		echo "ALERT: $username: exceeded VSZ threshold ($peak_vsz peak)" 1>&2
	fi	


}

# Call the main function with the arguments
main "$@"

