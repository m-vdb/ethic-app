var gulp = require('gulp'),
    watch = require('gulp-watch'),
    rename = require("gulp-rename"),
    browserify = require('gulp-browserify'),
    partialify = require('partialify'),
    coffeeify = require('coffeeify'),
    debowerify = require('debowerify');


gulp.task('build', function() {

  gulp.src(['./ethic/ethic.app.coffee'], {read: false})

    // Browserify, and add source maps if this isn't a production build
    .pipe(browserify({
      debug: true,
      transform: [coffeeify, partialify, debowerify],
      extensions: ['.js', '.coffee', '.html']
    }).on('error', function(err){
      console.log(err.message);
      this.end();
    }))

    // Output to the build directory
    .pipe(rename('main.js'))
    .pipe(gulp.dest('./build/'));
});


gulp.task('watch', function () {
  gulp.start('build');
  watch('ethic/**/*.coffee', function () {
    gulp.start('build');
  });
  watch('ethic/**/*.html', function () {
    gulp.start('build');
  });
});


gulp.task('default', ['build']);
