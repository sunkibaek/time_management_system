'use strict'

@app.factory 'tasks', ($http, user) ->
  @all = []

  @update = ->
    $http.get '/api/v1/tasks'
    .then (response) =>
      @all = response.data.tasks
      @all.map (task) ->
        if task.total_hour >= user.preferredWorkingHour
          task.css_class = 'success'
        else
          task.css_class = 'danger'

  @update()

  return this
