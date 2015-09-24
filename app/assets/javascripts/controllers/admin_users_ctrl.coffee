'user strict'

@app.controller 'AdminUsersCtrl', ($http, $location, notification, user, headerConfig) ->
  if !user.isUserManager
    $location.path('/').replace()
    notification.updateMessage 'Unauthorized access is prohibited.'
    return

  @all = []

  @update = ->
    $http headers: headerConfig.config, method: 'GET', url: '/api/v1/admin/users'
      .then (response) =>
        @all = response.data
      , (response) ->
        notification.updateMessage response.data.notice

  @submit = (user) ->
    data =
      user:
        preferred_working_hour: user.preferred_working_hour

    $http headers: headerConfig.config, method: 'PUT', url: '/api/v1/admin/users/' + user.id, data: data
      .then (response) =>
        @update()
        notification.updateMessage response.data.notice
      , (response) ->
        notification.updateMessage response.data.notice

  @promoteTo = ($event, user_id, role) ->
    $event.preventDefault()
    $http headers: headerConfig.config, method: 'PUT', url: '/api/v1/admin/users/' + user_id, data: { promote_to: role }
      .then (response) =>
        @update()
        notification.updateMessage response.data.notice
      , (response) ->
        notification.updateMessage response.data.notice

  @update()

  return this
