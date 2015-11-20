require('coffee-script/register');

var fs = require('fs'),
    gulp = require('gulp'),
    mochaPhantomJS = require('gulp-mocha-phantomjs'),
    rename = require('gulp-rename'),
    runSequence = require('gulp-run-sequence'),
    watch = require('gulp-watch'),
    browserify = require('browserify'),
    partialify = require('partialify'),
    coffeeify = require('coffeeify'),
    debowerify = require('debowerify'),
    glob = require('glob'),
    source = require('vinyl-source-stream'),
    pathExists = require('path-exists');

var ENV_FILE_TPL = '.env.tpl',
    ENV_FILE = '.env';

function buildConfig (cb) {
  require('dotenv').load();
  fs.writeFile('./config/build.json', JSON.stringify(require('config')), cb);
}

gulp.task('build-config', function(cb) {
  buildConfig(cb);
});

gulp.task('build-test-config', function(cb) {
  process.env.NODE_ENV = "test";
  buildConfig(cb);
});

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
    transform: [coffeeify, partialify, debowerify],
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


gulp.task('postinstall', function () {
  pathExists(ENV_FILE).then(function (exists) {
    if (exists) return;

    gulp.src(ENV_FILE_TPL)
      .pipe(rename(ENV_FILE))
      .pipe(gulp.dest('.'));
  });
});


gulp.task('default', function (cb) {
  runSequence('build-config', 'build', cb);
});
gulp.task('test', function (cb) {
  runSequence('build-test-config', 'build-tests-setup', 'build-tests', 'run-tests', cb)
});
