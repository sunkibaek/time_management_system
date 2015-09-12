'use strict'

@app.controller 'SignUpFormCtrl', ($http, notification, user) ->
  @input = {}

  @submit = ($event) ->
    $event.preventDefault()
    data = { user: { name: @input.name, email: @input.email, password: @input.password } }

    $http.post '/api/v1/users', data
    .then (response) ->
      user.update()
      notification.updateMessage response.data.notice
    , (response) ->
      notification.updateMessage response.data.notice

  return this
