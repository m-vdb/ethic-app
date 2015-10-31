require('coffee-script/register');
var gulp = require('gulp'),
    runSequence = require('gulp-run-sequence'),
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


gulp.task('build-tests-setup', function() {

  return gulp.src(['./test/setup.js'], {read: false})

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

gulp.task('build-tests', function() {

  return gulp.src(['./test/**/*.coffee'], {read: false})

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


gulp.task('run-tests', function (cb) {
  return gulp
    .src('test/runner.html')
    .pipe(mochaPhantomJS({reporter: 'spec'}))
    .once('end', function () {
      cb();
      process.exit();
    });
});


gulp.task('default', ['build']);
gulp.task('test', function (cb) {
  runSequence('build-tests-setup', 'build-tests', 'run-tests', cb)
});
