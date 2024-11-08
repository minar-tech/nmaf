#!/bin/bash

# Set the directory containing the .docx files
input_dir="/c/Users/mikan/GIT/nmaf/law/footnotes/ar/docx"
output_dir="/c/Users/mikan/GIT/nmaf/law/footnotes/ar/html"

# Check if output directory exists, if not, create it
if [ ! -d "$output_dir" ]; then
    mkdir -p "$output_dir"
fi

# Create an external CSS file if it doesn’t already exist
css_file="$output_dir/style.css"
if [ ! -f "$css_file" ]; then
    cat <<EOL > "$css_file"
body {
    margin: 0 auto;
    max-width: 36em;
    padding: 50px;
    font-kerning: normal;
}
div[dir="rtl"] {
    direction: rtl;
    text-align: right;
}
p {
    margin: 1em 0;
}
blockquote {
    margin: 1em 0 1em 1.7em;
    padding-left: 1em;
    border-left: 2px solid #e6e6e6;
    color: #606060;
}
EOL
fi

# Loop through each .docx file in the input directory
for file in "$input_dir"/*.docx; do
    # Get filename without extension
    filename=$(basename "$file" .docx)

    # Convert .docx to .html using Pandoc
    pandoc "$file" -f docx -t html -s -o "$output_dir/$filename.html" \
    --metadata title="$filename" \
    --wrap=preserve \
    --no-highlight \
    --standalone

    # Insert a link to the external CSS file and add a surrounding div for RTL alignment
    sed -i 's|</head>|<link rel="stylesheet" href="style.css" />\n</head>|' "$output_dir/$filename.html"
    sed -i 's/<body>/<body><div dir="rtl">/' "$output_dir/$filename.html"
    sed -i 's|</body>|</div></body>|' "$output_dir/$filename.html"

    # Remove redundant RTL span tags
    sed -i 's|<span dir="rtl">||g' "$output_dir/$filename.html"
    sed -i 's|</span>||g' "$output_dir/$filename.html"

    # Remove the <style> tag and its contents
    sed -i '/<style/,/<\/style>/d' "$output_dir/$filename.html"

    # Optional: Add line breaks for paragraph readability
    sed -i 's/<p>/<p>\n/g' "$output_dir/$filename.html"
done

echo "Conversion completed, with external CSS applied and internal <style> tags removed!"
