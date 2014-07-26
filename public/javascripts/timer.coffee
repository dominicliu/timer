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

timer = Timer.Timer.create {}
timerId = null

Timer.IndexController = Ember.ObjectController.extend
	actions:
		start: ->
			@set "running", true
			unless @get "paused"
				@set "initialHours", @get "hours"
				@set "initialMinutes", @get "minutes"
				@set "initialSeconds", @get "seconds"
			@set "paused", false
			that = this
			timerId = countdown moment().add("hours", @get "hours").add("minutes", @get "minutes").add("seconds", @get "seconds").toDate(), (ts) ->
				timer.set "hours", ts.hours
				timer.set "minutes", ts.minutes
				timer.set "seconds", ts.seconds
				if ts.hours is 0 and ts.minutes is 0 and ts.seconds is 0
					notify()
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

	runningOrPaused: (->
			return @get("running") || @get("paused")
		).property "model.running", "model.paused"

Timer.IndexRoute = Ember.Route.extend
	model: ->
		return timer

notify1 = ->
	# Let's check if the browser supports notifications
	unless "Notification" of window
		alert "This browser does not support desktop notification"
	
	# Let's check if the user is okay to get some notification
	else if Notification.permission is "granted"
		
		# If it's okay let's create a notification
		notification = new Notification("Hi there!")
	
	# Otherwise, we need to ask the user for permission
	# Note, Chrome does not implement the permission static property
	# So we have to check for NOT 'denied' instead of 'default'
	else if Notification.permission isnt "denied"
		Notification.requestPermission (permission) ->
			# Whatever the user answers, we make sure we store the information
			Notification.permission = permission  unless "permission" of Notification
			
			# If the user is okay, let's create a notification
			notification = new Notification("Hi there!")  if permission is "granted"
			return

	return

# At last, if the user already denied any notification, and you 
# want to be respectful there is no need to bother him any more.

notify = ->
	notify1()