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
			timerId = countdown moment().add("hours", @get "hours").add("minutes", @get "minutes").add("seconds", @get "seconds").toDate(), (ts) ->
				timer.set "hours", ts.hours
				timer.set "minutes", ts.minutes
				timer.set "seconds", ts.seconds
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