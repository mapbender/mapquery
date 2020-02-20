#!/bin/sh
rm -rf ol2-dist
mkdir ol2-dist
( curl --location 'https://github.com/openlayers/ol2/releases/download/release-2.13.1/OpenLayers-2.13.1.tar.gz' | \
  tar xz --strip 1 -C ol2-dist ) \
&& ( cat openlayers2.debug.patch | patch -o - ol2-dist/OpenLayers.debug.js > openlayers/OpenLayers.debug.js ) \
&& ( cp -ax \
  ol2-dist/art ol2-dist/img ol2-dist/theme \
  ol2-dist/authors.txt ol2-dist/license.txt \
  ol2-dist/readme.md \
  openlayers/ ) \
&& ( cat ol2-dist/build/license.txt patch-info.js > OpenLayers.debug.min.js.build ) \
&& ( uglifyjs openlayers/OpenLayers.debug.js -c -m \
   -p 1 --source-map=openlayers/OpenLayers.js.map --source-map-url=OpenLayers.js.map \
   >> OpenLayers.debug.min.js.build ) \
&& ( mv OpenLayers.debug.min.js.build openlayers/OpenLayers.js )

rm -rf ol2-dist
