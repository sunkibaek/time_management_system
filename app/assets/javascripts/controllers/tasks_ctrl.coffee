'use strict'

@app.controller 'TasksCtrl', (tasks) ->
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

  return this
