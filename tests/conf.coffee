exports.config = {
	seleniumAddress: 'http://localhost:4444/wd/hub'
	specs: ['timer.coffee']
	capabilities:
		'browserName':'chrome'
}