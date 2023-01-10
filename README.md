# Optimize-Manga-pages
Change colored pngs to jpg and reduce pngs


  if png has rgb colorspace

  if png colorspace is not optimized palette

  convert to HSB and get saturation

  if saturation is lower than 5% convert rgb png to grayscale png

  if saturation is higher than 5% convert color png to quality 80 jpg
  
# Usage

The Magick version is using only ImageMagick

The Pingo version is using pingo for smallest b&w jpg size
