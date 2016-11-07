<%@ page language="java" contentType="text/html; charset=utf-8"
   pageEncoding="utf-8"%>
<!DOCTYPE HTML>
<html>

<head>
<style>
html, body {
   width: 100%;
   height: 100%;
}

#sketch {
   border: 5px solid gray;
   height: 70%;
   width: 70%;
   position: relative;
}

.info {
   position: absolute;
}

#tmp_canvas {
   position: absolute;
   left: 0px;
   right: 0;
   bottom: 0;
   top: 0;
   cursor: crosshair;
}

#text_tool {
   position: absolute;
   border: 1px dashed black;
   outline: 0;
   display: none;
   font: 10px Verdana;
   overflow: hidden;
   white-space: nowrap;
}
</style>

</head>

<body>
   <div id="sketch">
      <canvas id="myCanvas"></canvas>
   </div>
   <script>
         var canvas = document.querySelector('#myCanvas');
         var context = canvas.getContext('2d');
		 var drag= false;
         var textarea = null;
         var canvasValid = true;
         var INTERVAL = 20;
		 var index;
         var sketch = document.querySelector('#sketch');
         var sketch_style = getComputedStyle(sketch);
         canvas.width = parseInt(sketch_style.getPropertyValue('width'));
         canvas.height = parseInt(sketch_style.getPropertyValue('height'));

         // Creating a tmp canvas
         var tmp_canvas = document.createElement('canvas');
         var tmp_ctx = tmp_canvas.getContext('2d');

         tmp_canvas.id = 'tmp_canvas';
         tmp_canvas.width = canvas.width;
         tmp_canvas.height = canvas.height;

         sketch.appendChild(tmp_canvas);
         setInterval(draw, INTERVAL);
         var fs;
         // holds all our rectangles
         var boxes = [];
         var mySel = null;

         var mouse = {
            x: 0,
            y: 0
         };
         var start_mouse = {
            x: 0,
            y: 0
         };
         var last_mouse = {
            x: 0,
            y: 0
         };

         var textarea1 = document.createElement('textarea');
         textarea1.id = 'text_tool';
         sketch.appendChild(textarea1);

         var tmp_txt_ctn = document.createElement('div');
         tmp_txt_ctn.style.display = 'none';
         sketch.appendChild(tmp_txt_ctn);

         textarea1.addEventListener('mouseup', function (e)
         {
            tmp_canvas.removeEventListener('mousemove', onPaint, false);

         }, false);

         /* Mouse Capturing Work */
         tmp_canvas.addEventListener('mousemove', function (e)
         {
            mouse.x = typeof e.offsetX !== 'undefined' ? e.offsetX : e.layerX;
            mouse.y = typeof e.offsetY !== 'undefined' ? e.offsetY : e.layerY;
			if(mySel!=null){
            if(drag==true){
            	 
            	  boxes[index-1].x = mouse.x;
            	  boxes[index-1].y = mouse.y;
            	   
            	  console.log("무브 boxes의 배열 번째"+index);
            	  invalidate();
            	}
			}
			
			 
            var message = 'Mouse position: ' + mouse.x + ',' + mouse.y;
            writeMessage(tmp_canvas, message);
         }, false);

       
         tmp_canvas.addEventListener('mousedown', function (e)
         {  drag = true;
            tmp_canvas.addEventListener('mousemove', onPaint, false);
			
            mouse.x = typeof e.offsetX !== 'undefined' ? e.offsetX : e.layerX;
            mouse.y = typeof e.offsetY !== 'undefined' ? e.offsetY : e.layerY;

            start_mouse.x = mouse.x;
            start_mouse.y = mouse.y;

            // mysel draw ready   
            var l = boxes.length;
            for (var i = l - 1; i >= 0; i--)
            {
               if (boxes[i].x < start_mouse.x && boxes[i].x + boxes[i].w > start_mouse.x && boxes[i].y < start_mouse.y && boxes[i].y + boxes[i].h >
                  start_mouse.y)
               {  
                  mySel = boxes[i];
                  index = i;
                  console.log("다운 boxes의 배열 번째"+index);
                  context.strokeStyle = '#FF0000';
                  invalidate();
                  return;
               } 
            } 
            mySel = null;
            invalidate();
         }, false);

         tmp_canvas.addEventListener('dblclick', function ()
         {
            tmp_canvas.removeEventListener('mousemove', onPaint, false);
            if (mySel != null)
            {
             // mysel draw ready   
                var l = boxes.length;
                for (var i = l - 1; i >= 0; i--)
                {
                   if (boxes[i].x < start_mouse.x && boxes[i].x + boxes[i].w > start_mouse.x && boxes[i].y < start_mouse.y && boxes[i].y + boxes[i].h >
                      start_mouse.y)
                   {
                      mySel = boxes[i];
                      textarea1.style.left = mySel.x + 'px';
                      textarea1.style.top = mySel.y + 'px';
                      textarea1.style.width = mySel.w + 'px';
                      textarea1.style.height = mySel.h + 'px';
                      textarea1.value = mySel.textarea1;
                      textarea1.style.display = 'block';
                      context.strokeStyle = '#00FF00';
                   }
                }
            }
         }, false);

         tmp_canvas.addEventListener('mouseup', function ()
         { 
            tmp_canvas.removeEventListener('mousemove', onPaint, false);
            drag = false;
            if(mySel==null){
            addRect(parseInt(textarea1.style.left),
               parseInt(textarea1.style.top),
               parseInt(textarea1.style.width),
               parseInt(textarea1.style.height), textarea1.value);
            console.log("textarea1 값: " + textarea1.value);
            }
            // Clearing tmp canvas
            tmp_ctx.clearRect(0, 0, tmp_canvas.width, tmp_canvas.height);

            // clearInterval(sprayIntervalID);
            textarea1.style.display = 'none';
            textarea1.value = '';
            invalidate();
            
         }, false);

         var onPaint = function ()
         {

            // Tmp canvas is always cleared up before drawing.
            tmp_ctx.clearRect(0, 0, tmp_canvas.width, tmp_canvas.height);
			if(mySel==null){
            var x = Math.min(mouse.x, start_mouse.x);
            var y = Math.min(mouse.y, start_mouse.y);
            var width = Math.abs(mouse.x - start_mouse.x);
            var height = Math.abs(mouse.y - start_mouse.y);

            textarea1.style.left = x + 'px';
            textarea1.style.top = y + 'px';
            textarea1.style.width = width + 'px';
            textarea1.style.height = height + 'px';

            textarea1.style.display = 'block';
			}

         };

         //Box object to hold data for all drawn rects
         function Box()
         {
            this.x = 0;
            this.y = 0;
            this.w = 1; // default width and height?
            this.h = 1;
            this.textarea = null;
            this.font = null;
            this.fill = '#444444';
         }

         //Initialize a new Box, add it, and invalidate the canvas
         function addRect(x, y, w, h, textarea1)
         {
            var rect = new Box;
            rect.x = x;
            rect.y = y;
            rect.w = w;
            rect.h = h;
            rect.textarea1 = textarea1;
            console.log(rect.textarea1);
            boxes.push(rect);
         }

         function writeMessage(tmp_canvas, message)
         {
            var context = tmp_canvas.getContext('2d');
            context.clearRect(0, 0, tmp_canvas.width, tmp_canvas.height);
            context.font = '18pt Calibri';
            context.fillStyle = 'black';
            context.fillText(message, 10, 25);
         }

         function invalidate()
         {
            canvasValid = false;
            console.log("인발리 ");
         }

         function draw()
         {
            if (canvasValid == false)
            {
               context.clearRect(0, 0, tmp_canvas.width, tmp_canvas.height);

               // Add stuff you want drawn in the background all the time here
               // draw all boxes
               var l = boxes.length;
               for (var i = 0; i < l; i++)
               {  
                  drawshape(context, boxes[i], boxes[i].fill, boxes[i].textarea1, boxes[i].font);

               }
               canvasValid = true;

               // draw selection
               // right now this is just a stroke along the edge of the selected box   
               if (mySel != null)
               {
                  context.strokeRect(mySel.x, mySel.y, mySel.w, mySel.h);

               }
               else
               {

               }
            }
         }

         function drawshape(context, shape, fill, textarea1, font)
         {
            // We can skip the drawing of elements that have moved off the screen:
            if (shape.x > tmp_canvas.width || shape.y > tmp_canvas.height) return;
            if (shape.x + shape.w < 0 || shape.y + shape.h < 0) return;

            var lines = textarea1.split('\n');
            console.log(lines.length);

            for (var i = 0; i < lines.length; i++)
            {
            
               context.fillText(lines[i], shape.x + 5, (shape.y + 10) + i * 10);

            }
         }

      </script>
</body>

</html>