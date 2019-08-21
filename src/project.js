import projections from '../data/projections.json';
import types from '../data/types.json';

const fields = [
  'forestType',
  'forestEcoregion',
  'altitudinalZone',
  'slope',
  'additional',
  'silverFirArea',
  'relief',
];

const altitudeList = types.altitudinalZone
  .map(az => az.code)
  .sort((a, b) => a - b)
  .reverse();

const getField = (field, location) => ({
  field,
  value: location[field],
  values: types[field],
});

const validate = (field, value, values) => {
  if (value && values && values.find(v => v.code === value) === undefined) {
    throw new Error(`${value} for ${field} is not valid.`);
  }
};
const valueNotInOptions = (value, fieldOptions) =>
  value && fieldOptions && fieldOptions.find(v => v === value) === undefined;

/* Provides the list of altitudinal Zones as target Altitudinal zones that are immediately 
after the currently chosen altitudinal Zone. */
const nextAltitudinalZone = current =>
  altitudeList[altitudeList.indexOf(current) + 1];

function projectionReducer(location, targetAltitude) {
  const newLocation = { ...location };
  const options = location.options || {};

  let projection = projections;
  for (let i = 0; i < fields.length; i += 1) {
    const { field, value, values } = getField(fields[i], location);
    validate(field, value, values);

    options[field] = Array.from(
      new Set((options[field] || []).concat(Object.keys(projection))),
    ).sort((a, b) => a - b);

    if (value && projection[value]) {
      projection = projection[value];
    } else if (projection.unknown && Object.keys(projection).length === 1) {
      // Handle optional fields.
      projection = projection.unknown;
      newLocation[field] = 'unknown';
    } else if (valueNotInOptions(value, options[field])) {
      // Do not return location values if no projection was found.
      return { options };
    } else {
      // Location does not provide any more values for conditions.
      break;
    }
  }

  if (targetAltitude !== location.altitudinalZone) {
    if (typeof projection === 'string') {
      newLocation.forestType = projection;
    }
    newLocation.altitudinalZone = nextAltitudinalZone(location.altitudinalZone);
  }

  newLocation.options = options;
  return newLocation;
}

/** This function returns the projected forest type for the given forest type
 * @param {Object} location Input for project function
 * @param {string} location.forestType Forest type for which the projection is to be made
 * @param {string} location.forestEcoregion Forest Ecoregion of the chosen forest type
 * @param {number} location.altitudinalZone Altitudinal Zone of the chosen forest type
 * @param {number} targetAltitude Numeric code of height level based on map.geo.admin.ch
 * @return {Object} newLocation
 */

/** Returned object of project function
 * @typedef {Object} newLocation
 * @property {string} additional additional condition used for the projection. Default value is 'unknown'.
 * @property {string} altitudinalZone altitudinal zone of the projected forest type.
 * @property {string} forestEcoregion same forest ecoregion used as the input.
 * @property {string} forestType projected forest type.
 * @property {string} relief relief condition used for the projection. Default value is 'unknown'.
 * @property {string} silverFirArea silverFirArea condition used for the projection.
 * @property {string} slope slope condition used for the projection. Default value is 'unknown'.
 * @property {object} options
 * @property {Array} options.additional list of additional conditions available for chosen forest type.
 * @property {Array} options.altitudinalZone list of chosen altitudinal zone.
 * @property {Array} options.forestEcoregion list of forest ecoregions available for chosen forest type.
 * @property {Array} options.forestType list of forest type available for projection.
 * @property {Array} options.relief list of relief conditions available for chosen forest type.
 * @property {Array} options.silverFirArea list of silverFirArea condition for chosen forest type.
 * @property {Array} options.slope list of slope condtion for chosen forest type.
 * @property {Array} options.targetAltitudinalZone list of altitudinal zones available for chosen forest type.
 */

function project(location = {}, targetAltitude) {
  const altitudePointer = altitudeList.indexOf(location.altitudinalZone);
  const altitudinalZone = targetAltitude || location.altitudinalZone;

  validate('targetAltitudinalZone', targetAltitude, types.altitudinalZone);

  let newLocation = projectionReducer(location, altitudinalZone);
  if (targetAltitude && newLocation.altitudinalZone !== targetAltitude) {
    newLocation = project(newLocation, targetAltitude);
  }

  if (newLocation && altitudePointer !== -1) {
    newLocation.options.targetAltitudinalZone = [
      location.altitudinalZone,
      ...altitudeList.slice(altitudePointer + 1),
    ];
  }

  // Replace alphanumeric sorting with custom sorting based on database export
  newLocation.options.forestType = types.forestType
    .filter(ft => newLocation.options.forestType.includes(ft.code))
    .map(ft => ft.code);

  return newLocation;
}

export default project;
