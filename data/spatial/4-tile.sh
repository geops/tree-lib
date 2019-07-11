mkdir -p /data/spatial/tiles/altitudinal_zones_1995
tippecanoe --no-feature-limit --no-tile-size-limit --include=key --minimum-zoom=0 --maximum-zoom=g -s EPSG:3857 --force --output-to-directory '/data/spatial/tiles/altitudinal_zones_1995' /data/spatial/export/altitudinal_zones_1995.geojson