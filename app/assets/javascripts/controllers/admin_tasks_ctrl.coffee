'user strict'

@app.controller 'AdminTasksCtrl',
  ($http, $location, headerConfig, user, notification) ->
    if !user.isAdmin
      $location.path('/').replace()
      notification.updateMessage 'Unauthorized access is prohibited.'
      return

    @collection =
      all: []

    @update = ->
      $http headers: headerConfig.config, method: 'GET', url: 'api/v1/admin/tasks'
        .then (response) =>
          @collection.all = response.data.tasks

    @update()

    return this
