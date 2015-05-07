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

	$scope.notification = true # todo: change
	$scope.notificationInstance = null
	$scope.sound = true # todo: change

	$scope.setCookie = (key, value) ->
		Cookies.set key, value,
			expires: 2592000

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
		firstSecond = true
		$scope.timerId = countdown moment().add("hours", $scope.hours).add("minutes", $scope.minutes).add("seconds", $scope.seconds).toDate(), (ts) ->
			$scope.hours = ts.hours
			$scope.minutes = ts.minutes
			$scope.seconds = ts.seconds

			# mode = that.get "model.mode"
			# unless firstSecond
			# 	that.incrementProperty "model.#{mode}Time"
			# firstSecond = false

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
		# $scope.saveTimes()
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
	# $scope.saveTimes = ->
	# 	$scope.setCookie "studyTime", $scope.model.studyTime
	# 	$scope.setCookie "workTime", $scope.model.workTime
	# 	$scope.setCookie "playTime", $scope.model.playTime
	# 	today = moment().format "YYYY MM DD"
	# 	$scope.setCookie "lastUsedDate", today
]