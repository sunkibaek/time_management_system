'use strict'

@app.factory 'notification', ($timeout) ->
  @message = ''

  @updateMessage = (message) ->
    @message = message

    $timeout =>
      @message = ''
    , 4000

  return this
