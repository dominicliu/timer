Timer = Ember.Application.create()

setCookie = (key, value) ->
	Cookies.set key, value,
		expires: 2592000

Timer.Timer = Ember.Object.extend
	initialHours: 0
	initialMinutes: 20
	initialSeconds: 0
	hours: 0
	minutes: 20
	seconds: 0
	running: false
	paused: false
	notificationGranted: false
	notificationDenied: false
	notification: false
	notificationInstance: null
	sound: false
	mode: "play"
	studyTime: 0
	workTime: 0
	playTime: 0

timer = Timer.Timer.create {}
timerId = null

Timer.IndexRoute = Ember.Route.extend
	model: ->
		return timer
	afterModel: (model) ->
		# retrieve data from cookies
		if Cookies.get "hours"
			model.set "hours", Cookies.get "hours"
		if Cookies.get "minutes"
			model.set "minutes", Cookies.get "minutes"
		if Cookies.get "seconds"
			model.set "seconds", Cookies.get "seconds"

		if Cookies.get "mode"
			model.set "mode", Cookies.get "mode"
		today = moment().format "YYYY MM DD"
		if Cookies.get("lastUsedDate") is today
			if Cookies.get "studyTime"
				model.set "studyTime", parseInt Cookies.get("studyTime")
			if Cookies.get "workTime"
				model.set "workTime", parseInt Cookies.get("workTime")
			if Cookies.get "playTime"
				model.set "playTime", parseInt Cookies.get("playTime")

		if Cookies.get "notification"
			model.set "notification", Cookies.get("notification") is "true"
		if Cookies.get "sound"
			model.set "sound", Cookies.get("sound") is "true"
		# check notification permissions
		unless Notification
			return model.set "notificationDenied", true
		permission = Notification.permission
		switch permission
			when "granted"
				model.set "notificationGranted", true
			when "denied"
				model.set "notificationDenied", true

Timer.IndexController = Ember.ObjectController.extend
	# secondsDisplay: ((key, value) ->
	# 		if arguments.length > 1
	# 			@set "seconds", parseInt value
	# 		return moment
	# 				second: @get("seconds")
	# 			.format "ss"
	# 	).property "seconds"
	init: ->
		that = this
		window.onbeforeunload = ->
			that.send "saveTimes"
			if (notificationInstance = that.get "notificationInstance") and notificationInstance.close?
				notificationInstance.close()
			if timer.get "running"
				return "Your timer is counting down."
			else
				return
		m = moment
			hour: 0
		.add 1, "days"
		setTimeout ->
			that.set "model.studyTime", 0
			that.set "model.workTime", 0
			that.set "model.playTime", 0
			that.send "saveTimes"
		, m.diff(moment())
	notRunning: (->
			return not @get("running")
		).property "model.running"
	notRunningOrPaused: (->
			return not (@get("running") || @get("paused"))
		).property "model.running", "model.paused"
	notificationChanged: (->
			if @get "notification"
				that = this
				text = "Time is up!"
				unless that.get "notificationGranted"
					Notification.requestPermission (permission) ->
						if permission is "granted"
							that.set "notificationGranted", true
							that.set "notification", true
							setCookie "notification", true
						else if permission is "denied"
							that.set "notification", false
							that.set "notificationDenied", true
				else
					setCookie "notification", true
			else
				setCookie "notification", false
		).observes "notification"
	soundChanged: (->
			setCookie "sound", @get "sound"
		).observes "sound"
	isStudying: (->
			@get("model.mode") is "study"
		).property "mode"
	isWorking: (->
			@get("model.mode") is "work"
		).property "mode"
	isPlaying: (->
			@get("model.mode") is "play"
		).property "mode"
	studyTimeFormatted: (->
			time = @get "model.studyTime"
			duration = moment.duration(time, "seconds")
			duration.hours() + ":" + duration.minutes() + ":" + duration.seconds()
		).property "model.studyTime"
	workTimeFormatted: (->
			time = @get "model.workTime"
			duration = moment.duration(time, "seconds")
			duration.hours() + ":" + duration.minutes() + ":" + duration.seconds()
		).property "model.workTime"
	playTimeFormatted: (->
			time = @get "model.playTime"
			duration = moment.duration(time, "seconds")
			duration.hours() + ":" + duration.minutes() + ":" + duration.seconds()
		).property "model.playTime"
	actions:
		start: ->
			@set "running", true
			if (notificationInstance = @get "notificationInstance") and notificationInstance.close?
				notificationInstance.close()
			unless @get "paused"
				# normalize time
				time = moment
					hour: @get "hours"
					minute: @get "minutes"
					second: @get "seconds"
				@set "hours", time.hour()
				@set "minutes", time.minute()
				@set "seconds", time.second()

				#set initial settings
				@set "initialHours", @get "hours"
				@set "initialMinutes", @get "minutes"
				@set "initialSeconds", @get "seconds"

				# set cookies
				setCookie "hours", @get "hours"
				setCookie "minutes", @get "minutes"
				setCookie "seconds", @get "seconds"
			@set "paused", false
			that = this
			firstSecond = true
			timerId = countdown moment().add("hours", @get "hours").add("minutes", @get "minutes").add("seconds", @get "seconds").toDate(), (ts) ->
				timer.set "hours", ts.hours
				timer.set "minutes", ts.minutes
				timer.set "seconds", ts.seconds

				mode = that.get "model.mode"
				unless firstSecond
					that.incrementProperty "model.#{mode}Time"
				firstSecond = false

				document.title = "timer - " + moment
						hour: timer.get "hours"
						minute: timer.get "minutes"
						second: timer.get "seconds"
					.format "H:m:s"
				if ts.value >= 0 or ts.hours is 0 and ts.minutes is 0 and ts.seconds is 0
					if that.get "notification"
						notificationInstance = new Notification "Time is up!",
							icon: "../images/favicon.ico"
						that.set "notificationInstance", notificationInstance
					if that.get "sound"
						audio = new Audio "../images/bell.mp3"
						audio.play()
					that.send "stop"
			, countdown.HOURS|countdown.MINUTES|countdown.SECONDS
		pause: ->
			@set "running", false
			if timerId?
				clearInterval timerId
			@set "paused", true
		stop: ->
			@set "running", false
			@set "paused", false
			if timerId?
				clearInterval timerId
			@set "hours", @get "initialHours"
			@set "minutes", @get "initialMinutes"
			@set "seconds", @get "initialSeconds"
			@send "saveTimes"
			document.title = "timer"
		restart: ->
			@send "stop"
			@send "start"
		snooze: ->
			if @get "running"
				@send "pause"
				@incrementProperty "minutes", 5
				@send "start"
			else if @get "paused"
				@incrementProperty "minutes", 5
			else
				@send "start"
				@send "pause"
				@set "hours", 0
				@set "minutes", 5
				@set "seconds", 0
				@send "start"
		setMode: (mode) ->
			@set "mode", mode
			setCookie "mode", mode
		saveTimes: ->
			setCookie "studyTime", @get "model.studyTime"
			setCookie "workTime", @get "model.workTime"
			setCookie "playTime", @get "model.playTime"
			today = moment().format "YYYY MM DD"
			setCookie "lastUsedDate", today

Timer.FocusInputComponent = Ember.TextField.extend
	becomeFocused: (->
			@$().focus()
			@$()[0].selectionStart = @$()[0].selectionEnd = @$()[0].value.length # focus at the end
		).on 'didInsertElement'