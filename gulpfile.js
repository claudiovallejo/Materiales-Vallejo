var gulp = require('gulp'),
    htmlmin = require('gulp-htmlmin'),
    concat = require('gulp-concat'),
    uncss = require('gulp-uncss'),
    cssmin = require('gulp-csso'),
    uglify = require('gulp-uglify'),
    gzip = require('gulp-gzip');
    imagemin = require('gulp-imagemin'),
    sitemap = require('gulp-sitemap'),
    runSequence = require('run-sequence'),
    clean = require('gulp-clean');

//  Minify .html
gulp.task('markup', function(){
  gulp.src('build/**/*.html')
  .pipe(htmlmin())
  .pipe(gulp.dest('build'))
});

//  Remove unused css from tachyons.css
gulp.task('uncss', function(){
  return gulp.src('build/stylesheets/tachyons.css')
    .pipe(uncss({ html: ['build/**/*.html'] }))
    .pipe(cssmin())
    .pipe(gulp.dest('build/stylesheets'))
});

//  Concatenate site.css + animate.css -> site.css
//  Minify site.css + Gzip site.css
gulp.task('styles', function(){
  gulp.src(['build/stylesheets/tachyons.css', 'build/stylesheets/site.css'])
  .pipe(concat('site.css'))
  .pipe(cssmin())
  .pipe(gulp.dest('build/stylesheets'))
  .pipe(gzip())
  .pipe(gulp.dest('build/stylesheets'))
});

//  Minify all.js
gulp.task('scripts', function(){
  gulp.src('build/javascripts/all.js')
  .pipe(uglify())
  .pipe(gulp.dest('build/javascripts'))
  .pipe(gzip())
  .pipe(gulp.dest('build/javascripts'))
});

//  Optimize images
gulp.task('images', function(){
  gulp.src('build/images/**/*')
    .pipe(imagemin({ progressive: true }))
    .pipe(gulp.dest('build/images'))
});

//  Generate sitemap
gulp.task('sitemap', function() {
  gulp.src('build/**/*.html', {
    read: false
  })
  .pipe(sitemap({
    siteUrl: 'http://materialesvallejo.netlify.com/'
  }))
  .pipe(gulp.dest('./build'));
});

//  Remove unused files
gulp.task('clean', function(){
  gulp.src('build/stylesheets/tachyons.css', {read: false})
  .pipe(clean());
});

// Run previously `gulp` tasks in sequence
gulp.task('sequence', function(callback) {
  runSequence('uncss', ['markup', 'styles', 'scripts', 'images', 'sitemap'], 'clean');
});

// Build
gulp.task('build', ['sequence']);
