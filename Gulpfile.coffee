gulp = require 'gulp'
bower = require 'bower'
concat = require 'gulp-concat'
merge = require 'streamqueue'
rename = require 'gulp-rename'
copy = require 'gulp-copy'
browserify = require 'browserify'
streamify = require 'gulp-streamify'
uglify = require 'gulp-uglify'
source = require 'vinyl-source-stream'
rework = require 'gulp-rework'
reworkNPM = require 'rework-npm'
cleanCSS = require 'gulp-clean-css'
del = require 'del'

gulp.task 'default', ['css', 'coffee', 'test']

gulp.task 'css', ->
  gulp.src 'log_toast.css'
    .pipe rework reworkNPM shim: 'angularjs-toaster': 'toaster.css'
    .pipe rename 'index.css'
    .pipe gulp.dest './'
    .pipe cleanCSS()
    .pipe rename 'index.min.css'
    .pipe gulp.dest './'

gulp.task 'coffee', ->
  browserify entries: ['./index.coffee']
    .transform('coffeeify')
    .transform('debowerify')
    .bundle()
    .pipe source 'index.js'
    .pipe gulp.dest './'
    .pipe streamify uglify()
    .pipe rename extname: '.min.js'
    .pipe gulp.dest './'

gulp.task 'test', ['coffee'], ->
  gulp.src 'index.min.css'
    .pipe copy './test'

  browserify entries: ['./test/index.coffee']
    .transform('coffeeify')
    .transform('debowerify')
    .bundle()
    .pipe source 'index.js'
    .pipe gulp.dest './test/'
    .pipe streamify uglify()
    .pipe rename extname: '.min.js'
    .pipe gulp.dest './'

gulp.task 'clean', ->
  del [
    'index.js'
    'index.min.js'
    'index.css'
    'index.min.css'
    'test/index.js'
    'test/index.min.js'
    'test/index.css'
    'test/index.min.css'
    'node_modules'
  ]
