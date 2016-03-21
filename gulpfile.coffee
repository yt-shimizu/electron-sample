gulp = require 'gulp'
coffee = require 'gulp-coffee'
concat = require 'gulp-concat'
uglify = require 'gulp-uglify'
plumber = require 'gulp-plumber'

gulp.task 'html', ->
  gulp.src('./src/*.html')
    .pipe(gulp.dest('./dist'))

gulp.task 'js', ->
  gulp.src('./src/coffee/**/*.coffee')
    .pipe(plumber())
    .pipe(coffee())
    .pipe(concat('app.js'))
    .pipe(uglify())
    .pipe(gulp.dest('./dist'))

gulp.task 'main', ->
  gulp.src 'src/main.coffee'
    .pipe(plumber())
    .pipe(coffee())
    .pipe(gulp.dest('./dist'))

gulp.task 'watch', ->
  gulp.watch('./src/*.html', ['html'])
  gulp.watch('./src/main.coffee', ['main'])
  gulp.watch('./src/coffee/**/*.coffee', ['js'])

gulp.task 'default', ['html', 'main', 'js', 'watch']
