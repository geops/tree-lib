const { project } = require('../');

test('valid projection', () => {
  expect(
    project(
      {
        forestEcoregion: '1',
        additional: 'unknown',
        altitudinalZone: '6',
        forestType: '1h',
        slope: 'unknown',
        silverFirAreas: '0',
        relief: 'unknown',
      },
      '5',
    ).forestType,
  ).toBe('1');
});

test('valid multi altitudinalZone projection', () => {
  expect(
    project(
      {
        forestEcoregion: '1',
        additional: 'unknown',
        altitudinalZone: '10',
        forestType: '59L',
        slope: 'unknown',
        silverFirAreas: '0',
        relief: 'unknown',
      },
      '6',
    ).forestType,
  ).toBe('1');
});

test('invalid location values', () => {
  expect(() =>
    project({ forestType: '60*', forestEcoregion: 'fooBar' }, '5'),
  ).toThrowError('fooBar for forestEcoregion is not valid.');

  expect(() =>
    project(
      { forestType: '60*', forestEcoregion: '1', altitudinalZone: 'fooBar' },
      '6',
    ),
  ).toThrowError('fooBar for altitudinalZone is not valid.');

  expect(() =>
    project(
      {
        forestEcoregion: '1',
        altitudinalZone: '8',
        forestType: '55 collin',
      },
      '2',
    ),
  ).toThrowError('55 collin for forestType is not valid.');
});

test('invalid target altitudinalZone', () => {
  expect(() => project({}, 'fooBar')).toThrowError(
    'fooBar for targetaltitudinalZone is not valid.',
  );
});

test('missing projection for valid location and targetaltitudinalZone', () => {
  expect(() =>
    project(
      {
        forestEcoregion: '1',
        additional: 'unknown',
        altitudinalZone: '10',
        forestType: '58L',
        slope: 'unknown',
        silverFirAreas: '0',
        relief: 'unknown',
      },
      '8',
    ),
  ).toThrowError('Found no projection for selected targetaltitudinalZone.');
});
