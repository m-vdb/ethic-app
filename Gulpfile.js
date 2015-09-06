var gulp = require('gulp'),
    watch = require('gulp-watch'),
    rename = require("gulp-rename"),
    browserify = require('gulp-browserify'),
    partialify = require('partialify'),
    debowerify = require('debowerify');


gulp.task('build', function() {

  gulp.src(['./ethic/app.module.js'], {read: false})

    // Browserify, and add source maps if this isn't a production build
    .pipe(browserify({
      debug: true,
      transform: [debowerify, partialify],
      extensions: ['.js']
    }))

    // Output to the build directory
    .pipe(rename('main.js'))
    .pipe(gulp.dest('./build/'));
});


gulp.task('watch', function () {
  gulp.start('build');
  watch('ethic/**/*.js', function () {
    gulp.start('build');
  });
});