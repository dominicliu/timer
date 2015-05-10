timer = angular.module "timer", []

timer.controller "indexController", ["$scope", ($scope) ->
	$scope.timerId = null

	$scope.initialHours = 0
	$scope.initialMinutes = 20
	$scope.initialSeconds = 0

	$scope.hours = 0
	$scope.minutes = 0
	$scope.seconds = 5

	$scope.running = false
	$scope.paused = false

	$scope.notification = false
	$scope.notificationInstance = null
	$scope.notificationGranted = false
	$scope.notificationDenied = false
	$scope.sound = false

	$scope.mode = "study"
	$scope.studyTime = 0
	$scope.workTime = 0
	$scope.playTime = 0

	$scope.setCookie = (key, value) ->
		Cookies.set key, value,
			expires: 2592000

	# retrieve data from cookies
	if hours = Cookies.get "hours"
		$scope.hours = hours
	if minutes = Cookies.get "minutes"
		$scope.minutes = minutes
	if seconds = Cookies.get "seconds"
		$scope.seconds = seconds

	if Cookies.get "mode"
		$scope.mode = Cookies.get "mode"
	today = moment().format "YYYY MM DD"
	if Cookies.get("lastUsedDate") is today
		if Cookies.get "studyTime"
			$scope.studyTime = parseInt Cookies.get("studyTime")
		if Cookies.get "workTime"
			$scope.workTime = parseInt Cookies.get("workTime")
		if Cookies.get "playTime"
			$scope.playTime = parseInt Cookies.get("playTime")

	if Cookies.get "notification"
		$scope.notification = Cookies.get("notification") is "true"
	if Cookies.get "sound"
		$scope.sound = Cookies.get("sound") is "true"
	# check notification permissions
	unless Notification?
		$scope.notificationDenied = true
	else
		permission = Notification.permission
		switch permission
			when "granted"
				$scope.notificationGranted = true
			when "denied"
				$scope.notificationDenied = true

	window.onbeforeunload = ->
		$scope.saveTimes()
		if $scope.notificationInstance and $scope.notificationInstance.close?
			$scope.notificationInstance.close()
		if $scope.running
			return "Your timer is counting down."
		else
			return
	m = moment
		hour: 0
	.add 1, "days"
	setTimeout ->
		$scope.studyTime = 0
		$scope.workTime = 0
		$scope.playTime = 0
		$scope.saveTimes()
	, m.diff(moment())

	window.clearTimes = ->
		$scope.$apply ->
			$scope.studyTime = 0
			$scope.workTime = 0
			$scope.playTime = 0

	$scope.$watch "notification", ->
		if $scope.notification
			unless $scope.notificationGranted
				Notification.requestPermission (permission) ->
					if permission is "granted"
						$scope.notificationGranted = true
						$scope.notification = true
						$scope.setCookie "notification", true
					else if permission is "denied"
						$scope.notification = false
						$scope.notificationDenied = true
			else
				$scope.setCookie "notification", true
		else
			$scope.setCookie "notification", false
	$scope.$watch "sound", ->
		$scope.setCookie "sound", $scope.sound

	$scope.start = ->
		$scope.running = true
		if $scope.notificationInstance and $scope.notificationInstance.close?
			$scope.notificationInstance.close()
		unless $scope.paused
			# normalize time
			time = moment
				hour: $scope.hours
				minute: $scope.minutes
				second: $scope.seconds
			$scope.hours = time.hour().toString()
			$scope.minutes = time.minute().toString()
			$scope.seconds = time.second().toString()

			# set initial settings
			$scope.initialHours = $scope.hours
			$scope.initialMinutes = $scope.minutes
			$scope.initialSeconds = $scope.seconds

			# set cookies
			$scope.setCookie "hours", $scope.hours
			$scope.setCookie "minutes", $scope.minutes
			$scope.setCookie "seconds", $scope.seconds
		$scope.paused = false
		that = this
		lastTimeValue = null
		$scope.timerId = countdown moment().add("hours", $scope.hours).add("minutes", $scope.minutes).add("seconds", $scope.seconds).toDate(), (ts) ->
			$scope.hours = ts.hours
			$scope.minutes = ts.minutes
			$scope.seconds = ts.seconds

			mode = $scope.mode
			if lastTimeValue
				$scope["#{mode}Time"] += ts.value - lastTimeValue
			lastTimeValue = ts.value

			document.title = "timer - " + moment
					hour: $scope.hours
					minute: $scope.minutes
					second: $scope.seconds
				.format "H:m:s"
			if ts.value >= 0 or ts.hours is 0 and ts.minutes is 0 and ts.seconds is 0
				if $scope.notification
					$scope.notificationInstance = new Notification "Time is up!",
						icon: "../images/favicon.ico"
				if $scope.sound
					audio = new Audio "../images/bell.mp3"
					audio.play()
				$scope.stop()
			unless $scope.$$phase
				$scope.$digest()
		, countdown.HOURS|countdown.MINUTES|countdown.SECONDS
	$scope.pause = ->
		$scope.running = false
		if $scope.timerId?
			clearInterval $scope.timerId
		$scope.paused = true
	$scope.stop = ->
		$scope.running = false
		$scope.paused = false
		if $scope.timerId?
			clearInterval $scope.timerId
		$scope.hours = $scope.initialHours
		$scope.minutes = $scope.initialMinutes
		$scope.seconds = $scope.initialSeconds
		$scope.saveTimes()
		document.title = "timer"
	$scope.restart = ->
		$scope.stop()
		$scope.start()
	$scope.snooze = ->
		if $scope.running
			$scope.pause()
			$scope.minutes = $scope.minutes + 5
			$scope.start()
		else if $scope.paused
			$scope.minutes = $scope.minutes + 5
		else
			$scope.start()
			$scope.pause()
			$scope.hours = 0
			$scope.minutes = 5
			$scope.seconds = 0
			$scope.start()
	$scope.setMode = (mode) ->
		$scope.mode = mode
		$scope.setCookie "mode", mode
	$scope.saveTimes = ->
		$scope.setCookie "studyTime", $scope.studyTime
		$scope.setCookie "workTime", $scope.workTime
		$scope.setCookie "playTime", $scope.playTime
		today = moment().format "YYYY MM DD"
		$scope.setCookie "lastUsedDate", today
	$scope.formatTime = (time) ->
		offset = 0
		if time % 1000 > 800
			offset = 1
		duration = moment.duration(time / 1000 + offset, "seconds")
		duration.hours() + ":" + duration.minutes() + ":" + duration.seconds()

	$scope.editingTime =
		study: ""
		work: null
		play: null
	$scope.isEditingTime =
		study: false
		work: false
		play: false
	$scope.editTime = (mode) ->
		$scope.editingTime[mode] = $scope.formatTime($scope["#{mode}Time"])
		$scope.isEditingTime[mode] = true

	$scope.finishEditingTime = (mode) ->
		$scope.isEditingTime[mode] = false
		unless $scope.editingTime[mode]
			return
		numbers = $scope.editingTime[mode].match(/\d+/g)
		totalTime = 0
		for number in numbers
			totalTime = totalTime * 60 + ((parseInt number) or 0)
		$scope["#{mode}Time"] = totalTime * 1000
]

timer.directive 'ngEnter', ->
	(scope, element, attrs) ->
		element.bind 'keydown keypress', (event) ->
			if event.which == 13
				scope.$apply ->
					scope.$eval attrs.ngEnter, 'event': event
				event.preventDefault()

timer.directive 'ngAutoFocus', ->
	(scope, element, attrs) ->
		element[0].focus()
		element[0].selectionStart = element[0].selectionEnd = element[0].value.length # focus at the end

timer.directive 'makeFocus', ($timeout) ->
	'use strict'
	(scope, elem, attrs) ->
		scope.$watch attrs.makeFocus, (newVal) ->
			if newVal
				$timeout (->
					elem[0].focus()
				), 0, false