#!/bin/bash -e

hub="hisplan"
image_name="bedtools-tabix"
version="0.0.1"

echo "Packaging ${hub}/${image_name}:${version}..."

#
# tag it and push it to docker hub
#

docker login
docker tag ${image_name}:${version} ${hub}/${image_name}:${version}
docker push ${hub}/${image_name}:${version}
