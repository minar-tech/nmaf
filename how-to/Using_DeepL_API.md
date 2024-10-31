Currently, **DeepL does not officially support Arabic**, which limits its application here. However, if you’re interested in translating other languages that DeepL supports, here’s a similar process to follow:

### Requirements for Using DeepL API
1. **Create a DeepL API Account**:
   - Go to the [DeepL website](https://www.deepl.com/pro) and sign up for an API account (a paid subscription is typically required).
   - Obtain your API key from the DeepL Console after setting up the account.

2. **Install Required Libraries**:
   ```bash
   pip install requests beautifulsoup4
   ```

### Python Script for Batch Translation with DeepL

Here’s a script to translate HTML files using DeepL. If you use this for supported languages, it will fetch each file, translate the content, and save it in the same structure as the original.

```python
import json
import requests
import os
from bs4 import BeautifulSoup

# Load the JSON file with URLs
with open("footnotes_urls.json", "r") as file:
    urls = json.load(file)["files"]

# DeepL API setup
DEEPL_API_KEY = "your_deepl_api_key"  # Replace with your DeepL API key
DEEPL_URL = "https://api.deepl.com/v2/translate"

def translate_text_with_deepl(text, target_lang="EN"):
    """Translates text using DeepL API."""
    params = {
        "auth_key": DEEPL_API_KEY,
        "text": text,
        "target_lang": target_lang
    }
    response = requests.post(DEEPL_URL, data=params)
    response.raise_for_status()
    return response.json()["translations"][0]["text"]

def translate_html_content(html_content, target_lang="EN"):
    """Translates supported language text in HTML, preserving structure."""
    soup = BeautifulSoup(html_content, "html.parser")
    
    # Translate text nodes while preserving HTML tags
    for element in soup.find_all(string=True):
        if element.strip():
            translated_text = translate_text_with_deepl(element, target_lang)
            element.replace_with(translated_text)
    return str(soup)

# Directory to save translated HTML files
output_dir = "translated_html_files_deepl"
os.makedirs(output_dir, exist_ok=True)

for index, url in enumerate(urls, start=1):
    print(f"Translating file {index} of {len(urls)}: {url}")
    
    # Fetch HTML content from URL
    response = requests.get(url)
    response.raise_for_status()
    
    # Translate HTML content
    translated_html = translate_html_content(response.text, target_lang="EN")
    
    # Save the translated HTML file
    output_path = os.path.join(output_dir, f"footnote_en_{str(index).zfill(3)}.html")
    with open(output_path, "w", encoding="utf-8") as file:
        file.write(translated_html)

print(f"Translation completed. Files saved in '{output_dir}' directory.")
```

### Explanation

1. **DeepL Translation Function**:
   - `translate_text_with_deepl()` sends text segments to the DeepL API, translating into the specified target language.
   - The function fetches translations only if DeepL supports the language pair (e.g., Arabic isn’t yet supported).

2. **HTML Parsing and Structure Preservation**:
   - `translate_html_content()` uses `BeautifulSoup` to parse the HTML content, sending only the textual parts for translation.
   - It saves translated files in the `translated_html_files_deepl` directory, with filenames like `footnote_en_001.html`.

3. **Running the Script**:
   - Run this script in the directory containing `footnotes_urls.json`.

If you need support for languages outside Arabic using this script, or any other details for this setup, let me know!