gulp = require 'gulp'
bower = require 'bower'
sass = require 'gulp-sass'
less = require 'gulp-less'
concat = require 'gulp-concat'
merge = require 'streamqueue'
minifyCss = require 'gulp-minify-css'
rename = require 'gulp-rename'
browserify = require 'browserify'
source = require 'vinyl-source-stream'

gulp.task 'default', ['css', 'coffee']

gulp.task 'css', ->
  [lessAll, scssAll, cssAll] = [
    gulp.src []
      .pipe less()
      .pipe concat 'less-files.less'
    gulp.src ['./index.scss']
      .pipe sass()
      .pipe concat 'scss-files.scss'
    gulp.src ['./node_modules/angularjs-toaster/toaster.css']
      .pipe concat 'css-files.css'
  ]
  merge objectMode: true, lessAll, cssAll, scssAll
    .pipe concat 'index.css'
    .pipe gulp.dest './'
    .pipe gulp.dest './test'
    .pipe minifyCss()
    .pipe rename extname: '.min.css'
    .pipe gulp.dest './'
    .pipe gulp.dest './test'

gulp.task 'lib', ->
  browserify entries: ['./index.coffee']
    .transform('coffeeify')
    .transform('debowerify')
    .bundle()
    .pipe source 'index.js'
    .pipe gulp.dest './'

gulp.task 'coffee', ['lib'], ->
  browserify entries: ['./test/index.coffee']
    .transform('coffeeify')
    .transform('debowerify')
    .bundle()
    .pipe source 'index.js'
    .pipe gulp.dest './test/'
