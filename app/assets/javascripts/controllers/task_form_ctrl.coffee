'use strict'

@app.controller 'TaskFormCtrl', ($http, notification, tasks) ->
  @input = {}

  @submit = ($event) ->
    $event.preventDefault()
    data =
      task:
        description: @input.description
        date: @input.date
        hour: @input.hour

    $http.post '/api/v1/tasks', data
    .then (response) =>
      tasks.add @input
      @input = {}
      notification.updateMessage response.data.notice
    , (response) ->
      notification.updateMessage response.data.notice

  return this
