Yes, you can use Google Cloud Shell along with command-line tools to translate the files without relying on a Python script. Here’s how you can do it using a combination of `gsutil` and `curl` to call the Translation API directly from the shell:

### Steps to Translate Files in Google Cloud Shell

1. **Enable the Translation API**:
   - First, make sure the [Cloud Translation API](https://console.cloud.google.com/flows/enableapi?apiid=translate.googleapis.com) is enabled in your Google Cloud project.

2. **Set Up Authentication**:
   - In Cloud Shell, authenticate using:
     ```bash
     gcloud auth application-default login
     ```

3. **Prepare a Shell Script for Translation**:
   - The following `bash` script will:
     - Download each HTML file from `nmaf_input-bucket-1`.
     - Send the content to the Translation API using `curl`.
     - Upload the translated content to `nmaf_output-bucket`.

   Save this script in Cloud Shell as `translate_files.sh`:

   ```bash
   #!/bin/bash
   
   # Buckets
   INPUT_BUCKET="nmaf_input-bucket-1"
   OUTPUT_BUCKET="nmaf_output-bucket"
   TARGET_LANG="en"  # Target language code
   
   # List files in the input bucket
   for FILE in $(gsutil ls gs://$INPUT_BUCKET/*.html); do
       # Download the file content
       FILE_NAME=$(basename "$FILE")
       gsutil cp "$FILE" "$FILE_NAME"
       
       # Read file content
       CONTENT=$(cat "$FILE_NAME")
   
       # Call the Translation API
       TRANSLATED_TEXT=$(curl -s -X POST \
         -H "Authorization: Bearer $(gcloud auth application-default print-access-token)" \
         -H "Content-Type: application/json; charset=utf-8" \
         -d "{\"q\": \"$CONTENT\", \"target\": \"$TARGET_LANG\"}" \
         "https://translation.googleapis.com/language/translate/v2" | jq -r '.data.translations[0].translatedText')
   
       # Save the translated text to a new file
       TRANSLATED_FILE="translated_$FILE_NAME"
       echo "$TRANSLATED_TEXT" > "$TRANSLATED_FILE"
   
       # Upload the translated file to the output bucket
       gsutil cp "$TRANSLATED_FILE" gs://$OUTPUT_BUCKET/
       
       # Clean up local files
       rm "$FILE_NAME" "$TRANSLATED_FILE"
       
       echo "Translated $FILE_NAME and uploaded to $OUTPUT_BUCKET"
   done
   ```

4. **Make the Script Executable**:
   - Make sure the script is executable by running:
     ```bash
     chmod +x translate_files.sh
     ```

5. **Run the Script**:
   - Execute the script in Cloud Shell:
     ```bash
     ./translate_files.sh
     ```

### Explanation:
- **`gsutil`** commands are used to list, download, and upload files.
- **`curl`** calls the Translation API, and **`jq`** parses the JSON output to extract the translated text.
- Each translated file is uploaded to `nmaf_output-bucket` with the same filename, prefixed with `translated_` to distinguish it.

This approach allows you to stay fully within Google Cloud Shell and automates the translation and file management process. Let me know if you encounter any issues!