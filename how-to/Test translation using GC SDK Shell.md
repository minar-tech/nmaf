**Test translation using GC SDK Shell**

Certainly! Here’s a `.sh` script that you can run in **Google Cloud Shell** or any bash-compatible terminal that has **Google Cloud SDK** installed and authenticated.

This script performs a simple text translation from Arabic to English using **Google Cloud Translation API v3**. 

### Test Translation Script: `translate_test.sh`

1. **Create the Script**:

   Copy the following code into a new file named `translate_test.sh`:

   ```bash
   #!/bin/bash

   # Replace YOUR_PROJECT_ID with your actual project ID
   PROJECT_ID="YOUR_PROJECT_ID"
   
   # Arabic text to translate
   TEXT="تجربة ترجمة النص"
   
   # Language codes
   SOURCE_LANG="ar"
   TARGET_LANG="en"

   # Get the access token
   ACCESS_TOKEN=$(gcloud auth application-default print-access-token)

   # Perform the translation
   RESPONSE=$(curl -s -X POST \
     -H "Authorization: Bearer ${ACCESS_TOKEN}" \
     -H "Content-Type: application/json; charset=utf-8" \
     -d "{
          'parent': 'projects/${PROJECT_ID}/locations/global',
          'contents': ['${TEXT}'],
          'mimeType': 'text/plain',
          'sourceLanguageCode': '${SOURCE_LANG}',
          'targetLanguageCode': '${TARGET_LANG}'
        }" \
     "https://translation.googleapis.com/v3/projects/${PROJECT_ID}/locations/global:translateText")

   # Extract translated text from JSON response
   TRANSLATED_TEXT=$(echo $RESPONSE | jq -r '.translations[0].translatedText')

   # Display the result
   echo "Original Text: $TEXT"
   echo "Translated Text: $TRANSLATED_TEXT"
   ```

2. **Script Explanation**:
   - **`PROJECT_ID`**: Replace `"YOUR_PROJECT_ID"` with your Google Cloud project ID.
   - **`TEXT`**: Set the Arabic text you want to translate.
   - **`ACCESS_TOKEN`**: Uses `gcloud` to fetch the current access token for authorization.
   - **`RESPONSE`**: Uses `curl` to send the translation request to the API.
   - **`TRANSLATED_TEXT`**: Extracts the translated text from the API’s JSON response using `jq`. Ensure `jq` is installed in Cloud Shell (it’s typically pre-installed).

3. **Make the Script Executable**:

   In your terminal, run:

   ```bash
   chmod +x translate_test.sh
   ```

4. **Run the Script**:

   Execute the script with:

   ```bash
   ./translate_test.sh
   ```

### Expected Output

If successful, the script will display the original Arabic text and its English translation:

```plaintext
Original Text: تجربة ترجمة النص
Translated Text: Text translation test
```

If you encounter an error, check the API key, project ID, and verify that the Translation API is enabled.