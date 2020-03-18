/* eslint-disable no-console */
/* eslint-disable import/no-extraneous-dependencies */
const path = require('path');
const fs = require('fs');
const union = require('lodash.union');

const types = require('../types.json');

console.log(`
  This script reads all geojson files in /data/nais/geojson/ and aggregate them
  into two files: /data/nais/ecograms.json & /data/nais/locations.json
`);

const abortScript = alert => {
  console.log(alert);
  process.exit(1);
};

function validate(type, list) {
  if (!list) {
    abortScript(`List for ${type} missing!`);
  }

  list.forEach(code => {
    if (!types[type].find(t => t.code === code)) {
      abortScript(`Code ${code} for ${type} not valid!`);
    }
  });
}

function writeJSON(filename, data) {
  const filepath = path.join(__dirname, '../', filename);
  fs.writeFileSync(filepath, JSON.stringify(data));
}

const aggregateEcograms = (dir, ecogramFiles) => {
  const ecograms = {};
  const locations = {};

  ecogramFiles.forEach(filename => {
    console.log(`  Start formating ${filename}`);
    const { name } = path.parse(filename);
    const filepath = path.resolve(dir, filename);
    const rawdata = fs.readFileSync(filepath);
    const ecogram = JSON.parse(rawdata);

    const { forestEcoregions, altitudinalZones } = ecogram.properties || {};

    validate('forestEcoregion', forestEcoregions);
    validate('altitudinalZone', altitudinalZones);

    forestEcoregions.forEach(region => {
      locations[region] = union(altitudinalZones, locations[region]);
    });

    const features = [];
    ecogram.features.forEach(f => {
      const forestTypes = f.properties.forestTypes.split(',') || [];
      const otherForestTypes = f.properties.forestTypes.split(',') || [];
      const [[x1, y1], , [x2, y2]] = f.geometry.coordinates[0][0];

      features.push({
        x: Math.round(x1 * 1000),
        y: Math.round(
          1000 - y1 * 1000 - (1000 - y1 * 1000 - (1000 - y2 * 1000)),
        ),
        w: Math.round(x2 * 1000 - x1 * 1000),
        h: Math.round(1000 - y1 * 1000 - (1000 - y2 * 1000)),
        r: parseInt(f.properties.r, 10),
        z: parseInt(f.properties.z, 10),
        f: [...new Set([...forestTypes, ...otherForestTypes])],
      });
    });

    ecograms[name] = features;
  });

  writeJSON('ecograms.json', ecograms);
  writeJSON('locations.json', locations);
};

const ecogramFiles = fs
  .readdirSync('data/nais/ecogram/')
  .filter(fileName => /.geojson/.test(fileName));
aggregateEcograms('data/nais/ecogram/', ecogramFiles);
