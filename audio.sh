#! /bin/bash

echo "Go To https://fulllengthaudiobooks.com/ and search for your audiobook"
read x
cd ~
IFS='/'
read -a starr <<< "$x"
mkdir "${starr[3]}"
cd "${starr[3]}"
wget -r -l1 -H -nd -A mp3 -e robots=off --reject=tmp $x
touch output.txt
ls >> output.txt
ffmpeg -f concat -safe 0 -i <( for f in *.mp3; do echo "file '$(pwd)/$f'"; done ) "${starr[3]}".mp3
while IFS= read -r line
do
  rm $line
done < output.txt

