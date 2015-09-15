'use strict'

@app.controller 'SettingsCtrl', (user) ->
  @input = {}

  @submit = ($event) ->
    $event.preventDefault()
    console.log $event

  @input.preferredWorkingHour = user.preferredWorkingHour
  console.log @input.preferredWorkingHour

  return this
