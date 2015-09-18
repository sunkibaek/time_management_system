'use strict'

@app.factory 'authToken', (localStorage) ->
  this.token = ->
    localStorage.load 'authToken'

  this.saveToken = (token) ->
    localStorage.save 'authToken', token

  this.removeToken = ->
    localStorage.remove 'authToken'

  return this
