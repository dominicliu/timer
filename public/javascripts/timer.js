// Generated by CoffeeScript 1.7.1
var Timer, notify, notify1, timer, timerId;

Timer = Ember.Application.create();

Timer.Timer = Ember.Object.extend({
  initialHours: 0,
  initialMinutes: 20,
  initialSeconds: 0,
  hours: 0,
  minutes: 20,
  seconds: 0,
  running: false,
  paused: false
});

timer = Timer.Timer.create({});

timerId = null;

Timer.IndexController = Ember.ObjectController.extend({
  actions: {
    start: function() {
      var that;
      this.set("running", true);
      if (!this.get("paused")) {
        this.set("initialHours", this.get("hours"));
        this.set("initialMinutes", this.get("minutes"));
        this.set("initialSeconds", this.get("seconds"));
      }
      this.set("paused", false);
      that = this;
      return timerId = countdown(moment().add("hours", this.get("hours")).add("minutes", this.get("minutes")).add("seconds", this.get("seconds")).toDate(), function(ts) {
        timer.set("hours", ts.hours);
        timer.set("minutes", ts.minutes);
        timer.set("seconds", ts.seconds);
        if (ts.hours === 0 && ts.minutes === 0 && ts.seconds === 0) {
          notify();
          return that.send("stop");
        }
      }, countdown.HOURS | countdown.MINUTES | countdown.SECONDS);
    },
    pause: function() {
      this.set("running", false);
      if (timerId != null) {
        clearInterval(timerId);
      }
      return this.set("paused", true);
    },
    stop: function() {
      this.set("running", false);
      this.set("paused", false);
      if (timerId != null) {
        clearInterval(timerId);
      }
      this.set("hours", this.get("initialHours"));
      this.set("minutes", this.get("initialMinutes"));
      return this.set("seconds", this.get("initialSeconds"));
    },
    restart: function() {
      this.send("stop");
      return this.send("start");
    },
    snooze: function() {
      if (this.get("running")) {
        this.send("pause");
        this.incrementProperty("minutes", 5);
        return this.send("start");
      } else if (this.get("paused")) {
        return this.incrementProperty("minutes", 5);
      } else {
        this.send("start");
        this.send("pause");
        this.set("hours", 0);
        this.set("minutes", 5);
        this.set("seconds", 0);
        return this.send("start");
      }
    }
  },
  runningOrPaused: (function() {
    return this.get("running") || this.get("paused");
  }).property("model.running", "model.paused")
});

Timer.IndexRoute = Ember.Route.extend({
  model: function() {
    return timer;
  }
});

notify1 = function() {
  var notification;
  if (!("Notification" in window)) {
    alert("This browser does not support desktop notification");
  } else if (Notification.permission === "granted") {
    notification = new Notification("Hi there!");
  } else if (Notification.permission !== "denied") {
    Notification.requestPermission(function(permission) {
      if (!("permission" in Notification)) {
        Notification.permission = permission;
      }
      if (permission === "granted") {
        notification = new Notification("Hi there!");
      }
    });
  }
};

notify = function() {
  return notify1();
};
