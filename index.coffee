require 'angularjs-toaster/toaster'

angular
  .module 'logToast', ['toaster', 'ngAnimate']
  .config ($provide) ->
    $provide.decorator '$log', ($delegate, $injector) ->
      class Log
        log: $delegate.log
        info: $delegate.info
        warn: $delegate.warn
        error: $delegate.error
        debug: $delegate.debug

      class Toast extends Log
        instance = null

        @toaster: ->
          instance ?= $injector.get 'toaster'

        log: (msg) ->
          super msg
          Toast.toaster().pop 
            body: msg
        info: (msg) ->
          super msg
          Toast.toaster().pop 
            type: 'info'
            body: msg
        warn: (msg) ->
          super msg
          Toast.toaster().pop 
            type: 'warning'
            body: msg
        error: (msg) ->
          super msg
          Toast.toaster().pop 
            type: 'error'
            body: msg

      new Toast()
