module.exports = (grunt) ->
	grunt.initConfig
		watch:
			coffee:
				files: 'public/javascripts/*.coffee'
				tasks: ['coffee:compile']
				options:
					atBegin: true

		coffee:
			compile:
				expand: true,
				flatten: true,
				cwd: "#{__dirname}/public/javascripts",
				src: ['*.coffee'],
				dest: 'public/javascripts',
				ext: '.js'
				options:
					bare: true

	grunt.loadNpmTasks "grunt-contrib-coffee"
	grunt.loadNpmTasks "grunt-contrib-watch"