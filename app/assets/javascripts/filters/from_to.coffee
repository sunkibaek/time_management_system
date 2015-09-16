'use strict'

@app.filter 'fromTo', ->
  isDate = (candidate) ->
    isNaN(Date.parse(candidate)) is false

  return (items, from, to) ->
    return items if !(isDate(from) && isDate(to))

    dateFrom = new Date from
    dateTo = new Date to

    result = []

    for item in items
      item_date = new Date item.date
      if dateFrom <= item_date && dateTo >= item_date
        result.push item

    return result
