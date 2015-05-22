module.exports = (gulp, plugins) ->
    gulp.task 'test:unit', 'runs unit tests using mocha', (next) -> next()
    gulp.task 'test:integration', 'runs integration tests using mocha', (next) -> next()

