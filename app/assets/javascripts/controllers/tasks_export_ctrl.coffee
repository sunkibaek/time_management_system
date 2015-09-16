'use strict'

@app.controller 'TasksExportCtrl', ($routeParams, tasks, fromToFilter) ->
  @from = new Date($routeParams.from)
  @to = new Date($routeParams.to)
  @tasks = fromToFilter(tasks.all, $routeParams.from, $routeParams.to)
  @grandTotalHour = 0

  @tasks.map (task) =>
    @grandTotalHour += task.hour

  return this
