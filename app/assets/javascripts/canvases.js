// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/

(function () {
    if (document.querySelector("#canvas-room #canvas")) {
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
                    makeStroke(canvasObj["drawnPoints"], canvasObj["brush"])
                    canvasObj["drawnPoints"].shift();
                }
                canvasObj["drawnPoints"].push({ x: ev.offsetX, y: ev.offsetY });
            } else {
                canvasObj["drawnPoints"] = [];
            }
        })

        canvasObj["canvasElm"].addEventListener("mouseup", () => canvasObj["drawnPoints"] = [])

        canvasObj["canvasElm"].addEventListener("mouseleave", ev => {
            ev.preventDefault()
            canvasObj["drawnPoints"] = []
        })

        function calcOffsetX(touchX) {
            canvasClientRect = canvasObj['canvasElm'].getBoundingClientRect()
            return touchX - (canvasClientRect.x - 1)
        }
        function calcOffsetY(touchY) {
            canvasClientRect = canvasObj['canvasElm'].getBoundingClientRect()
            return touchY - (canvasClientRect.y - 1)
        }

        canvasObj["canvasElm"].addEventListener("touchmove", ev => {
            ev.preventDefault()
            tOffsetX = calcOffsetX(ev.touches[0].pageX)
            tOffsetY = calcOffsetY(ev.touches[0].pageY)
            if (canvasObj["drawnPoints"].length === 2) {
                drawLineSeg(canvasObj["drawnPoints"], canvasObj["brush"]);
                makeStroke(canvasObj["drawnPoints"], canvasObj["brush"]);
                canvasObj["drawnPoints"].shift();
            }
            canvasObj["drawnPoints"].push({ x: tOffsetX, y: tOffsetY });
        })

        canvas.addEventListener("touchend", () => {
            canvasObj["drawnPoints"] = []
        })

        makeStroke = function (drawnPoints, tool) {
            App.canvas.stroke(drawnPoints, tool)
        }

        drawLineSeg = function (drawnPoints, tool) {
            var canvasCtx = canvasObj["canvasElm"].getContext("2d");
            canvasCtx.lineWidth = tool.width;
            canvasCtx.lineCap = "round";
            canvasCtx.strokeStyle = tool["color"];
            var lastPoint = drawnPoints[0];
            var curPoint = drawnPoints[1];
            canvasCtx.beginPath();
            canvasCtx.moveTo(lastPoint.x, lastPoint.y);
            canvasCtx.lineTo(curPoint.x, curPoint.y);
            canvasCtx.stroke();
        }

    }
})()