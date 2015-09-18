'use strict'

@app.factory 'notification', ($timeout) ->
  @message = ''

  @updateMessage = (message) ->
    @message = message

    $timeout =>
      @message = ''
    , 2000

  return this
