_ = require 'lodash'
require '../index.js'

angular
  .module 'controller', ['logToast']
  .controller 'LogCtrl', ($scope, $log) ->
    _.extend $scope,
      $log: $log
      msg: "update message body here"
