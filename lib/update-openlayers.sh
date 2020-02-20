#!/bin/sh
rm -rf ol2-dist
mkdir ol2-dist
( curl --location 'https://github.com/openlayers/ol2/releases/download/release-2.13.1/OpenLayers-2.13.1.tar.gz' | \
  tar xz --strip 1 -C ol2-dist ) \
&& ( cp -ax \
  ol2-dist/OpenLayers.debug.js \
  ol2-dist/art ol2-dist/img ol2-dist/theme \
  ol2-dist/authors.txt ol2-dist/license.txt \
  ol2-dist/readme.md \
  openlayers/ ) \
&& ( cat ol2-dist/build/license.txt > OpenLayers.debug.min.js.build ) \
&& ( ( cat openlayers2.debug.patch | patch -o - ol2-dist/OpenLayers.debug.js | uglifyjs -c -m ) >> OpenLayers.debug.min.js.build ) \
&& ( mv OpenLayers.debug.min.js.build openlayers/OpenLayers.js )

rm -rf ol2-dist
