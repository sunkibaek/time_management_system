'use strict'

@app.controller 'LogInCtrl', ($http, $location, notification, user, tasks) ->
  @input = {}

  @submit = ($event) ->
    $event.preventDefault()
    data = { session: { email: @input.email, password: @input.password } }

    $http.post '/api/v1/session', data
    .then (response) ->
      user.update()
      tasks.update()
      $location.path('/tasks').replace()
      notification.updateMessage response.data.notice
    , (response) ->
      notification.updateMessage response.data.notice

  return this
