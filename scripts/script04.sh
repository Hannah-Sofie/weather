#!/bin/bash

path="/opt/weather/PROJECT/"

now=$(date -R -u | sed s/\\s+[0-9+-]*$//g)

lastModification=$(date --reference=${path}../scripts/data-collected.txt -R -u | sed s/\\s+[0-9+-]*$//g)

size=$(stat --format=%s cities/2022-11-30-1400/Bergen.html)

echo "HTTP/1.1 200 OK
Date: $now GMT
Server: Apache/2.4.54 (Debian)
Last-Modified: $lastModification GMT
ETag: \"157-5ee7e5251ab45\"
Accept-Ranges: bytes
Content-Length: $size
Vary: Accept-Encoding
Content-Type: text/html

"
cat index.html