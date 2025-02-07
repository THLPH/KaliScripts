#!/bin/bash
# Encrypt all .txt files using OpenSSL pkeyutl

PUBLIC_KEY="public_key.pem"

for file in *.txt; do
    if [[ -f "$file" ]]; then
        output_file="${file%.txt}.encrypted.txt"
        openssl pkeyutl -encrypt -pubin -inkey "$PUBLIC_KEY" -in "$file" -out "$output_file"
        echo "Encrypted: $file -> $output_file"
    fi
done
