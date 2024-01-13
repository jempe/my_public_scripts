#!/bin/bash

# This script processes the subtitles of a YouTube video and outputs a text file
# with the subtitles in a format that is easier to read and understand.
#

SEDBINARY=sed

#use gsed instead of sed on Mac OS X
if [[ "$OSTYPE" == "darwin"* ]]; then
    SEDBINARY=gsed
fi

grep "utf8" $1 | $SEDBINARY 's/^\s\+\"utf8\":\s*"//' | $SEDBINARY ':a;N;$!ba;s/",\n//g' | $SEDBINARY 's/\",$//g' | $SEDBINARY 's/\\n"$//' | $SEDBINARY 's/\[Music\]"//'

