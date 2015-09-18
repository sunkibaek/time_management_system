'use strict'

@app.factory 'tasks', ($http, user, authToken, headerConfig) ->
  @initialize = ->
    @all = []

  @update = ->
    $http headers: headerConfig.config, method: 'GET', url: '/api/v1/tasks'
      .then (response) =>
        @all = response.data.tasks
        @all.map (task) ->
          if task.total_hour > user.preferredWorkingHour
            task.css_class = 'danger'
          else
            task.css_class = 'success'
      , (response) =>
        @initialize()

  @update()

  return this
