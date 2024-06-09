#!/bin/bash

# Check if stock symbol is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <stock_symbol>"
    exit 1
fi

# Alpha Vantage API key
API_KEY="H0QWEJOV8Q71CW1O"

# Stock symbol
SYMBOL="$1"

# Fetch data from Alpha Vantage
JSON=$(curl -s "https://www.alphavantage.co/query?function=TIME_SERIES_DAILY&symbol=$SYMBOL&apikey=$API_KEY")

# Check if the API request was successful
ERROR=$(echo "$JSON" | jq -r '.Error')
if [ "$ERROR" != "null" ]; then
    echo "Error: $ERROR"
    exit 1
fi

# Extract relevant information from JSON
PRICE=$(echo "$JSON" | jq -r '.["Time Series (Daily)"] | to_entries | .[0].value."4. close"')
HIGH=$(echo "$JSON" | jq -r '.["Time Series (Daily)"] | to_entries | .[].value."2. high"' | head -n 1)
LOW=$(echo "$JSON" | jq -r '.["Time Series (Daily)"] | to_entries | .[].value."3. low"' | head -n 1)

# Function to print a colored cell
print_cell() {
    if [[ $1 == "up" ]]; then
        printf "\e[38;5;46m%-20s\e[0m" "$2"
    elif [[ $1 == "down" ]]; then
        printf "\e[38;5;196m%-20s\e[0m" "$2"
    else
        printf "%-20s" "$2"
    fi
}

# Determine if the stock is up or down
if [ -n "$PRICE" ]; then
    PREV_PRICE=$(echo "$JSON" | jq -r '.["Time Series (Daily)"] | to_entries | .[1].value."4. close"')
    if [ "$(awk 'BEGIN {print ('$PRICE' >= '$PREV_PRICE') ? "true" : "false"}')" == "true" ]; then
        TREND="up"
    else
        TREND="down"
    fi
fi

# Print the table header
printf "\e[1m%-20s%-20s%-20s\e[0m\n" "Stock" "Price" "High/Low"
# Print the table row
printf "%-20s" "$SYMBOL"
if [ -z "$PRICE" ]; then
    print_cell "neutral" "Data not available"
else
    print_cell "$TREND" "$PRICE"
fi
if [ -z "$HIGH" ] || [ -z "$LOW" ]; then
    print_cell "neutral" "Data not available"
else
    print_cell "neutral" "High: $HIGH\Low: $LOW"
fi
echo

