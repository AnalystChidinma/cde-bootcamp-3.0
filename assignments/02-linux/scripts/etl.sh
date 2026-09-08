#! /bin/bash

set -e  # this help to stop the scripts if a command fails

echo "simple bash etl pipeline"

# create the environmental variable for the source URL
# Instead of hardcoding the URL inside curl, we store it in CSV_URL
export CSV_URL="https://www.stats.govt.nz/assets/Uploads/Annual-enterprise-survey/Annual-enterprise-survey-2023-financial-year-provisional/Download-data/annual-enterprise-survey-2023-financial-year-provisional.csv"

# automatically get the  absolute path of the project location
BASE_DIR="$(cd "$(dirname "$0")/.." && pwd)"

# use command sudtitution

RAW_DIR="$BASE_DIR/raw"

CLEANED_DIR="$BASE_DIR/Transformed"

GOLD_DIR="$BASE_DIR/Gold"

echo "extracting data from the source URL and saving it to the raw directory"

RAW_DATA="$RAW_DIR/annual-enterprise-survey-2023-financial-year-provisional.csv"


echo "downloading CSV file"

curl -L "$CSV_URL" -o "$RAW_DATA"

if [ -f "$RAW_DATA" ]; then
	echo "Raw Data exit and downloaded successfully"

else
	echo "Raw Data does not exit and can not be downloaded"
	exit 1
fi

echo "-------------------------------------------------------------------------"

echo "Performing a simple Transformation"
TRANSFORMED_DATA="$CLEANED_DIR/2023_year_finance.csv"

awk -F',' '
BEGIN {
    OFS=","
}
NR == 1 {
    for (i = 1; i <= NF; i++) {
        if ($i == "year") year_col = i
        if ($i == "Value") value_col = i
        if ($i == "Units") units_col = i
        if ($i == "Variable_code") variable_col = i
    }

    print "year", "Value", "Units", "variable_code"
    next
}
{
    print $year_col, $value_col, $units_col, $variable_col
}
' "$RAW_DATA" > "$TRANSFORMED_DATA"

if [ -f "$TRANSFORMED_DATA" ]; then
	echo "File Transformed successfully and file content is saved to:"
	echo "$TRANSFORMED_DATA"
else
    echo "File Transformation failed."
    exit 1
fi

echo "-------------------------------------------------------------------------------------"
echo "Load the transformed data into a directory named Gold"

cp "$TRANSFORMED_DATA" "$GOLD_DIR/"

# to confirm that the file has been copied successfully using loop

if [ -f "$GOLD_DIR/$(basename "$TRANSFORMED_DATA")" ]; then
    echo "file uploaded successfully into Gold"
    echo "$GOLD_DIR/$(basename "$TRANSFORMED_DATA")"
else
    echo "ERROR: File was not loaded into Gold"
    exit 1
fi
