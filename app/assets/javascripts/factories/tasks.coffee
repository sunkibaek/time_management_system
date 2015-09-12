'use strict'

@app.factory 'tasks', ($http) ->
  @all = []

  @add = (task) ->
    @all.unshift task

  @update = ->
    $http.get '/api/v1/tasks'
    .then (response) =>
      @all = response.data.tasks

  @update()

  return this
