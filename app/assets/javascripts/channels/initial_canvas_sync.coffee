if document.getElementById("canvas")
    canvasPage = document.getElementById("canvas-room")
    canvasName = document.getElementById("canvas-name").innerText
    App.initial_canvas_sync = App.cable.subscriptions.create "InitialCanvasSyncChannel",

      connected: ->
        # this.sendSyncRequest()

      disconnected: ->
        console.log("disconnected")

      received: (data) ->
        # encoder = new TextEncoder()
        # encodedCanvasData = encoder.encode(data['canvas_data'])
        # if data['show_canvas']
        #   this.showCanvas()
        # else
        encodedCanvasData = Uint8ClampedArray.from(data['canvas_data'])
        this.setCanvas(encodedCanvasData)
        @perform 'close_channel'
    
      sendSyncRequest: ->
        # this.showLoadScreen()
        @perform 'send_sync_request', request_to_sync: true, canvas_name: canvasName

      setCanvas: (incomingCanvasData) ->
        canvas = document.getElementById("canvas")
        canvasCtx = canvas.getContext("2d")
        curCanvasImageData = canvasCtx.getImageData(0, 0, canvas.width, canvas.height)
        # curCanvasImageData.data.set(incomingCanvasData)
        incomingImageData = new ImageData(incomingCanvasData, canvas.width, canvas.height)
        canvasCtx.putImageData(incomingImageData, 0, 0)

      showLoadScreen: ->
          canvasPage.style.display = "none"
          document.getElementById("load-screen").removeAttribute("hidden")

        showCanvas: ->
          document.getElementById("load-screen").setAttribute("hidden", "")
          canvasPage.style.display = "block"
