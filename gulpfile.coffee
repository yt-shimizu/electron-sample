gulp = require 'gulp'
coffee = require 'gulp-coffee'
concat = require 'gulp-concat'
uglify = require 'gulp-uglify'
stylus = require 'gulp-stylus'
plumber = require 'gulp-plumber'
glob = require 'glob'
source = require 'vinyl-source-stream'
browserify = require 'browserify'

gulp.task 'html', ->
  gulp.src('./src/*.html')
    .pipe(gulp.dest('./dist'))

gulp.task 'js', ->
  files = glob.sync('./src/coffee/**/*.coffee')
  browserify
    entries: files
    extentions: ['.coffee']
  .bundle()
  .on 'error', (err) ->
    console.log err.toString()
  .pipe(source('app.js'))
  .pipe(gulp.dest('./dist'))

gulp.task 'main', ->
  gulp.src 'src/main.coffee'
    .pipe(plumber())
    .pipe(coffee())
    .pipe(gulp.dest('./dist'))

gulp.task 'css', ->
  gulp.src('./src/stylus/**/*.styl')
    .pipe(plumber())
    .pipe(stylus())
    .pipe(concat('app.css'))
    .pipe(gulp.dest('./dist'))

gulp.task 'watch', ->
  gulp.watch('./src/*.html', ['html'])
  gulp.watch('./src/main.coffee', ['main'])
  gulp.watch('./src/coffee/**/*.coffee', ['js'])
  gulp.watch('./src/stylus/**/*.styl', ['css'])

gulp.task 'default', ['html', 'main', 'js', 'css', 'watch']
