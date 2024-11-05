#!/bin/bash

# Buckets
INPUT_BUCKET="nmaf_input-bucket-1"
OUTPUT_BUCKET="nmaf_output-bucket"
TARGET_LANG="en"  # Target language code
PROJECT_ID="your_project_id"  # Replace with your actual Google Cloud project ID

# List files in the input bucket
for FILE in $(gsutil ls gs://$INPUT_BUCKET/*.html); do
    # Download the file content
    FILE_NAME=$(basename "$FILE")
    gsutil cp "$FILE" "$FILE_NAME"
    
    # Read file content
    CONTENT=$(cat "$FILE_NAME")

    # Call the Translation API v3
    TRANSLATED_TEXT=$(curl -s -X POST \
      -H "Authorization: Bearer $(gcloud auth application-default print-access-token)" \
      -H "Content-Type: application/json; charset=utf-8" \
      -d "{
            'contents': [\"$CONTENT\"],
            'mimeType': 'text/html', 
            'targetLanguageCode': '$TARGET_LANG'
          }" \
      "https://translation.googleapis.com/v3/projects/$PROJECT_ID/locations/global:translateText" | jq -r '.translations[0].translatedText')

    # Save the translated text to a new file
    TRANSLATED_FILE="translated_$FILE_NAME"
    echo "$TRANSLATED_TEXT" > "$TRANSLATED_FILE"

    # Upload the translated file to the output bucket
    gsutil cp "$TRANSLATED_FILE" gs://$OUTPUT_BUCKET/
    
    # Clean up local files
    rm "$FILE_NAME" "$TRANSLATED_FILE"
    
    echo "Translated $FILE_NAME and uploaded to $OUTPUT_BUCKET"
done
