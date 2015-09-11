'use strict'

@app.factory 'user', ($http) ->
  @name = ''
  @isLoggedIn = false

  @update = ->
    $http.get '/api/v1/users/me'
    .then (response) =>
      @name = response.data.name
      @isLoggedIn = true if @name

  @update()

  return this
