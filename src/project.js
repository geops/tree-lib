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
    values: types.altitudinalZone,
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
    values: types.silverFirArea,
  },
  {
    field: 'relief',
    values: types.relief,
  },
];

const altitudinalZoneList = types.altitudinalZone
  .map(az => az.code)
  .sort((a, b) => a - b)
  .reverse();

/* Provides the list of altitudinal Zones as target Altitudinal zones that are immediately 
after the currently chosen altitudinal Zone. */
const nextAltitudinalZone = current =>
  altitudinalZoneList[altitudinalZoneList.indexOf(current) + 1];

function projectionReducer(location, targetAltitudinalZone) {
  const newLocation = { ...location, options: location.options || {} };

  let forestType = projections;
  for (let i = 0; i < conditions.length; i += 1) {
    const { field, values } = conditions[i];
    const value = location[field];

    // Validation
    if (value && values && values.find(v => v.code === value) === undefined) {
      throw new Error(`${value} for ${field} is not valid.`);
    }

    newLocation.options[field] = newLocation.options[field]
      ? Array.from(
          new Set(newLocation.options[field].concat(Object.keys(forestType))),
        ).sort((a, b) => a - b)
      : Object.keys(forestType);

    if (value && forestType[value]) {
      forestType = forestType[value];
    } else if (forestType.unknown && Object.keys(forestType).length === 1) {
      forestType = forestType.unknown;
      newLocation[field] = 'unknown';
    } else {
      // Location does not provide any more values for conditions.
      break;
    }
  }

  if (typeof forestType === 'string') {
    newLocation.forestType =
      targetAltitudinalZone === undefined ||
      location.altitudinalZone === targetAltitudinalZone
        ? newLocation.forestType
        : forestType;
  }

  if (targetAltitudinalZone !== location.altitudinalZone) {
    newLocation.altitudinalZone = nextAltitudinalZone(location.altitudinalZone);
  }

  return newLocation;
}

function project(location = {}, targetAltitudinalZone) {
  const altitudinalZonePointer = altitudinalZoneList.indexOf(
    location.altitudinalZone,
  );

  if (
    targetAltitudinalZone &&
    types.altitudinalZone.find(v => v.code === targetAltitudinalZone) ===
      undefined
  ) {
    throw new Error(
      `${targetAltitudinalZone} for target altitudinal zone is not valid.`,
    );
  }

  let newLocation;

  if (
    altitudinalZoneList[altitudinalZonePointer] !== targetAltitudinalZone ||
    targetAltitudinalZone === undefined ||
    altitudinalZoneList[altitudinalZonePointer] === targetAltitudinalZone
  ) {
    newLocation = projectionReducer(location, targetAltitudinalZone);
    if (
      newLocation.altitudinalZone !== undefined &&
      targetAltitudinalZone !== undefined &&
      newLocation.altitudinalZone !== targetAltitudinalZone
    ) {
      newLocation = project(newLocation, targetAltitudinalZone);
    }
  }

  if (newLocation && altitudinalZonePointer !== -1) {
    newLocation.options.targetAltitudinalZone = altitudinalZoneList.slice(
      altitudinalZonePointer + 1,
    );
  }

  // Replace alphanumeric sorting with custom sorting based on database export
  newLocation.options.forestType = types.forestType
    .filter(ft => newLocation.options.forestType.includes(ft.code))
    .map(ft => ft.code);

  newLocation.options.targetAltitudinalZone = [
    location.altitudinalZone,
    ...newLocation.options.targetAltitudinalZone,
  ];

  return newLocation;
}

export default project;
