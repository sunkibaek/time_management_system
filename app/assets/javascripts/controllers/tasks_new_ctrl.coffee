'use strict'

@app.controller 'TasksNewCtrl', ($http, $location, notification, tasks, headerConfig) ->
  @page_title = 'Add a Task'
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
        tasks.update()
        @input = {}
        notification.updateMessage response.data.notice
        $location.path('/tasks').replace()
      , (response) ->
        notification.updateMessage response.data.notice

  return this
