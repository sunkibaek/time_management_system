'user strict'

@app.controller 'LogOutCtrl', ($http, notification, user) ->
  @logOut = ->
    $http.delete '/api/v1/session'
    .then (response) ->
      user.update()
      notification.updateMessage response.data.notice
    , (response) ->
      user.update()
      notification.updateMessage response.data.notice

  return this
