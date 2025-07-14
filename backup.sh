#!/bin/bash

targetDirectory="~/target_directory"
destinationDirectory="~/backup_destination"

echo "Target Directory: $targetDirectory"
echo "Destination Directory: $destinationDirectory"

currentTS=$(date +%s)

backupFileName="backup-$currentTS.tar.gz"

origAbsPath=$(realpath "$targetDirectory")

destAbsPath=$(realpath "$destinationDirectory")

cd "$origAbsPath"

yesterdayTS=$(($currentTS - 86400))

declare -a toBackup
for file in $(ls); do

    
    if [ $(date -r "$file" +%s) -ge $yesterdayTS ]; then
        
        
        toBackup+=("$file")
    fi
done

tar -czf "$backupFileName" "${toBackup[@]}"

mv "$backupFileName" "$destAbsPath"
