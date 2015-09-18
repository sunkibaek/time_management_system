'use strict'

@app.controller 'TaskFormCtrl', ($http, notification, tasks, headerConfig) ->
  @input = {}

  @submit = ($event) ->
    $event.preventDefault()
    data =
      task:
        description: @input.description
        date: @input.date
        hour: @input.hour

    $http headers: headerConfig.config, method: 'POST', url: '/api/v1/tasks', data: data
      .then (response) =>
        tasks.add @input
        @input = {}
        notification.updateMessage response.data.notice
      , (response) ->
        notification.updateMessage response.data.notice

  return this
