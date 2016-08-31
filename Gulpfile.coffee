gulp = require 'gulp'
coffee = require 'gulp-coffee'
gutil = require 'gulp-util'
bower = require 'bower'
merge = require 'streamqueue'
rename = require 'gulp-rename'
browserify = require 'browserify'
streamify = require 'gulp-streamify'
uglify = require 'gulp-uglify'
source = require 'vinyl-source-stream'
rework = require 'gulp-rework'
reworkNPM = require 'rework-npm'
cleanCSS = require 'gulp-clean-css'
del = require 'del'

gulp.task 'default', ['coffee', 'test']

gulp.task 'coffee', ->
  gulp.src './index.coffee'
    .pipe coffee bare: true
    .on 'error', gutil.log
    .pipe gulp.dest './'

gulp.task 'test', ['coffee'], ->
  gulp.src 'index.css'
    .pipe rework reworkNPM shim: 'angular-toastr': 'dist/angular-toastr.css'
    .pipe gulp.dest './test'
    .pipe cleanCSS()
    .pipe rename extname: '.min.css'
    .pipe gulp.dest './test'

  browserify entries: ['./test/index.coffee']
    .transform('coffeeify')
    .transform('debowerify')
    .bundle()
    .pipe source 'index.js'
    .pipe gulp.dest './test/'
    .pipe streamify uglify()
    .pipe rename extname: '.min.js'
    .pipe gulp.dest './test/'

gulp.task 'clean', ->
  del [
    'index.js'
    'test/index.js'
    'test/index.min.js'
    'test/index.css'
    'test/index.min.css'
    'node_modules'
  ]
