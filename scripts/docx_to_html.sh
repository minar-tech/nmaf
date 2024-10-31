#!/bin/bash

# Set the directory containing the .docx files
input_dir="/mnt/c/Users/mikan/GIT/nmaf/law/footnotes/ar/docx"
output_dir="/mnt/c/Users/mikan/GIT/nmaf/law/footnotes/ar/html"

# Check if output directory exists, if not, create it
if [ ! -d "$output_dir" ]; then
    mkdir -p "$output_dir"
fi

# Loop through each .docx file in the input directory
for file in "$input_dir"/*.docx; do
    # Get filename without extension
    filename=$(basename "$file" .docx)
    
    # Convert .docx to .html using Pandoc, ensuring paragraphs are preserved in HTML structure
    pandoc "$file" -f docx -t html -s -o "$output_dir/$filename.html" \
    --metadata title="$filename" \
    --wrap=preserve \
    --no-highlight \
    --standalone

    # Adjust HTML to ensure paragraph tags are kept separate for clear structure
    sed -i 's/<p>/<p>\n/g' "$output_dir/$filename.html"  # Optional, add line breaks for readability
done

echo "Conversion completed!"

