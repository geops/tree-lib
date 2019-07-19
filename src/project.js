import projections from '../data/projections.json';
import types from '../data/types.json';

const conditions = [
  {
    field: 'forestType',
    values: types.forestType,
  },
  {
    field: 'forestEcoregion',
    values: types.forestEcoregion,
  },
  {
    field: 'altitudinalZone',
    values: types.altitudinalZones,
  },
  {
    field: 'slope',
    values: types.slope,
  },
  {
    field: 'additional',
    values: types.additional,
  },
  {
    field: 'silverFirArea',
    values: types.silverFirAreas,
  },
  {
    field: 'relief',
    values: types.relief,
  },
];

const altitudinalZoneList = types.altitudinalZones
  .filter(e => e.id !== 1 && e.id !== 2 && e.id !== 4 && e.id !== 8)
  .map(e => e.code)
  .reverse();

const getNextHeigtLevel = currentaltitudinalZone =>
  altitudinalZoneList[altitudinalZoneList.indexOf(currentaltitudinalZone) + 1];

function projectionReducer(location) {
  const options = {};
  let forestType = projections;
  for (let i = 0; i < conditions.length; i += 1) {
    const { field, values } = conditions[i];
    const value = location[field];

    // Validation
    if (value && values && values.find(v => v.code === value) === undefined) {
      throw new Error(`${value} for ${field} is not valid.`);
    }

    options[field] = Object.keys(forestType);

    if (value && forestType[value]) {
      forestType = forestType[value];
    } else {
      // Location does not provide any more values for conditions.
      break;
    }
  }

  if (typeof forestType !== 'string') {
    throw new Error(
      'Found no projection for selected target altitudinal zone.',
    );
  }

  const altitudinalZone = getNextHeigtLevel(location.altitudinalZone);
  return { ...location, options, forestType, altitudinalZone };
}

function project(location, targetaltitudinalZone) {
  const additional = location.additional || 'unknown';
  const slope = location.slope || 'unknown';
  const relief = location.relief || 'unknown';
  const locationParam = { ...location, additional, slope, relief };
  if (
    types.altitudinalZones.find(v => v.code === targetaltitudinalZone) ===
    undefined
  ) {
    throw new Error(
      `${targetaltitudinalZone} for target altitudinal zone is not valid.`,
    );
  }

  const altitudinalZonePointer = altitudinalZoneList.indexOf(
    location.altitudinalZone,
  );

  let newLocation;
  if (altitudinalZoneList[altitudinalZonePointer] !== targetaltitudinalZone) {
    newLocation = projectionReducer(locationParam);
    if (newLocation.altitudinalZone !== targetaltitudinalZone) {
      newLocation = project(newLocation, targetaltitudinalZone);
    }
  }
  return newLocation;
}

export default project;
