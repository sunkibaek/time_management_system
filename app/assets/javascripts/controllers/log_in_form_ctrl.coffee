'use strict'

@app.controller 'LogInFormCtrl', ($http, notification, user) ->
  @input = {}

  @submit = ($event) ->
    $event.preventDefault()
    data = { session: { email: @input.email, password: @input.password } }

    $http.post '/api/v1/session', data
    .then (response) ->
      user.update
      notification.updateMessage response.data.notice
    , (response) ->
      notification.updateMessage response.data.notice

  return this
