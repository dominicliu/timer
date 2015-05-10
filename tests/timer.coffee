async = require "async"
_ = require "underscore"

jasmine.DEFAULT_TIMEOUT_INTERVAL = 10000

url = "http://localhost:3000/"

describe "timer", ->
	beforeEach ->
		browser.get url

	hours = element(By.model("hours"))
	minutes = element(By.model("minutes"))
	seconds = element(By.model("seconds"))

	start = element By.id "start"
	pause = element By.id "pause"
	stop = element By.id "stop"
	restart = element By.id "restart"
	snooze = element By.id "snooze"

	study = element By.id "study"
	work = element By.id "work"
	play = element By.id "play"

	studyTime = element By.id "studyTime"
	workTime = element By.id "workTime"
	playTime = element By.id "playTime"

	studyTimeEditing = element By.id "studyTimeEditing"
	workTimeEditing = element By.id "workTimeEditing"
	playTimeEditing = element By.id "playTimeEditing"

	expectDisabled = (elem, disabled) ->
		expect elem.getAttribute("disabled")
			.toBe(disabled)

	isStopped = ->
		expectDisabled hours, null
		expectDisabled minutes, null
		expectDisabled seconds, null

		expectDisabled start, null
		expectDisabled pause, "true"
		expectDisabled stop, "true"
		expectDisabled restart, null
		expectDisabled snooze, null

	isRunning = ->
		expectDisabled hours, "true"
		expectDisabled minutes, "true"
		expectDisabled seconds, "true"

		expectDisabled start, "true"
		expectDisabled pause, null
		expectDisabled stop, null
		expectDisabled restart, null
		expectDisabled snooze, null

	it "should start, and then stop", ->
		isStopped()
		minutes.clear().sendKeys 0
		seconds.clear().sendKeys 10
		start.click()

		isRunning()
		browser.sleep 11000
		isStopped()

	it "should save cookies after refresh", ->
		numSeconds = _.random(10, 59)
		minutes.clear().sendKeys 0
		seconds.clear().sendKeys numSeconds

		start.click()
		stop.click()
		browser.get url
		expect seconds.getAttribute "value"
			.toEqual numSeconds.toString()

	it "should work on the modes", ->
		testMode = (button, timeElement) ->
			minutes.clear().sendKeys 0
			seconds.clear().sendKeys 3
			button.click()
			start.click()

			browser.sleep 5000
			expect timeElement.getText()
				.toEqual "0:0:3"

		browser.executeScript "clearTimes()"

		testMode study, studyTime
		testMode work, workTime
		testMode play, playTime

	it "should accept enter key", ->
		minutes.clear().sendKeys 0
		seconds.clear().sendKeys 20
		seconds.sendKeys protractor.Key.ENTER
		isRunning()
		stop.click()

	it "should edit times", ->
		test = (timeElem, editingElem, method) ->
			browser.actions().doubleClick(timeElem).perform()
			# should have focus
			expect browser.driver.switchTo().activeElement().getAttribute('id')
				.toEqual editingElem.getAttribute("id")
			# press enter
			time = _.random(23) + ":" + _.random(59) + ":" + _.random(59)
			editingElem.clear().sendKeys time
			if method is "enter"
				editingElem.sendKeys protractor.Key.ENTER
			else if method is "blur"
				hours.click()
			# shoud have time
			expect timeElem.getText()
				.toEqual time
		test studyTime, studyTimeEditing, "enter"
		test workTime, workTimeEditing, "enter"
		test playTime, playTimeEditing, "enter"

		test studyTime, studyTimeEditing, "blur"
		test workTime, workTimeEditing, "blur"
		test playTime, playTimeEditing, "blur"