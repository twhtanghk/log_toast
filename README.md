# log_toast
Show angular $log as Toaster

## Installation
```
npm install log_toast
```

## Configuration
1. html [see test/index.html](https://github.com/twhtanghk/log_toast/blob/master/test/index.html)

2. css [see test/index.css](https://github.com/twhtanghk/log_toast/blob/master/test/index.css)

3. angular module
```
require 'log_toast'

angular
  .module 'app', ['logToast', ...]
  .config
  .controller 'ctrl', ($log, ...)
    model
      .$save()
      .catch $log.error
```
