'use strict'

@app.controller 'TasksCtrl', (tasks, $location) ->
  dateTexts = ['Date &uarr;', 'Date &darr;']
  dateOrders = ['-date', 'date']

  @input = {}
  @collection = tasks
  @dateText = dateTexts[0]
  @dateOrder = dateOrders[0]

  @orderToggle = ->
    dateTexts.unshift dateTexts.pop()
    dateOrders.unshift dateOrders.pop()
    @dateText = dateTexts[0]
    @dateOrder = dateOrders[0]

  @export = ->
    url = "/tasks/export/" + @input.from.replace(/\//g, '-') +
      '/' + @input.to.replace(/\//g, '-')
    $location.path(decodeURIComponent(url)).replace()

  return this
