#!/bin/bash
# Append a single timestamp to a new file and sign it

PRIVATE_KEY="private_key.pem"
FILE_TO_SIGN=$1

if [[ ! -f "$FILE_TO_SIGN" ]]; then
    echo "Error: File $FILE_TO_SIGN not found!"
    exit 1
fi

# Extract the base filename without extension
BASE_NAME="${FILE_TO_SIGN%.*}"

# Get the current timestamp
TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")

# Create a fresh timestamped file
TIMESTAMPED_FILE="${BASE_NAME}.timestamped.txt"
cp "$FILE_TO_SIGN" "$TIMESTAMPED_FILE"
echo "$TIMESTAMP" > "$TIMESTAMPED_FILE"  # Overwrite instead of appending

# Sign the timestamped file
SIGNATURE_FILE="${BASE_NAME}.signature.txt"
openssl dgst -sha256 -sign "$PRIVATE_KEY" -out "$SIGNATURE_FILE" "$TIMESTAMPED_FILE"

echo "Signed file: $SIGNATURE_FILE"
echo "Timestamped file: $TIMESTAMPED_FILE"
echo "Timestamp added: $TIMESTAMP"

