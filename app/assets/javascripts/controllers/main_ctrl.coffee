'use strict'

@app.controller 'MainCtrl', ($location, $rootScope, notification, user) ->
  @showSignUpForm = false
  @notification = notification
  @user = user
  @currentPath = ''

  updateCurrentPath = =>
    $rootScope.$on '$routeChangeSuccess', =>
      @currentPath = $location.path()
      @user = user

  updateCurrentPath()

  return this
