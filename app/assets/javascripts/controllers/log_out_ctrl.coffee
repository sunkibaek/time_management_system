'user strict'

@app.controller 'LogOutCtrl', ($http, $location, notification, user) ->
  @logOut = ->
    $http.delete '/api/v1/session'
    .then (response) ->
      user.update()
      notification.updateMessage response.data.notice
      $location.path('/').replace()
    , (response) ->
      user.update()
      notification.updateMessage response.data.notice

  return this
