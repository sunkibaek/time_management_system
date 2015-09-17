'user strict'

@app.controller 'AdminTasksCtrl', ($http) ->
  @collection =
    all: []

  @update = ->
    $http.get 'api/v1/admin/tasks'
      .then (response) =>
        @collection.all = response.data.tasks

  @update()

  return this
