App.canvas = App.cable.subscriptions.create "CanvasChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    message = "<p>#{data['message']}</p>"
    document.getElementById("canvas").insertAdjacentHTML("afterbegin", message)
    # Called when there's incoming data on the websocket for this channel

  speak: (message) ->
    @perform 'speak', message: message
