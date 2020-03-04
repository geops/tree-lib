/* eslint-disable import/no-extraneous-dependencies */
const path = require('path');
const fs = require('fs');

console.log(`
  First you should ensure that all geojson files to convert are located in a
  temporary folder called 'temp', on project's root.
`);

const abortScript = alert => {
  console.log(alert);
  process.exit(1);
};

const readGeojsonFiles = (dir, processGeojson) => {
  fs.readdir(dir, (error, fileNames) => {
    if (error) throw error;

    fileNames.forEach(filename => {
      const name = path.parse(filename).name;
      const ext = path.parse(filename).ext;
      const filepath = path.resolve(dir, filename);

      fs.stat(filepath, function(error, stat) {
        if (error) throw error;
        const isFile = stat.isFile();

        if (isFile && ext === '.geojson') {
          // callback to format to json.
          processGeojson(name, ext, filepath);
        }
      });
    });
  });
}

const getCoords = (coordinates, index) => {
  const filteredCoords = coordinates.map(c => c[index].toFixed(3));
  return filteredCoords.filter((c, idx) => filteredCoords.indexOf(c) !== idx);
};

const formatToJson = (name, ext, filepath) => {
  console.log(`  Start formating ${name}${ext}`);
  let rawdata = fs.readFileSync(filepath);
  let geojson = JSON.parse(rawdata);

  const { forestEcoR, altZones } = geojson.features[0].properties;

  if (!forestEcoR) {
    abortScript(`
    /!\\\ 'forestEcoR' property not present or badly formated
    in at least the first feature, to be converted to 'forestEcoregions' !
    `);
  }
  const forestEcoregions = forestEcoR.split(',');

  if (!altZones) {
    abortScript(`
    /!\\\ 'altZones' property not present or badly formated
    in at least the first feature, to be converted to 'altitudinalZones' !
    `);
  }
  const altitudinalZones = altZones.split(',');

  let main = [];
  geojson.features.forEach(f => {
    const { z, forTypes, otforTypes } = f.properties;
    const { coordinates } = f.geometry;
    const [coords] = coordinates[0];
    // Remove last coord, which is the same as the first one.
    coords.splice(coords.length - 1, coords.length)

    main.push({
      x: getCoords(coords, 0),
      y: getCoords(coords, 1),
      z,
      forestTypes: forTypes ? forTypes.split(',') : [],
      otherForestTypes: otforTypes ? otforTypes.split(',') : [],
    });
  });

  const newJson = {
    forestEcoregions,
    altitudinalZones,
    main,
  };

  const outputDirectory = path.join(__dirname, `../temp/outputs/`)
  // If no outputs folder, create it.
  if (!fs.existsSync(outputDirectory)) {
    fs.mkdirSync(outputDirectory);
  }
  fs.writeFileSync(
    `${outputDirectory}${name}.json`,
    JSON.stringify(newJson, null, 2),
  );

  console.log(`
  Converting ${name}${ext} to temp/outputs/${name}.json runnned successfuly!
  `);
};

readGeojsonFiles('temp/', formatToJson);
