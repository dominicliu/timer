var timer;

timer = angular.module("timer", []);

timer.controller("indexController", [
  "$scope", function($scope) {
    var hours, minutes, permission, seconds;
    $scope.timerId = null;
    $scope.initialHours = 0;
    $scope.initialMinutes = 20;
    $scope.initialSeconds = 0;
    $scope.hours = 0;
    $scope.minutes = 0;
    $scope.seconds = 5;
    $scope.running = false;
    $scope.paused = false;
    $scope.notification = false;
    $scope.notificationInstance = null;
    $scope.sound = false;
    $scope.setCookie = function(key, value) {
      return Cookies.set(key, value, {
        expires: 2592000
      });
    };
    if (hours = Cookies.get("hours")) {
      $scope.hours = hours;
    }
    if (minutes = Cookies.get("minutes")) {
      $scope.minutes = minutes;
    }
    if (seconds = Cookies.get("seconds")) {
      $scope.seconds = seconds;
    }
    if (Cookies.get("notification")) {
      $scope.notification = Cookies.get("notification") === "true";
    }
    if (Cookies.get("sound")) {
      $scope.sound = Cookies.get("sound") === "true";
    }
    if (!Notification) {
      return $scope.notificationDenied = true;
    }
    permission = Notification.permission;
    switch (permission) {
      case "granted":
        $scope.notificationGranted = true;
        break;
      case "denied":
        $scope.notificationDenied = true;
    }
    $scope.$watch("notification", function() {
      if ($scope.notification) {
        if (!$scope.notificationGranted) {
          return Notification.requestPermission(function(permission) {
            if (permission === "granted") {
              $scope.notificationGranted = true;
              $scope.notification = true;
              return $scope.setCookie("notification", true);
            } else if (permission === "denied") {
              $scope.notification = false;
              return $scope.notificationDenied = true;
            }
          });
        } else {
          return $scope.setCookie("notification", true);
        }
      } else {
        return $scope.setCookie("notification", false);
      }
    });
    $scope.$watch("sound", function() {
      return $scope.setCookie("sound", $scope.sound);
    });
    $scope.start = function() {
      var firstSecond, that, time;
      $scope.running = true;
      if ($scope.notificationInstance && ($scope.notificationInstance.close != null)) {
        $scope.notificationInstance.close();
      }
      if (!$scope.paused) {
        time = moment({
          hour: $scope.hours,
          minute: $scope.minutes,
          second: $scope.seconds
        });
        $scope.hours = time.hour().toString();
        $scope.minutes = time.minute().toString();
        $scope.seconds = time.second().toString();
        $scope.initialHours = $scope.hours;
        $scope.initialMinutes = $scope.minutes;
        $scope.initialSeconds = $scope.seconds;
        $scope.setCookie("hours", $scope.hours);
        $scope.setCookie("minutes", $scope.minutes);
        $scope.setCookie("seconds", $scope.seconds);
      }
      $scope.paused = false;
      that = this;
      firstSecond = true;
      return $scope.timerId = countdown(moment().add("hours", $scope.hours).add("minutes", $scope.minutes).add("seconds", $scope.seconds).toDate(), function(ts) {
        var audio;
        $scope.hours = ts.hours;
        $scope.minutes = ts.minutes;
        $scope.seconds = ts.seconds;
        document.title = "timer - " + moment({
          hour: $scope.hours,
          minute: $scope.minutes,
          second: $scope.seconds
        }).format("H:m:s");
        if (ts.value >= 0 || ts.hours === 0 && ts.minutes === 0 && ts.seconds === 0) {
          if ($scope.notification) {
            $scope.notificationInstance = new Notification("Time is up!", {
              icon: "../images/favicon.ico"
            });
          }
          if ($scope.sound) {
            audio = new Audio("../images/bell.mp3");
            audio.play();
          }
          $scope.stop();
        }
        if (!$scope.$$phase) {
          return $scope.$digest();
        }
      }, countdown.HOURS | countdown.MINUTES | countdown.SECONDS);
    };
    $scope.pause = function() {
      $scope.running = false;
      if ($scope.timerId != null) {
        clearInterval($scope.timerId);
      }
      return $scope.paused = true;
    };
    $scope.stop = function() {
      $scope.running = false;
      $scope.paused = false;
      if ($scope.timerId != null) {
        clearInterval($scope.timerId);
      }
      $scope.hours = $scope.initialHours;
      $scope.minutes = $scope.initialMinutes;
      $scope.seconds = $scope.initialSeconds;
      return document.title = "timer";
    };
    $scope.restart = function() {
      $scope.stop();
      return $scope.start();
    };
    return $scope.snooze = function() {
      if ($scope.running) {
        $scope.pause();
        $scope.minutes = $scope.minutes + 5;
        return $scope.start();
      } else if ($scope.paused) {
        return $scope.minutes = $scope.minutes + 5;
      } else {
        $scope.start();
        $scope.pause();
        $scope.hours = 0;
        $scope.minutes = 5;
        $scope.seconds = 0;
        return $scope.start();
      }
    };
  }
]);

timer.directive('ngEnter', function() {
  return function(scope, element, attrs) {
    return element.bind('keydown keypress', function(event) {
      if (event.which === 13) {
        scope.$apply(function() {
          return scope.$eval(attrs.ngEnter, {
            'event': event
          });
        });
        return event.preventDefault();
      }
    });
  };
});
