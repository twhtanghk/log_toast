var extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
  hasProp = {}.hasOwnProperty;

require('angularjs-toaster');

angular.module('logToast', ['toaster', 'ngAnimate']).config(function($provide) {
  return $provide.decorator('$log', function($delegate, $injector) {
    var Log, Toast;
    Log = (function() {
      function Log() {}

      Log.prototype.log = $delegate.log;

      Log.prototype.info = $delegate.info;

      Log.prototype.warn = $delegate.warn;

      Log.prototype.error = $delegate.error;

      Log.prototype.debug = $delegate.debug;

      return Log;

    })();
    Toast = (function(superClass) {
      var instance;

      extend(Toast, superClass);

      function Toast() {
        return Toast.__super__.constructor.apply(this, arguments);
      }

      instance = null;

      Toast.toaster = function() {
        return instance != null ? instance : instance = $injector.get('toaster');
      };

      Toast.prototype.log = function(msg) {
        Toast.__super__.log.call(this, msg);
        return Toast.toaster().pop({
          body: msg
        });
      };

      Toast.prototype.info = function(msg) {
        Toast.__super__.info.call(this, msg);
        return Toast.toaster().pop({
          type: 'info',
          body: msg
        });
      };

      Toast.prototype.warn = function(msg) {
        Toast.__super__.warn.call(this, msg);
        return Toast.toaster().pop({
          type: 'warning',
          body: msg
        });
      };

      Toast.prototype.error = function(msg) {
        Toast.__super__.error.call(this, msg);
        return Toast.toaster().pop({
          type: 'error',
          body: msg
        });
      };

      return Toast;

    })(Log);
    return new Toast();
  });
});
