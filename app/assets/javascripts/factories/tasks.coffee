'use strict'

@app.factory 'tasks', ($http, user) ->
  @all = []

  @add = (task) ->
    # @all.unshift task
    @update()

  @update = ->
    $http.get '/api/v1/tasks'
    .then (response) =>
      @all = response.data.tasks
      @all.map (task) ->
        if task.total_hour > user.preferred_working_hour
          task.css_class = 'danger'
        else
          task.css_class = 'success'

  @update()

  return this
