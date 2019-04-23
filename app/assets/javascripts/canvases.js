// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/

app = function () {
    var canvasObj = {
        "canvasElm": document.getElementById('canvas'),
        "brush": {
            "color": "black",
            "width": 5.0
        },
        "drawnPoints": []
    }

    canvasObj["canvasElm"].addEventListener("mousemove", ev => {
        if (ev.buttons == 1) {
            if (canvasObj["drawnPoints"].length === 2) {
                // console.log(drawnPoints);
                drawLineSeg(canvasObj["drawnPoints"], canvasObj["brush"]);
                makeStroke(canvasObj["canvasElm"])
                canvasObj["drawnPoints"].shift();
            }
            canvasObj["drawnPoints"].push({ x: ev.offsetX, y: ev.offsetY });
        } else {
            canvasObj["drawnPoints"] = [];
        }
    })

    makeStroke = function (canvas) {
        var canvasCtx = canvas.getContext("2d");
        var canvasState = canvasCtx.getImageData(0, 0, canvas.width, canvas.height)
    }

    drawLineSeg = function (drawnPoints, tool) {
        var canvasCtx = canvas.getContext("2d");
        canvasCtx.lineWidth = tool["width"];
        canvasCtx.lineCap = "round";
        canvasCtx.strokeStyle = tool["color"];
        var lastPoint = drawnPoints[0];
        var curPoint = drawnPoints[1];
        canvasCtx.beginPath();
        canvasCtx.moveTo(lastPoint.x, lastPoint.y);
        canvasCtx.lineTo(curPoint.x, curPoint.y);
        canvasCtx.stroke();
    }

}()