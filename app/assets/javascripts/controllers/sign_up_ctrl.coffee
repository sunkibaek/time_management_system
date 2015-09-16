'use strict'

@app.controller 'SignUpCtrl', ($http, $location, notification, user) ->
  @input = {}

  @submit = ($event) ->
    $event.preventDefault()
    data = { user: { name: @input.name, email: @input.email, password: @input.password } }

    $http.post '/api/v1/users', data
    .then (response) ->
      user.update()
      $location.path('/tasks').replace()
      notification.updateMessage response.data.notice
    , (response) ->
      notification.updateMessage response.data.notice
      console.log response

  return this
