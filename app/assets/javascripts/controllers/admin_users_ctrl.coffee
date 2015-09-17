'user strict'

@app.controller 'AdminUsersCtrl', ($http, $location, notification, user) ->
  if !user.isUserManager
    $location.path('/').replace()
    notification.updateMessage 'Unauthorized access is prohibited.'

  @all = []

  @update = ->
    $http.get '/api/v1/admin/users'
      .then (response) =>
        notification.updateMessage response.data.notice
        @all = response.data
      , (response) ->
        notification.updateMessage response.data.notice

  @submit = (user) ->
    data =
      user:
        preferred_working_hour: user.preferred_working_hour

    $http.patch 'api/v1/admin/users/' + user.id, data
      .then (response) =>
        @update()
        notification.updateMessage response.data.notice
      , (response) ->
        notification.updateMessage response.data.notice

  @update()

  return this
