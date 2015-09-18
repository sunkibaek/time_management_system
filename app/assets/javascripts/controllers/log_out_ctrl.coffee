'user strict'

@app.controller 'LogOutCtrl',
  ($location, notification, user, tasks, authToken) ->
    @logOut = ->
      authToken.removeToken()
      user.initialize()
      tasks.initialize()
      $location.path('/').replace()
      notification.updateMessage 'Successfully logged out.'

    return this
