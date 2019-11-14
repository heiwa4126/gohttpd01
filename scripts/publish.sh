#!/bin/sh
set -ue
scripts/build.sh

# tarfile=publish/gohttpd01-`date +%F-%H-%M-%S`.tar.gz
tarfile=publish/gohttpd01.tar.gz

rm -rf publish
mkdir -p publish
cd ..
tar zcf "gohttpd01/$tarfile" \
  gohttpd01/gohttpd01 \
  gohttpd01/scripts \
  gohttpd01/README.md

echo "----"
echo "$tarfile"
