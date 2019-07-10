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
    field: 'heightLevel',
    values: types.heightLevel,
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
    field: 'tannenareal',
    values: types.tannenareal,
  },
  {
    field: 'relief',
    values: types.relief,
  },
];
let iter = 0;
function project(location) {
  const options = {};
  let target = projections;
  for (let i = 0; i < conditions.length; i += 1) {
    const { field, values } = conditions[i];
    const value = location[field];

    // Validation
    if (value && values && values.find(v => v.key === value) === undefined) {
      throw new Error(`${value} for ${field} is not valid.`);
    }

    options[field] = Object.keys(target);

    if (value && target[value]) {
      target = target[value];
    } else {
      // Location does not provide any more values for conditions.
      break;
    }
  }
  const newLocation = { ...location, options };
  if (typeof target === 'string') {
    newLocation.target = target;
  }
  const height = ['OSA', 'SA', 'HM', 'OM', 'UM', 'SM'];
  iter += 1;

  if (height[iter] !== 'UM') {
    console.log('final target ', newLocation.target);
    return project({
      ...location,
      forestType: newLocation.target,
      heightLevel: height[iter],
    });
  }

  return newLocation;
}

export default project;
