'use strict'

@app.controller 'SettingsCtrl', ($http, user) ->
  @input = {}

  @submit = ($event) ->
    $event.preventDefault()
    data =
      user:
        preferred_working_hour: @input.preferredWorkingHour

    $http.patch 'api/v1/users/0', data
      .then (response) ->
        user.update()
        $location.path('/tasks').replace()
        notification.updateMessage response.data.notice
      , (response) ->
        notification.updateMessage response.data.notice

  @input.preferredWorkingHour = user.preferredWorkingHour

  return this
