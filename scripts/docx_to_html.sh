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
    
    # Convert .docx to .html using Pandoc, setting the title metadata
    pandoc "$file" -f docx -t html -s -o "$output_dir/$filename.html" --metadata title="$filename"
done

echo "Conversion completed!"
