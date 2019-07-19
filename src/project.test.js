const { project } = require('../');
/* Test for input section */
test('valid projection', () => {
  expect(
    project(
      {
        forestEcoregion: '1',
        altitudinalZone: '6',
        forestType: '1h',
        silverFirArea: '0',
      },
      '5',
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
    'fooBar for target altitudinal zone is not valid.',
  );
});

/* Test for output section */

test('check for unknown as only available option', () => {
  expect(
    project(
      {
        forestEcoregion: '1',
        altitudinalZone: '6',
        forestType: '1h',
        silverFirArea: '0',
      },
      '5',
    ).additional,
  ).toBe('unknown');
});

test('check optional field with multiple values', () => {
  expect(
    project(
      {
        forestEcoregion: '1',
        altitudinalZone: '9',
        forestType: '60*',
        silverFirArea: '0',
      },
      '8',
    ).slope,
  ).toBe(undefined);
});

test('empty target for incomplete location values', () => {
  expect(
    project(
      {
        forestEcoregion: '1',
        forestType: '60*',
      },
      '8',
    ).target,
  ).toBe(undefined);
});

test('option field with values for complete location values', () => {
  expect(
    project(
      {
        forestEcoregion: '1',
        altitudinalZone: '9',
        forestType: '60*',
        silverFirArea: '0',
      },
      '8',
    ).options.slope,
  ).toMatchObject(['<70', '>70']);
});

test('empty option field for incomplete location values', () => {
  expect(
    project(
      {
        forestEcoregion: '1',
        altitudinalZone: '9',
        forestType: '60*',
        silverFirArea: '0',
      },
      '8',
    ).options.relief,
  ).toBe(undefined);
});

test('valid multi altitudinal zone projection', () => {
  expect(
    project(
      {
        forestEcoregion: '1',
        altitudinalZone: '10',
        forestType: '59L',
        silverFirArea: '0',
      },
      '6',
    ).forestType,
  ).toBe('1');
});
