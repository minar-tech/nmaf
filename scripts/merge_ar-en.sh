# Define directories
ar_dir="C:/Users/mikan/GIT/nmaf/law/footnotes/ar/html"
en_dir="C:/Users/mikan/GIT/nmaf/law/footnotes/en/html"
output_dir="C:/Users/mikan/GIT/nmaf/law/footnotes/ar-en/html"

# Make sure the output directory exists
mkdir -p "$output_dir"

# Define file names for the test
ar_file="$ar_dir/footnote_ar_001.html"
en_file="$en_dir/footnote_en_001.html"
output_file="$output_dir/footnote_ar-en_001.html"

# Extract only the inner content (within <body>) from Arabic and English files
ar_content=$(awk '/<body>/,/<\/body>/' "$ar_file" | sed '1d;$d')
en_content=$(awk '/<body>/,/<\/body>/' "$en_file" | sed '1d;$d')

# Combine into a single file with the specified HTML structure
cat <<EOF > "$output_file"
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" lang="" xml:lang="">
<head>
  <meta charset="utf-8" />
  <meta name="generator" content="pandoc" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=yes" />
  <title>footnote_ar_001</title>
</head>
<body>
<header id="title-block-header">
<h1>footnote_ar-en_001</h1>
</header>
<div name="content-ar" style="text-align:right;direction:rtl">
$ar_content
</div>
<div name="content-en" style="text-align:left;direction:ltr">
$en_content
</div>
</body>
</html>
EOF

echo "Test merge complete. Check $output_file for results."
