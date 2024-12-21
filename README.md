# VSZ Usage Monitor Script

This script monitors Virtual Memory Size (VSZ) usage of processes running under a specific user. It helps track and manage the memory usage of a user's processes by calculating the total VSZ and identifying the peak VSZ usage. If either total or peak VSZ usage exceeds a specified threshold, an alert will be triggered.

## Features

- **Get VSZ Usage:** Fetches the Virtual Memory Size (VSZ) for all processes belonging to a specific user.
- **Total VSZ Calculation:** Sums up the VSZ values for all user processes.
- **Peak VSZ Identification:** Finds the largest VSZ value from the user’s processes.
- **Threshold Alerts:** Compares the total and peak VSZ values against a threshold and generates alerts if the values exceed it.

## Usage

The script takes two parameters:

1. **username**: The username of the user whose processes you want to monitor.
2. **threshold**: The VSZ threshold (in KB) to trigger an alert if exceeded.

### Command Syntax

```bash
./minimon.sh <username> <threshold>
```

### Example

```bash
./minimon.sh john 500000
```

This command will monitor the VSZ usage for the user `john` and trigger an alert if the total or peak VSZ exceeds 500,000 KB.

## Functions

### `get_vsz_usage()`

This function retrieves the list of VSZ values for all processes belonging to a specified user.

- **Arguments:**
  - `username`: The user whose processes' VSZ will be fetched.
  
- **Returns:**
  - A list of VSZ values in KB for the specified user's processes.

### `combine_vsz_usage()`

This function calculates the total VSZ usage by summing the individual VSZ values.

- **Arguments:**
  - `username`: The user whose VSZ usage is to be summed up.

- **Returns:**
  - The total VSZ usage (sum of individual VSZ values).

### `find_largest_vsz()`

This function finds the largest (peak) VSZ value among the user's processes.

- **Arguments:**
  - `username`: The user whose largest VSZ value is to be found.

- **Returns:**
  - The largest VSZ value (in KB) from the specified user's processes.

### `main()`

The main function that orchestrates the script's operations, including:

- Fetching the total and peak VSZ values for a given user.
- Checking if either the total or peak VSZ exceeds the provided threshold.
- Displaying appropriate alerts if the threshold is exceeded.

- **Arguments:**
  - `username`: The user whose processes' VSZ will be monitored.
  - `threshold`: The threshold to trigger alerts if exceeded.

## Installation

1. Download or clone the repository containing this script.
2. Make the script executable:

   ```bash
   chmod +x minimon.sh
   ```

3. Run the script by passing the username and threshold as arguments.

## Error Handling

The script includes error handling for the following scenarios:

- **No username provided**: The script will terminate with an error message.
- **No threshold provided**: The script will terminate with an error message.
- **No processes found for the specified user**: The script will notify that no VSZ values were found.
- **Threshold exceeded**: An alert will be generated if the total or peak VSZ exceeds the threshold.

## Contribution

If you have suggestions for improvements or additional features, feel free to fork the repository, make changes, and create a pull request.

## License

This script is open-source and licensed under the MIT License.
