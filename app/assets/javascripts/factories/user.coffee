'use strict'

@app.factory 'user', ($http, headerConfig) ->
  @initialize = ->
    @name = ''
    @isLoggedIn = false
    @preferredWorkingHour = 0
    @isUserManager = false
    @isAdmin = false

  @update = ->
    $http headers: headerConfig.config, method: 'GET', url: '/api/v1/current_user'
      .then (response) =>
        @name = response.data.name
        @preferredWorkingHour = response.data.preferred_working_hour
        @isUserManager = response.data['user_manager?']
        @isAdmin = response.data['admin?']
        @isLoggedIn = @name? ? true : false
      , (response) =>
        @initialize()

  @update()

  return this
