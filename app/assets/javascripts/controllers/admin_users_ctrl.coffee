'user strict'

@app.controller 'AdminUsersCtrl', ($http, $location, notification, user) ->
  if !user.isUserManager
    $location.path('/').replace()
    notification.updateMessage 'Unauthorized access is prohibited.'

  @all = []

  $http.get '/api/v1/admin/users'
    .then (response) =>
      @all = response.data
      notification.updateMessage response.data.notice
    , (response) ->
      notification.updateMessage response.data.notice

  return this
