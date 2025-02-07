#!/bin/bash
# Verify a digital signature and extract the timestamp from the signed file

PUBLIC_KEY="public_key.pem"
SIGNED_FILE=$1

if [[ ! -f "$SIGNED_FILE" ]]; then
    echo "Error: Signed file $SIGNED_FILE not found!"
    exit 1
fi

# Extract the base filename (remove .timestamped.txt extension)
BASE_NAME="${SIGNED_FILE%.timestamped.txt}"

# Define the correct signature file name
SIGNATURE_FILE="${BASE_NAME}.signature.txt"

if [[ ! -f "$SIGNATURE_FILE" ]]; then
    echo "Error: Signature file $SIGNATURE_FILE not found!"
    exit 1
fi

# Verify the signature
openssl dgst -sha256 -verify "$PUBLIC_KEY" -signature "$SIGNATURE_FILE" "$SIGNED_FILE"

if [[ $? -eq 0 ]]; then
    echo "Signature is valid."
    echo "Extracted Timestamp:"
    tail -n 1 "$SIGNED_FILE"
else
    echo "Signature verification failed!"
fi

