App.canvas = App.cable.subscriptions.create "CanvasChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    drawLineSeg(data['drawnPoints'], data['tool'])

  stroke: (drawnPoints, tool) ->
    @perform 'stroke', drawnPoints: drawnPoints, tool: tool
