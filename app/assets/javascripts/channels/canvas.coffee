App.canvas = App.cable.subscriptions.create "CanvasChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (canvasState) ->
    canvasDataArrReceived = Uint8ClampedArray.from(canvasState['canvasState'])
    curCanvas = document.getElementById("canvas")
    
    canvasDataAsImageData = new ImageData(canvasDataArrReceived, curCanvas.width)
    
    curCanvas.getContext('2d').putImageData(canvasDataAsImageData, 0, 0)

  stroke: (canvasState) ->
    @perform 'stroke', canvasState: canvasState
