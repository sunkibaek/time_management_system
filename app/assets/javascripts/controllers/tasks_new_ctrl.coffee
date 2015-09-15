'use strict'

@app.controller 'TasksNewCtrl', ($http, $location, notification, tasks) ->
  @page_title = 'Add a Task'
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
      $location.path('/tasks').replace()
    , (response) ->
      notification.updateMessage response.data.notice

  return this
