'use strict'

@app.controller 'SignUpCtrl', ($http, $location, notification, user, tasks, authToken, headerConfig) ->
  @input = {}

  @submit = ($event) ->
    $event.preventDefault()
    data = { user: { name: @input.name, email: @input.email, password: @input.password } }

    $http method: 'POST', url: '/api/v1/users', data: data
      .then (response) ->
        authToken.saveToken response.data.auth_token
        headerConfig.update()
        user.update()
        tasks.update()
        $location.path('/tasks').replace()
        notification.updateMessage response.data.notice
      , (response) ->
        notification.updateMessage response.data.notice
        console.log response

  return this
