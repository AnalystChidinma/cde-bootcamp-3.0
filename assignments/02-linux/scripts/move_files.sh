#!/bin/bash

echo "move all CSV and JSON files from one folder to another folder named json_and_CSV"

set -e # for error handling

SOURCE_DIR="$(cd "$(dirname "$0")/.." && pwd)"

DEST_DIR="$SOURCE_DIR/json_and_csv"


# To track if any file was found and move the files

files_found=false


for file in "$SOURCE_DIR"/*.csv; do # to move the csv files
    if [ -f "$file" ]; then
        echo "Moving CSV: $(basename "$file")"
        mv "$file" "$DEST_DIR/"
        files_found=true
    fi
done


for file in "$SOURCE_DIR"/*.json; do # to move the json files
    if [ -f "$file" ]; then
        echo "Moving JSON: $(basename "$file")"
        mv "$file" "$DEST_DIR/"
        files_found=true
    fi
done

if [ "$files_found" = true ]; then
    echo
    echo "CSV and JSON files have been moved successfully"
else
    echo
    echo "No CSV or JSON files found in the source directory."
fi
