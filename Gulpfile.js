var browserify = require('gulp-browserify');
var gulp = require('gulp');
var rename = require("gulp-rename");
var partialify = require('partialify');
var debowerify = require('debowerify');


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
