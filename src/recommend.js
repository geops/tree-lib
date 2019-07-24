import recommendations from '../data/recommendations.json';
import types from '../data/types.json';

function recommendTreeSpecies(forestType) {
  if (types.forestType.find(v => v.code === forestType) === undefined) {
    throw new Error(`${forestType} is not a valid forest type`);
  }
  const [, treeSpecies] = Object.entries(recommendations).find(
    t => t[0] === forestType,
  );
  return treeSpecies;
}

function concatTreeSpecies(...treeSp) {
  return Array.from(new Set(treeSp[0].reduce((a, b) => a.concat(b), [])));
}

function filterTreeSpecies(...treeSp) {
  const forestType1Concated = concatTreeSpecies(treeSp[0]);
  const forestType2Concated = concatTreeSpecies(treeSp[1]);
  return forestType1Concated.filter(
    tree => !forestType2Concated.includes(tree),
  );
}

function recommend(forestType1, forestType2, future) {
  if (!forestType1) {
    throw new Error(
      `at least one forest type is required to get the recommendation of tree species`,
    );
  }

  if (future && typeof future !== 'boolean') {
    throw new Error(`expected boolean type for future flag`);
  }

  let result = recommendTreeSpecies(forestType1);

  const { one, two, three } = result;
  if (forestType2) {
    const { one: one2, two: two2, three: three2 } = recommendTreeSpecies(
      forestType2,
    );
    if (future) {
      result = {
        positive: filterTreeSpecies(one, one2),
        neutral: filterTreeSpecies(two, two2),
        negative: filterTreeSpecies(three, three2),
      };
    } else {
      result = {
        positive: concatTreeSpecies([one, one2, two, two2]),
        neutral: concatTreeSpecies([three, three2]),
        negative: filterTreeSpecies([one, two, three], [one2, two2, three2]),
      };
    }
  }

  return result;
}

export default recommend;
