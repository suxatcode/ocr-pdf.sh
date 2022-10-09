#!/usr/bin/bash
if [[ $# -ne 2 ]]; then
  echo "usage: $0 <original-pdf-w/o-text> <destination-pdf-with-OCR'ed-text>"
fi
set -e
language="eng"
reduce_png_quality=true
orig="$1"
dst="$2"
begin=$(date +%s)
tmpdir=$(mktemp -d)
echo "Temporary files @ $tmpdir"
pdftoppm "$orig" "$tmpdir/tmp" -png
for img in "$tmpdir/tmp"-*.png; do
  ocrimg="$tmpdir/small_${img##*/}"
  if [[ "$reduce_png_quality" == true ]]; then
    pngquant --quality=20-70 --strip --output="$ocrimg" "$img"
  else
    ocrimg="$img"
  fi
  tesseract "$ocrimg" "${img%.png}" -l "$language" pdf
done
pdfunite "$tmpdir/tmp"-*.pdf "$dst"
rm -r "$tmpdir"
end=$(date +%s)
total=$(( end - begin ))
seconds=$(( total % 60 ))
minutes=$(( total / 60 ))
echo "OCR took $minutes m $seconds s"
