**I would now like to make a batch translation of my 144 files. Is there a range of output formats to select from (docx, md, html)?**

With Google Cloud Translation Advanced (v3), you can perform batch translations of your 144 files. The supported input and output formats for batch text translation are:

- **Plain Text** (`.txt`)
- **HTML** (`.html`)
- **Tab-Separated Values** (`.tsv`)

These formats are suitable for translating large volumes of text while preserving basic formatting. citeturn0search0

If your documents are in formats like Microsoft Word (`.docx`), Markdown (`.md`), or other rich text formats, you have two options:

1. **Convert to Supported Formats**: Convert your documents to plain text or HTML before translation. This approach is straightforward but may result in the loss of complex formatting.

2. **Use Document Translation**: For preserving the original formatting and layout, consider using the Document Translation feature of Cloud Translation Advanced. This feature supports batch translation of various document formats, including:

   - Microsoft Word (`.doc`, `.docx`)
   - PDF (`.pdf`)
   - Microsoft PowerPoint (`.ppt`, `.pptx`)
   - Microsoft Excel (`.xls`, `.xlsx`)

Document Translation maintains the original structure and formatting of your documents, ensuring that the translated versions closely resemble the originals. citeturn0search0

Please note that Markdown (`.md`) files are not directly supported by either batch text translation or Document Translation. To translate Markdown files, you can convert them to HTML, perform the translation, and then convert them back to Markdown.

For detailed information on supported formats and how to perform batch translations, refer to the [Supported formats quick reference](https://cloud.google.com/translate/docs/supported-formats) and [Batch requests (Advanced)](https://cloud.google.com/translate/docs/advanced/batch-translation) documentation. 