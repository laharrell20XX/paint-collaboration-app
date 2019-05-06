    if document.getElementById("canvas")
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
              this.syncCanvas(this.getCanvasData())
          else 
            drawLineSeg(data['drawnPoints'], data['tool'])

        stroke: (drawnPoints, tool) ->
          this.EligibleToSync = true
          @perform 'stroke', drawnPoints: drawnPoints, tool: tool
        
        syncCanvas: (canvasData) ->
          @perform 'sync_with_initial', canvas_data: canvasData