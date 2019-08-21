import types from '../data/types.json';

const validLanguages = ['de'];

/** This function translates the code of the valid type from types.json into label.
 * @param {string} type Any type from types.json. It should have a corresponding code available. Eg: treeType, forestType.
 * @param {number} code Code of the chosen type.
 * @param {string} [language=de] The language in which code is to be translated. Label should be available in types.json file.
 * @return {string} translated label for the given type.
 */

function translate(type, code, language) {
  if (!validLanguages.includes(language)) {
    throw new Error(`${language} is not supported.`);
  }

  if (!types[type]) {
    throw new Error(`${type} is not a valid type.`);
  }

  const translation = types[type].find(t => t.code === code);

  if (!translation) {
    throw new Error(`Translation for ${type}.${code} not found.`);
  }

  return translation[language];
}

export default translate;
