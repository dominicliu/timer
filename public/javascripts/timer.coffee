Timer = Ember.Application.create()

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

timer = Timer.Timer.create {}
timerId = null

Timer.IndexController = Ember.ObjectController.extend
	actions:
		start: ->
			@set "running", true
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
				Cookies.set "hours", @get "hours"
				Cookies.set "minutes", @get "minutes"
				Cookies.set "seconds", @get "seconds"
			@set "paused", false
			that = this
			timerId = countdown moment().add("hours", @get "hours").add("minutes", @get "minutes").add("seconds", @get "seconds").toDate(), (ts) ->
				timer.set "hours", ts.hours
				timer.set "minutes", ts.minutes
				timer.set "seconds", ts.seconds
				if ts.hours is 0 and ts.minutes is 0 and ts.seconds is 0
					if that.get "notification"
						new Notification "Time is up!"
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

		turnOnNotification: ->
			that = this
			text = "Time is up!"
			unless that.get "notificationGranted"
				Notification.requestPermission (permission) ->
					if permission is "granted"
						that.set "notificationGranted", true
						that.set "notification", true
						Cookies.set "notification", true
					else if permission is "denied"
						that.set "notificationDenied", true
			else
				that.set "notification", true
				Cookies.set "notification", true
		turnOffNotification: ->
			@set "notification", false
			Cookies.set "notification", false

	runningOrPaused: (->
			return @get("running") || @get("paused")
		).property "model.running", "model.paused"

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
		if Cookies.get "notification"
			model.set "notification", Cookies.get("notification") is "true"
		# check notification permissions
		unless Notification
			return model.set "notificationDenied", true
		permission = Notification.permission
		switch permission
			when "granted"
				model.set "notificationGranted", true
			when "denied"
				model.set "notificationDenied", true