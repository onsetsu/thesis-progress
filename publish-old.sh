#!/bin/bash

FILE="/c/Users/Stephi/Owncloud/thesis/swathesis-master/Platz_2013_Grouping_Micro_Changes"
PDF_FILE=${FILE}.pdf
TEX_FILE=${FILE}.tex

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PUBLIC="/c/Users/Stephi/Dropbox/Public/thesis"
JSON="${PUBLIC}/data.js"
WORDS="${PUBLIC}/words.part"
PAGES="${PUBLIC}/pages.part"

#echo "${HOME}"
#echo "${PDF_FILE}"
#echo "${TEX_FILE}"

if [ ! -f ${PDF_FILE} ];
then
  echo "Please build the PDF first!"
  exit 1
fi

# publish stuff
echo $(date +%s)

DATE=$(date +%s)

# A magic mean value of words
PDFTOTEX_COUNT_1=$(pdftotext  -nopgbrk ${PDF_FILE} - | wc -w)
PDFTOTEX_COUNT_2=$(pdftotext -raw -nopgbrk ${PDF_FILE} - | wc -w)
PDFTOTEX_COUNT_3=$(pdftotext -layout -nopgbrk ${PDF_FILE} - | wc -w)
(( PDFTOTEX_COUNT = (${PDFTOTEX_COUNT_1} +  ${PDFTOTEX_COUNT_2} + ${PDFTOTEX_COUNT_3}) / 3 ))
#DETEX_COUNT=$(detex "C:\Users\Stephi\Owncloud\thesis\swathesis-master\Platz_2013_Grouping_Micro_Changes.tex" | wc -w)
#(( WORD_COUNT_MEAN = (${PDFTOTEX_COUNT} + 2 * ${DETEX_COUNT}) / 3 ))

# detex words
# WORD_COUNT_MEAN=$(detex ${TEX_FILE} | wc -w)

PAGE_COUNT=$(pdfinfo ${PDF_FILE} | grep Pages | awk '{ printf "%s", $2 }')

#echo "{x: ${DATE}, y: ${WORD_COUNT_MEAN} }," >> ${WORDS}
echo "{x: ${DATE}, y: ${PDFTOTEX_COUNT} }," #>> ${WORDS}
echo "{x: ${DATE}, y: ${PAGE_COUNT} }," #>> ${PAGES}

# words
#echo "var words = [" > ${JSON}
#cat ${WORDS} >> ${JSON}
#echo "]" >> ${JSON}

# pages
#echo "var pages = [" >> ${JSON}
#cat ${PAGES} >> ${JSON}
#echo "]" >> ${JSON}

# thumbnails
# convert does not work for windows (comes from image magic)
# convert ${PDF_FILE} -alpha off -resize '60' ${PUBLIC}/images/thumbnail.png
#gswin64 -dNOPAUSE -sDEVICE=jpeg -dFirstPage=1 -dLastPage=237 -sOutputFile=images/thumbnail%d.jpg -dJPEGQ=100 -r100 -q ${PDF_FILE} -c quit
# echo "${TEX_FILE}"

