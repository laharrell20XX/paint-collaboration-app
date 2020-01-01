    if document.getElementById("canvas")
      console.log("channel logic created")
      canvasPage = document.getElementById("canvas-room")
      canvas = document.getElementById("canvas")
      App.canvas = App.cable.subscriptions.create {channel:"CanvasChannel", canvas_name: document.getElementById("canvas-name").innerText},

        getCanvasData: ->
          canvasCtx = canvas.getContext("2d")
          imageData = canvasCtx.getImageData(0, 0, canvas.width, canvas.height)
          canvasDataArr = Array.from(imageData.data)
          return canvasDataArr

        connected: ->
          # this.getCanvasData()
          # @perform 'get_subscriptions'
          this.EligibleToSync = false

        disconnected: ->  

        received: (data) ->
          if data['request_to_sync']
            if this.EligibleToSync
              # this.showLoadScreen()
              this.syncCanvas(this.getCanvasData())
          else 
            draw(data['drawnPoints'], data['tool'])
            console.log("data received")

        stroke: (drawnPoints, tool) ->
          this.EligibleToSync = true
          @perform 'stroke', drawnPoints: drawnPoints, tool: tool

        completeDrawing: () ->
          @perform 'complete_drawing'
        
        syncCanvas: (canvasData) ->
          @perform 'sync_with_initial', canvas_data: canvasData

        