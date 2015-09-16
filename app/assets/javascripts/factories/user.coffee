'use strict'

@app.factory 'user', ($http) ->
  @name = ''
  @isLoggedIn = false

  @update = ->
    $http.get '/api/v1/users/me'
    .then (response) =>
      @name = response.data.name
      @preferredWorkingHour = response.data.preferred_working_hour
      @isUserManager = response.data['user_manager?']
      @isLoggedIn = @name? ? true : false

  @update()

  return this
