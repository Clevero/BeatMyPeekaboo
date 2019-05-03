#!/bin/bash


TYPE=$1
RECIPIENT="testuser@domain.tld"

RND_NAME=$(pwgen 6 1);
echo $(pwgen 1024 1) > $RND_NAME.txt
pandoc $RND_NAME.txt -o $RND_NAME.$TYPE

if [ $TYPE = "doxc" ]; then
        SAMPLE_MIME_TYPE="application/vnd.openxmlformats-officedocument.wordprocessingml.document"
elif [ "pdf" ]; then
        SAMPLE_MIME_TYPE="application/pdf"
else
        echo "no known format"
        exit 1;
fi

swaks --to $RECIPIENT --tls --attach-type $SAMPLE_MIME_TYPE --attach $RND_NAME.$TYPE --suppress-data
rm $RND_NAME.$TYPE
rm $RND_NAME.txt
