App.canvas = App.cable.subscriptions.create {channel:"CanvasChannel", canvas_name: document.getElementById("canvas-name").innerText},
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    drawLineSeg(data['drawnPoints'], data['tool'])

  stroke: (drawnPoints, tool) ->
    @perform 'stroke', drawnPoints: drawnPoints, tool: tool
