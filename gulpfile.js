var gulp = require('gulp');
var rollup = require('gulp-better-rollup');
var sucrase = require('@sucrase/gulp-plugin');
var minify = require('gulp-minify');

var resolve = require('rollup-plugin-node-resolve');
var commonjs = require('rollup-plugin-commonjs');
var rootImport = require('rollup-plugin-root-import');
var globals = require('rollup-plugin-node-globals');


var urbitrc = require('./.urbitrc');


gulp.task('urbit-copy', function () {
  let ret = gulp.src('./src/**/*');

  urbitrc.URBIT_PIERS.forEach(function(pier) {
    ret = ret.pipe(gulp.dest(pier));
  });

  return ret;
});

gulp.task('watch', gulp.series('urbit-copy', function() {
  gulp.watch('./src/**/*', gulp.parallel('urbit-copy'));
}));
