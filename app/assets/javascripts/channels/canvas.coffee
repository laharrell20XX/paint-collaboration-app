

    if document.getElementById("canvas")
      App.canvas = App.cable.subscriptions.create {channel:"CanvasChannel", canvas_name: document.getElementById("canvas-name").innerText},
        connected: ->

        disconnected: ->  

        received: (data) ->
          drawLineSeg(data['drawnPoints'], data['tool'])

        stroke: (drawnPoints, tool) ->
          @perform 'stroke', drawnPoints: drawnPoints, tool: tool
        
