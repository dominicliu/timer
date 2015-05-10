exports.config = {
	sauceUser: 'LakeHouse'
	sauceKey: 'f5b21db2-0746-4cb3-87ed-048160318724'
	# seleniumAddress: 'http://localhost:4444/wd/hub'
	specs: ['timer.coffee']
	capabilities:
		'browserName':'firefox'
		'name':'Timer'
		'platform': 'Windows 8.1'
		'version': '33'
}