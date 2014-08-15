module.exports = (grunt) ->
	grunt.initConfig
		watch:
			coffee:
				files: 'public/javascripts/*.coffee'
				tasks: ['coffee:compile']
				options:
					atBegin: true
			emberTemplates:
				files: ["<%= emberTemplates.compile.src %>"]
				tasks: ["emberTemplates:compile"]
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
			templates: "templates"
		emberTemplates:
			compile:
				src: "<%= dirs.templates %>/**/*.hbs"
				dest: "public/javascripts/templates.js"
				options:
					templateBasePath: "<%= dirs.templates %>"

	grunt.loadNpmTasks "grunt-contrib-coffee"
	grunt.loadNpmTasks "grunt-ember-templates"
	grunt.loadNpmTasks "grunt-contrib-watch"