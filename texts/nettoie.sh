#! /bin/bash

iconv -f utf-8 -t ascii//TRANSLIT $1 | tr 'a-z' 'A-Z' | tr -s ' \n' | tr -d -c 'A-Z \n' > $2
