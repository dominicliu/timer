chrome = [{
		'browserName':'chrome'
		'name':'Timer'
		'platform': 'Windows 8.1'
		'version': '42'
	}
	{
		'browserName':'chrome'
		'name':'Timer'
		'platform': 'Windows 8'
		'version': '37'
	}
	{
		'browserName':'chrome'
		'name':'Timer'
		'platform': 'Windows 7'
		'version': '32'
	}]
ie = [{
	'browserName':'internet explorer'
	'name':'Timer'
	'platform': 'Windows 8.1'
	'version': '11'
}
{
	'browserName':'internet explorer'
	'name':'Timer'
	'platform': 'Windows 8'
	'version': '10'
}
{
	'browserName':'internet explorer'
	'name':'Timer'
	'platform': 'Windows 7'
	'version': '9'
}]
firefox = [{
	'browserName':'firefox'
	'name':'Timer'
	'platform': 'Windows 8.1'
	'version': '37'
}
{
	'browserName':'firefox'
	'name':'Timer'
	'platform': 'Windows 8'
	'version': '27'
}
{
	'browserName':'firefox'
	'name':'Timer'
	'platform': 'OS X 10.9'
	'version': '17'
}
{
	'browserName':'firefox'
	'name':'Timer'
	'platform': 'Linux'
	'version': '7'
}]
iphone = [{
	'browserName':'iphone'
	'name':'Timer'
	'platform': 'OS X 10.10'
	'version': '8.2'
	deviceName: 'iPhone Simulator'
	'device-orientation': 'portrait'
}
{
	'browserName':'iphone'
	'name':'Timer'
	'platform': 'OS X 10.10'
	'version': '7.0'
	deviceName: 'iPhone Simulator'
	'device-orientation': 'portrait'
}
{
	'browserName':'iphone'
	'name':'Timer'
	'platform': 'OS X 10.10'
	'version': '6.0'
	deviceName: 'iPhone Simulator'
	'device-orientation': 'portrait'
}
{
	'browserName':'iphone'
	'name':'Timer'
	'platform': 'OS X 10.10'
	'version': '5.0'
	deviceName: 'iPhone Simulator'
	'device-orientation': 'portrait'
}]

exports.config = {
	sauceUser: 'LakeHouse'
	sauceKey: 'f5b21db2-0746-4cb3-87ed-048160318724'
	specs: ['timer.coffee']
	multiCapabilities: chrome
}