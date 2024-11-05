#!/bin/bash

# Define the directory containing the HTML files
HTML_DIR="C:/Users/mikan/GIT/nmaf/law/footnotes/ar/html"

# Loop over each HTML file in the directory
for filepath in "$HTML_DIR"/*.html; do
    # Check if the file exists
    if [[ -f "$filepath" ]]; then
        echo "Processing $filepath..."

        # Use awk to add <div name="content-ar"> around all <p> tags
        awk '
        BEGIN { inside_body = 0; started_div = 0 }
        /<body[^>]*>/ { print; inside_body = 1; next }
        /<\/body>/ { inside_body = 0 }

        {
            if (inside_body && $0 ~ /<p[^>]*>/) {
                # Start the <div> tag before the first <p> tag
                if (!started_div) {
                    print "<div name=\"content-ar\">"
                    started_div = 1
                }
            }
            print
        }

        END {
            # Close the <div> tag if it was opened and we are still in <body>
            if (started_div) {
                print "</div>"
            }
        }
        ' "$filepath" | sed '/<\/body>/i </div>' > "${filepath}.tmp"

        # Replace the original file with the modified content
        mv "${filepath}.tmp" "$filepath"

        echo "Processed $filepath successfully."
    fi
done
