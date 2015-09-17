'use strict'

@app.controller 'TasksEditCtrl',
  ($http, $location, $routeParams, $window, user, notification, tasks,
    dateFilter) ->
      @page_title = 'Edit a Task'
      @showDeleteBtn = true
      @input = {}

      if user.isAdmin
        urlBase = '/api/v1/admin/tasks/'
        redirectToUrl = '/admin/tasks'
      else
        urlBase = '/api/v1/tasks/'
        redirectToUrl = '/tasks'

      @update = ->
        $http.get urlBase + $routeParams.taskId
          .then (response) =>
            @input.description = response.data.description
            @input.hour = response.data.hour
            @input.date = dateFilter(new Date(response.data.date), 'MM/dd/yyyy')

      @delete = ($event) ->
        $event.preventDefault()
        if $window.confirm('Are you sure?')
          url = urlBase + $routeParams.taskId
          $http.delete url
            .then (response) =>
              tasks.update()
              @input = {}
              notification.updateMessage response.data.notice
              $location.path(redirectToUrl).replace()
            , (response) ->
              notification.updateMessage response.data.notice

      @submit = ($event) ->
        $event.preventDefault()
        data =
          task:
            description: @input.description
            date: @input.date
            hour: @input.hour

        url = urlBase + $routeParams.taskId

        $http.patch url, data
          .then (response) =>
            tasks.update()
            @input = {}
            notification.updateMessage response.data.notice
            $location.path(redirectToUrl).replace()
          , (response) ->
            notification.updateMessage response.data.notice

      @update()

      return this
