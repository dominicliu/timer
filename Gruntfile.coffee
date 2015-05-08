module.exports = (grunt) ->
	grunt.initConfig
		watch:
			coffee:
				files: 'public/javascripts/*.coffee'
				tasks: ['coffee:compile']
				options:
					atBegin: true
			less:
				files: ["<%= dirs.less %>/**/*.less"]
				tasks: ["less:compile"]
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

		dirs:
			less: "public/stylesheets/less"
		
		less:
			compile:
				files:
					"public/stylesheets/css/timer.css": "<%= dirs.less %>/timer.less"
				options:
					cleancss: true

	grunt.loadNpmTasks "grunt-contrib-coffee"
	grunt.loadNpmTasks "grunt-contrib-watch"
	grunt.loadNpmTasks "grunt-contrib-less"