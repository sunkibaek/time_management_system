'use strict'

@app.factory 'headerConfig', (authToken) ->
  @config =
    Authorization: 'Custom'

  @update = ->
    if authToken.token()
      @config =
        Authorization: 'Token ' + authToken.token()

  @update()

  return this
