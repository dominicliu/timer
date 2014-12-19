var Timer, setCookie, timer, timerId;

Timer = Ember.Application.create();

setCookie = function(key, value) {
  return Cookies.set(key, value, {
    expires: 2592000
  });
};

Timer.Timer = Ember.Object.extend({
  initialHours: 0,
  initialMinutes: 20,
  initialSeconds: 0,
  hours: 0,
  minutes: 20,
  seconds: 0,
  running: false,
  paused: false,
  notificationGranted: false,
  notificationDenied: false,
  notification: false,
  notificationInstance: null,
  sound: false
});

timer = Timer.Timer.create({});

timerId = null;

Timer.IndexRoute = Ember.Route.extend({
  model: function() {
    return timer;
  },
  afterModel: function(model) {
    var permission;
    if (Cookies.get("hours")) {
      model.set("hours", Cookies.get("hours"));
    }
    if (Cookies.get("minutes")) {
      model.set("minutes", Cookies.get("minutes"));
    }
    if (Cookies.get("seconds")) {
      model.set("seconds", Cookies.get("seconds"));
    }
    if (Cookies.get("notification")) {
      model.set("notification", Cookies.get("notification") === "true");
    }
    if (Cookies.get("sound")) {
      model.set("sound", Cookies.get("sound") === "true");
    }
    if (!Notification) {
      return model.set("notificationDenied", true);
    }
    permission = Notification.permission;
    switch (permission) {
      case "granted":
        return model.set("notificationGranted", true);
      case "denied":
        return model.set("notificationDenied", true);
    }
  }
});

Timer.IndexController = Ember.ObjectController.extend({
  init: function() {
    var that;
    that = this;
    return window.onbeforeunload = function() {
      var notificationInstance;
      if ((notificationInstance = that.get("notificationInstance")) && (notificationInstance.close != null)) {
        notificationInstance.close();
      }
      if (timer.get("running")) {
        return "Your timer is counting down.";
      } else {

      }
    };
  },
  notRunning: (function() {
    return !this.get("running");
  }).property("model.running"),
  notRunningOrPaused: (function() {
    return !(this.get("running") || this.get("paused"));
  }).property("model.running", "model.paused"),
  notificationChanged: (function() {
    var text, that;
    if (this.get("notification")) {
      that = this;
      text = "Time is up!";
      if (!that.get("notificationGranted")) {
        return Notification.requestPermission(function(permission) {
          if (permission === "granted") {
            that.set("notificationGranted", true);
            that.set("notification", true);
            return setCookie("notification", true);
          } else if (permission === "denied") {
            that.set("notification", false);
            return that.set("notificationDenied", true);
          }
        });
      } else {
        return setCookie("notification", true);
      }
    } else {
      return setCookie("notification", false);
    }
  }).observes("notification"),
  soundChanged: (function() {
    return setCookie("sound", this.get("sound"));
  }).observes("sound"),
  actions: {
    start: function() {
      var notificationInstance, that, time;
      this.set("running", true);
      if ((notificationInstance = this.get("notificationInstance")) && (notificationInstance.close != null)) {
        notificationInstance.close();
      }
      if (!this.get("paused")) {
        time = moment({
          hour: this.get("hours"),
          minute: this.get("minutes"),
          second: this.get("seconds")
        });
        this.set("hours", time.hour());
        this.set("minutes", time.minute());
        this.set("seconds", time.second());
        this.set("initialHours", this.get("hours"));
        this.set("initialMinutes", this.get("minutes"));
        this.set("initialSeconds", this.get("seconds"));
        setCookie("hours", this.get("hours"));
        setCookie("minutes", this.get("minutes"));
        setCookie("seconds", this.get("seconds"));
      }
      this.set("paused", false);
      that = this;
      return timerId = countdown(moment().add("hours", this.get("hours")).add("minutes", this.get("minutes")).add("seconds", this.get("seconds")).toDate(), function(ts) {
        var audio;
        timer.set("hours", ts.hours);
        timer.set("minutes", ts.minutes);
        timer.set("seconds", ts.seconds);
        document.title = "timer - " + moment({
          hour: timer.get("hours"),
          minute: timer.get("minutes"),
          second: timer.get("seconds")
        }).format("H:m:s");
        if (ts.hours === 0 && ts.minutes === 0 && ts.seconds === 0) {
          if (that.get("notification")) {
            notificationInstance = new Notification("Time is up!", {
              icon: "../images/favicon.ico"
            });
            that.set("notificationInstance", notificationInstance);
          }
          if (that.get("sound")) {
            audio = new Audio("../images/bell.mp3");
            audio.play();
          }
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
      this.set("seconds", this.get("initialSeconds"));
      return document.title = "timer";
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
  }
});

Timer.FocusInputComponent = Ember.TextField.extend({
  becomeFocused: (function() {
    this.$().focus();
    return this.$()[0].selectionStart = this.$()[0].selectionEnd = this.$()[0].value.length;
  }).on('didInsertElement')
});
