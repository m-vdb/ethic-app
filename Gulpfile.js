require('coffee-script/register');
var gulp = require('gulp'),
    mochaPhantomJS = require('gulp-mocha-phantomjs'),
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


gulp.task('build-test-setup', function() {

  gulp.src(['./test/setup.js'], {read: false})

    // Browserify, and add source maps if this isn't a production build
    .pipe(browserify({
      debug: true,
      transform: [coffeeify, debowerify],
      extensions: ['.js', '.coffee']
    }).on('error', function(err){
      console.log(err.message);
      this.end();
    }))

    // Output to the build directory
    .pipe(rename('tests-setup.js'))
    .pipe(gulp.dest('./build/'));
});

gulp.task('build-test', ['build-test-setup'], function() {

  gulp.src(['./test/**/*.coffee'], {read: false})

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
    .pipe(rename('tests.js'))
    .pipe(gulp.dest('./build/'));
});


gulp.task('test', ['build-test'], function () {
  return gulp
    .src('test/runner.html')
    .pipe(mochaPhantomJS({reporter: 'spec'}))
    .once('end', function () {
      process.exit();
    });
});


gulp.task('default', ['build']);
