import recommendations from '../data/recommendations.json';
import types from '../data/types.json';

function recommendTreeSpecies(forestType) {
  const [, treeSpecies] = Object.entries(recommendations).find(
    t => t[0] === forestType,
  );
  return treeSpecies;
}

function concatTreeSpecies(treeSp1, treeSp2) {
  return Array.from(new Set([...treeSp1, ...treeSp2]));
}

function validateForestType(forestType) {
  if (types.forestType.find(v => v.code === forestType) === undefined) {
    throw new Error(`${forestType} is not a valid forest Type`);
  }
}

function recommend(forestType1, forestType2) {
  let result;
  if (!forestType1) {
    throw new Error(
      `at least one forest type is required to get the recommendation of tree species`,
    );
  }

  if (forestType1) {
    validateForestType(forestType1);
    result = recommendTreeSpecies(forestType1);
  }

  if (forestType1 && forestType2) {
    validateForestType(forestType2);
    const { one, two, three } = result;
    const { one: one2, two: two2, three: three2 } = recommendTreeSpecies(
      forestType2,
    );
    result = {
      one: concatTreeSpecies(one, one2),
      two: concatTreeSpecies(two, two2),
      three: concatTreeSpecies(three, three2),
    };
  }

  return result;
}

export default recommend;
