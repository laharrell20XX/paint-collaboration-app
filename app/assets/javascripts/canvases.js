// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/

// (function () {
console.log("canvas logic created")
if (document.querySelector("#canvas-room #canvas")) {
    var canvasObj = {
        "canvasElm": document.getElementById('canvas'),
        "brush": {
            "color": "black",
            "width": 5.0
        },
        "drawings": [],
        "curDrawing": {},
        "curLinePoints": []
    }
    var colorChangerButtons = document.querySelectorAll("#color-changer .color-btn");
    var toolStatusDisplayer = document.querySelector("#brush-display");
    var toolColorDisplayer = toolStatusDisplayer.querySelector("#brush-color");
    colorChangerButtons.forEach(button =>
        button.addEventListener("click", () => {
            canvasObj["brush"].color = button.getAttribute("value");
            toolColorDisplayer.style.backgroundColor = canvasObj["brush"].color;
        })
    );

    (function buildCanvasEvents() {
        canvasObj["canvasElm"].addEventListener("mousemove", ev => {
            curPoint = { x: ev.offsetX, y: ev.offsetY }
            if (ev.buttons == 1) {
                if (canvasObj["curLinePoints"].length === 2) {
                    draw(canvasObj["curLinePoints"], canvasObj["brush"]);
                    makeStroke(canvasObj["curLinePoints"], canvasObj["brush"])
                    canvasObj["curDrawing"]["drawnPoints"].push(canvasObj["curLinePoints"][0], curPoint)
                    canvasObj["curLinePoints"].shift();
                }
                canvasObj["curLinePoints"].push(curPoint);
            } else {
                canvasObj["curLinePoints"] = [];
            }
        })

        canvasObj["canvasElm"].addEventListener("mouseup", () => {
            canvasObj.drawings.push(canvasObj["curDrawing"]);
            canvasObj["curDrawing"] = []
            canvasObj["curLinePoints"] = []
            completeDrawing()
        })

        canvasObj["canvasElm"].addEventListener("mouseleave", ev => {
            ev.preventDefault()
            drawingPoints = []
            linePoints = []
        })

        canvasObj["canvasElm"].addEventListener("mousedown", ev => {
            canvasObj["curDrawing"]["drawnPoints"] = []
            canvasObj["curDrawing"]["brush"] = canvasObj["brush"]
            canvasObj["curDrawing"]["drawnPoints"].push({ x: ev.offsetX, y: ev.offsetY })
            canvasObj["curLinePoints"].push({ x: ev.offsetX, y: ev.offsetY })
            draw(canvasObj["curLinePoints"], canvasObj["brush"])
            makeStroke(canvasObj["curLinePoints"], canvasObj["brush"])
        })

        canvasObj["canvasElm"].addEventListener("touchmove", ev => {
            ev.preventDefault()
            tOffsetX = calcOffsetX(ev.touches[0].pageX)
            tOffsetY = calcOffsetY(ev.touches[0].pageY)
            if (linePoints.length === 2) {
                drawLineSeg(linePoints, canvasObj["brush"]);
                makeStroke(linePoints, canvasObj["brush"]);
                linePoints.shift();
            }
            linePoints.push({ x: tOffsetX, y: tOffsetY });
        })

        canvas.addEventListener("touchend", () => {
            linePoints = []
        })

    })()

    function copyCanvas(drawings) {

    }

    function calcOffsetX(touchX) {
        canvasClientRect = canvasObj['canvasElm'].getBoundingClientRect()
        return touchX - (canvasClientRect.x - 1)
    }
    function calcOffsetY(touchY) {
        canvasClientRect = canvasObj['canvasElm'].getBoundingClientRect()
        return touchY - (canvasClientRect.y - 1)
    }


    function makeStroke(drawnPoints, tool) {
        App.canvas.stroke(drawnPoints, tool)
    }

    function completeDrawing() {
        App.canvas.completeDrawing()
    }

    function draw(linePoints, tool) {
        var canvasCtx = canvasObj["canvasElm"].getContext("2d");
        canvasCtx.lineWidth = tool.width;
        canvasCtx.lineCap = "round";
        canvasCtx.strokeStyle = tool["color"];
        if (linePoints.length == 2) {
            drawLineSeg(canvasCtx, linePoints, tool)
            // console.log(linePoints)
        }
        if (linePoints.length == 1) {
            drawPoint(canvasCtx, linePoints[0], tool)
        }
    }

    function drawLineSeg(canvasCtx, drawnPoints, tool) {
        var lastPoint = drawnPoints[0];
        var curPoint = drawnPoints[1];
        canvasCtx.beginPath();
        canvasCtx.moveTo(lastPoint.x, lastPoint.y);
        canvasCtx.lineTo(curPoint.x, curPoint.y);
        canvasCtx.stroke();
    }

    function drawPoint(canvasCtx, drawnPoint, tool) {
        canvasCtx.beginPath();
        canvasCtx.moveTo(drawnPoint.x, drawnPoint.y);
        canvasCtx.lineTo(drawnPoint.x, drawnPoint.y);
        canvasCtx.stroke();
    }

}
// })()