I'm glad the download was successful! As for the empty files containing only `"null"`, it could indeed indicate an issue with the translation process. However, Arabic **is supported** by Google Cloud Translation, so it’s not a limitation of the language itself.

Here are some potential reasons why the translation might have failed:

1. **File Content Issues**:
   - If the original files had any formatting issues, empty content, or characters that caused parsing errors, Google Translate might have returned `"null"` as a result.
   
2. **API Usage or Quota Limits**:
   - Google Cloud imposes usage quotas on the Translation API, and if a quota limit was reached, it could result in empty responses.
   - Check your Google Cloud Console under **APIs & Services** > **Dashboard** to see if any usage limits were hit.

3. **Translation Script or Command**:
   - There might have been a bug in the script or command used to translate the files. If the content wasn’t properly sent to the Translation API, it could have returned `"null"`.

### Suggestions to Troubleshoot

1. **Test Translation of a Single File**:
   - Try translating a single Arabic file manually using the Translation API or even in the Google Cloud Console to see if the translation returns correctly.
   - You can use `curl` or test the translation directly in Google Cloud Console’s **Translate API** testing interface.

2. **Inspect Script for Errors**:
   - Revisit the script to ensure that each Arabic file's content is correctly read, processed, and sent to the Translation API.
   - Check for any error messages or logs that might indicate why it returned `"null"`.

3. **Check API Quotas**:
   - Go to **APIs & Services** > **Dashboard** > **Translation API** and check the **Quotas** tab to see if any limits were exceeded.

If you'd like, I can help you troubleshoot the script or command used for translation, which may provide more clues on why the files ended up empty.