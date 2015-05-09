async = require "async"

jasmine.DEFAULT_TIMEOUT_INTERVAL = 10000

describe "timer", ->
	beforeEach ->
		browser.get "http://localhost:3000/"

	hours = element(By.model("hours"))
	minutes = element(By.model("minutes"))
	seconds = element(By.model("seconds"))

	start = element By.id "start"
	pause = element By.id "pause"
	stop = element By.id "stop"
	restart = element By.id "restart"
	snooze = element By.id "snooze"

	it "should get started", (done) ->
		isStopped = ->
			expect hours.getAttribute("disabled")
				.toBe(null)
			expect minutes.getAttribute("disabled")
				.toBe(null)
			expect seconds.getAttribute("disabled")
				.toBe(null)

			expect start.getAttribute("disabled")
				.toBe(null)
			expect pause.getAttribute("disabled")
				.toBe("true")
			expect stop.getAttribute("disabled")
				.toBe("true")
			expect restart.getAttribute("disabled")
				.toBe(null)
			expect snooze.getAttribute("disabled")
				.toBe(null)
		isStopped()

		minutes.clear().sendKeys 0
		seconds.clear().sendKeys 3
		start.click()

		expect hours.getAttribute("disabled")
			.toBe("true")
		expect minutes.getAttribute("disabled")
			.toBe("true")
		expect seconds.getAttribute("disabled")
			.toBe("true")
		expect start.getAttribute("disabled")
			.toBe("true")

		setTimeout ->
			isStopped()
			setTimeout done, 500 # all the get Attribute are promises
		, 4000

	it "should save cookies after refresh"