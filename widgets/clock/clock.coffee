class Dashing.Clock extends Dashing.Widget

  ready: ->
    setInterval(@startTime, 500)

  startTime: =>
    today = new Date()

    h = today.getHours()
    m = today.getMinutes()
    s = today.getSeconds()
    t = @getT(h)
    h = @formatHour(h)
    m = @formatTime(m)
    s = @formatTime(s)
    @set('time', h + ":" + m + ":" + s + " "+t)
    @set('date', today.toDateString())

  getT: (h) ->
    if h < 12 then "AM" else "PM"

  formatTime: (i) ->
    if i < 10 then "0" + i else i

  formatHour: (h) ->
    h = ((h + 11) % 12 + 1);
    if h < 10 then "0" + h else h