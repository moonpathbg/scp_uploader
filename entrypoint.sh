#!/bin/bash
echo "Saving key to file..."
echo -e "${INPUT_KEY}" > key.txt

echo "Set key file access rights..."
chmod 600 key.txt

echo "Starting SCP process..."
scp -qrv -P $INPUT_PORT -o StrictHostKeyChecking=no -i key.txt $INPUT_SOURCE "$INPUT_USERNAME"@"$INPUT_HOST":"$INPUT_TARGET" || exit 1
echo "SCP operation completeted."
