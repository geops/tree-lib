/* eslint-disable import/no-extraneous-dependencies */

const documentation = require('documentation');
const streamArray = require('stream-array');
const vfs = require('vinyl-fs');

const docConfig = require('../doc/doc-config.json');

documentation
  .build([`src/**`], { shallow: false })
  .then(out =>
    documentation.formats.html(out, {
      'project-name': docConfig.appName,
      'project-url': docConfig.githubRepo,
      theme: 'node_modules/geops-docjs-template',
    }),
  )
  .then(output => {
    streamArray(output).pipe(vfs.dest(`./docjs`));
  });
