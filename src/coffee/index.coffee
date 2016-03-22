window.jQuery = window.$ = require 'jquery'
window.Vue = require 'vue'

new Vue
  el: '#stopwatch'
  data:
    startTime: null
    timerId: null
    elapsedTime: null
    isRunning: false
    text: '0.00'
  methods:
    start: ->
      return if @isRunning is true
      @isRunning = true
      @startTime = Date.now()
      @updateTimeText()
    stop: ->
      return if @isRunning is false
      @isRunning = false
      @elapsedTime += Date.now() - @startTime
      clearTimeout(@timerId)
    reset: ->
      return if @isRunning is true
      @text = '0.00'
      @elapsedTime = 0
    updateTimeText: ->
      @timerId = setTimeout =>
        t = Date.now() - @startTime + @elapsedTime
        @text = (t/1000).toFixed(2)
        @updateTimeText()
      , 10
