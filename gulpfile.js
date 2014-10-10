var gulp = require('gulp');
var coffee = require('gulp-coffee');
// var sourcemaps = require('gulp-sourcemaps');

var paths = {
  coffee: ['coffee/**/*.coffee'],
};

gulp.task('coffee', function() {
  return gulp.src(paths.coffee)
    // .pipe(sourcemaps.init())
      .pipe(coffee())
    // .pipe(sourcemaps.write())
    .pipe(gulp.dest('scripts'));
});

gulp.task('watch', function() {
  gulp.watch(paths.coffee, ['coffee']);
});

gulp.task('default', ['watch', 'coffee']);
