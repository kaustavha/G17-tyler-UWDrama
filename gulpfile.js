var gulp = require('gulp'),
    log = require('gulp-util').log,
    rename = require('gulp-rename'),
    jade = require('gulp-jade'),
    stylus = require('gulp-stylus'),
    uglify = require('gulp-uglify'),
    concat = require('gulp-concat'),
    coffee = require('gulp-coffee');

gulp.task('templates', function() {
	var locs = { pretty: true };	 
	gulp.src('./src/jade.jade')
	    .pipe(jade({locals: locs}))
	    .pipe(rename('index.html'))
	    .pipe(gulp.dest('./'))
});
gulp.task('scripts', function() {
	gulp.src('./src/*.coffee')
	    .pipe(coffee({bare: true}).on('error', log))
	    .pipe(rename('scripts.js'))
	    .pipe(gulp.dest('./assets'));
    gulp.src(['./src/lib/jq.js', './src/lib/*.js'])
        .pipe(concat('lib.min.js'))
        .pipe(uglify())
        .pipe(gulp.dest('./assets'))              
});
gulp.task('styles', function() {
           gulp.src('./src/*.styl')
	           .pipe(stylus().on('error', log))
	           .pipe(rename('styles.css'))
	           .pipe(gulp.dest('./assets'))
});
gulp.task('watch', function() {
	log('Watching files');
	gulp.watch('./src/*', ['build']);
});

//define cmd line default task
gulp.task('build', ['templates', 'styles', 'scripts']);
gulp.task('default', ['build', 'watch']);