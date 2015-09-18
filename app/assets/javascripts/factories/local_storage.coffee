'use strict'

@app.factory 'localStorage', ($window) ->
  this.load = (item) ->
    $window.localStorage.getItem(item)

  this.save = (item, string) ->
    $window.localStorage.setItem(item, string)
    return string

  this.remove = (item) ->
    $window.localStorage.removeItem(item)

  return this
