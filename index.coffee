require 'angular-toastr'

angular
  .module 'logToast', [
    'toastr'
    'ngAnimate'
  ]
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
          instance ?= $injector.get 'toastr'

        show: (type, msg) ->
          mapping =
            log: 'success'
            info: 'info'
            warn: 'warning'
            error: 'error'
          type = mapping[type] || 'error'
          Toast.toaster()[type](msg?.toString())
        log: (msg) =>
          super msg
          @show 'log', msg
        info: (msg) =>
          super msg
          @show 'info', msg
        warn: (msg) =>
          super msg
          @show 'warn', msg
        error: (msg) =>
          super msg
          @show 'error', msg

      new Toast()
