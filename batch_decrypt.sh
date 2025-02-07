#!/bin/bash
# Decrypt all .encrypted.txt files using OpenSSL pkeyutl

PRIVATE_KEY="private_key.pem"

for file in *.encrypted.txt; do
    if [[ -f "$file" ]]; then
        output_file="${file%.encrypted.txt}.decrypted.txt"
        openssl pkeyutl -decrypt -inkey "$PRIVATE_KEY" -in "$file" -out "$output_file"
        echo "Decrypted: $file -> $output_file"
    fi
done
