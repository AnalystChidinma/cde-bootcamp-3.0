#! /bin/bash

set -e  # this help to stop the scripts if a command fails

echo "simple bash etl pipeline"

# create the environmental variable for the source URL
# Instead of hardcoding the URL inside curl, we store it in CSV_URL
export CSV_URL="https://www.stats.govt.nz/assets/Uploads/Annual-enterprise-survey/Annual-enterprise-survey-2023-financial-year-provisional/Download-d>

# automatically get the  absolute path of the project location
BASE_DIR="$(cd "$(dirname "$0")/.." && pwd)"

# use command sudtitution
BASE_DIR="$(pwd)"

RAW_DIR="$BASE_DIR/raw"
CLEANED_DIR="$BASE_DIR/Transform"
GOLD_DIR="$BASE_DIR/Gold"

RAW_DATA="$RAW_DIR/annual-enterprise-survey-2023-financial-year-provisional.csv"

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
