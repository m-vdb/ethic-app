require('coffee-script/register');
var gulp = require('gulp'),
    runSequence = require('gulp-run-sequence'),
    mochaPhantomJS = require('gulp-mocha-phantomjs'),
    watch = require('gulp-watch'),
    browserify = require('browserify'),
    partialify = require('partialify'),
    coffeeify = require('coffeeify'),
    debowerify = require('debowerify'),
    glob = require('glob'),
    source = require('vinyl-source-stream');


gulp.task('build', function() {

  browserify({
    entries: ['./ethic/ethic.app.coffee'],
    debug: true,
    transform: [coffeeify, partialify, debowerify],
    extensions: ['.js', '.coffee', '.html']
  })
    .on('error', function(err){
      console.log(err.message);
      this.end();
    })
    .bundle()

    // Output to the build directory
    .pipe(source('main.js'))
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

  return browserify({
    entries: ['./test/setup.js'],
    debug: true,
    transform: [coffeeify, debowerify],
    extensions: ['.js', '.coffee']
  })
    .on('error', function(err){
      console.log(err.message);
      this.end();
    })
    .bundle()

    // Output to the build directory
    .pipe(source('tests-setup.js'))
    .pipe(gulp.dest('./build/'));
});

gulp.task('build-tests', function() {

  return browserify({
    entries: glob.sync('./test/**/*.coffee'),
    debug: true,
    transform: [coffeeify, partialify, debowerify],
    extensions: ['.js', '.coffee', '.html']
  })
    .on('error', function(err){
      console.log(err.message);
      this.end();
    })
    .bundle()

    // Output to the build directory
    .pipe(source('tests.js'))
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
