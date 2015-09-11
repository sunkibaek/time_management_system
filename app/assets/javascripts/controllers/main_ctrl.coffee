'use strict'

@app.controller 'MainCtrl', (notification, user) ->
  @showSignUpForm = false
  @notification = notification
  @user = user

  return this
