# ocr-pdf.sh
 Convert scanned pdf file without text to searcheable pdf.

## Requirements
- tesseract, used for OCR
- pngquant, used for png quality reduction
- pdfunite, used to assemble the final pdf document

### Ubuntu 22
```sh
apt-get install tesseract-ocr tesseract-ocr-eng pngquant poppler-utils
```

### Archlinux
```sh
pacman -S tesseract tesseract-data-eng pngquant poppler
```

## Usage
```sh
$ ./ocr-pdf.sh input.pdf output.pdf
```
