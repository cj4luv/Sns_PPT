<%@page import="org.apache.xmlbeans.impl.xb.xsdschema.Public"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
   pageEncoding="utf-8" import="java.sql.*"%>
<%@ page import="java.io.*"%>
<%@ page import="org.apache.poi.hslf.model.*"%>
<%@ page import="org.apache.poi.hslf.usermodel.*"%>
<%@ page import="org.apache.poi.hslf.*"%>
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
   <%
   
   
      //String a = request.getParameter("hid1");
      //System.out.println(a);
    ArrayList<Integer> obj = new ArrayList<Integer>(); 
    ArrayList<Integer> ShapePosX = new ArrayList<Integer>(); 
    ArrayList<Integer> ShapePosY = new ArrayList<Integer>(); 
    ArrayList<Integer> ShapePosW = new ArrayList<Integer>(); 
    ArrayList<Integer> ShapePosH = new ArrayList<Integer>(); 
    ArrayList<String> ShapePosT = new ArrayList<String>(); 
    //  shapePosition = new ArryList<>();
    
      SlideShow src =

      new SlideShow(

    	         new HSLFSlideShow("C:\\Users\\ParkYoonJae\\git\\SnsPPT\\jspbook\\war\\upload\\Hellopoi.ppt")); 

      Slide[] sl = src.getSlides();
       
      //get slides 
      
      for (int i = 0; i < sl.length; i++){
        Shape[] sh = sl[i].getShapes();
        
        obj.add(sh.length);
      //  System.out.println(objindex);
        for (int p = 0; p < sh.length; p++){
          //name of the shape
          String name = sh[p].getShapeName();
		 
          //shapes's anchor which defines the position of this shape in the slide
          java.awt.Rectangle anchor = sh[p].getAnchor();
          
         
          ShapePosX.add(sh[p].getAnchor().x);          
          ShapePosY.add(sh[p].getAnchor().y);          
          ShapePosW.add(sh[p].getAnchor().width);          
          ShapePosH.add(sh[p].getAnchor().height);          
          //ShapePosWH.add(sh[p].getAnchor().width, sh[p].getAnchor().height);
        
         System.out.println(ShapePosX.get(p));
          
         // System.out.println(sh[p].getAnchor());
          if (sh[p] instanceof Line){
            Line line = (Line)sh[p];
            //work with Line
          } else if (sh[p] instanceof AutoShape){
            AutoShape shape = (AutoShape)sh[p];
            ShapePosT.add(shape.getText());  
            //System.out.println(shape.getAnchor());
              //System.out.println(shape.getText());
            //work with AutoShape
          } else if (sh[p] instanceof TextBox){
            TextBox shape = (TextBox)sh[p];
            ShapePosT.add(shape.getText()); 
           // System.out.println(shape.getText());
           // System.out.println(shape.getText());
            //work with TextBox
          } else if (sh[p] instanceof Picture){
            Picture shape = (Picture)sh[p];
            //work with Picture
          }
        }
      }
    
   %>

    
   <script>
         var canvas = document.querySelector('#myCanvas');
         var context = canvas.getContext('2d');
         var index;
         var drag= false;
         var isResizeDrag = false;
         var expectResize;
         var textarea = null;
         var canvasValid = true;
         var INTERVAL = 20;
         var Vtx = false;
         var selectionHandlesX = [];
         var selectionHandlesY = [];
         var mySelBoxSize = 12;
         
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
         {	drag = false;
        	isResizeDrag = false;
        	
            tmp_canvas.removeEventListener('mousemove', onPaint, false);
			
         }, false);

         /* Mouse Capturing Work */
         tmp_canvas.addEventListener('mousemove', function (e)
         {
            mouse.x = typeof e.offsetX !== 'undefined' ? e.offsetX : e.layerX;
            mouse.y = typeof e.offsetY !== 'undefined' ? e.offsetY : e.layerY;
        	
          
            
            if(mySel!=null){
                if(drag==true && isResizeDrag==false){
                	
                	 
                      boxes[index].x = mouse.x;
                	  boxes[index].y = mouse.y;
                	   
                	  console.log("무브 boxes의 배열 번째"+index);
                	  invalidate();
                	}else if(drag==true && isResizeDrag==true){
                		
                		 var oldx = mySel.x;
                		 var oldy = mySel.y;
                		    
                		    // 0  1  2
                		    // 3     4
                		    // 5  6  7
                		    switch (expectResize) {
                		      case 0:
                		        mySel.x = mouse.x;
                		        mySel.y = mouse.y;
                		        mySel.w += oldx - mouse.x;
                		        mySel.h += oldy - mouse.y;
                		        break;
                		      case 1:
                		        mySel.y = mouse.y;
                		        mySel.h += oldy - mouse.y;
                		        break;
                		      case 2:
                		        mySel.y = mouse.y;
                		        mySel.w = mouse.x - oldx;
                		        mySel.h += oldy - mouse.y;
                		        break;
                		      case 3:
                		        mySel.x = mouse.x;
                		        mySel.w += oldx - mouse.x;
                		        break;
                		      case 4:
                		        mySel.w = mouse.x - oldx;
                		        break;
                		      case 5:
                		        mySel.x = mouse.x;
                		        mySel.w += oldx - mouse.x;
                		        mySel.h = mouse.y - oldy;
                		        break;
                		      case 6:
                		        mySel.h = mouse.y - oldy;
                		        break;
                		      case 7:
                		        mySel.w = mouse.x - oldx;
                		        mySel.h = mouse.y - oldy;
                		        break;
                		    }
                		    
                		    invalidate();
                	}
                
                for(var j=0; j<8; j++){ 
                if (  selectionHandlesX[j] < start_mouse.x && selectionHandlesX[j] + mySelBoxSize  > start_mouse.x 
            			&& selectionHandlesY[j] < start_mouse.y && 
            			selectionHandlesY[j] +mySelBoxSize > start_mouse.y) {
                      // we found one!
                      expectResize = j;
                      invalidate();
                      
                      switch (j) {
                        case 0:
                        	tmp_canvas.style.cursor='nw-resize';
                          break;
                        case 1:
                        	tmp_canvas.style.cursor='n-resize';
                          break;
                        case 2:
                        	tmp_canvas.style.cursor='ne-resize';
                          break;
                        case 3:
                        	tmp_canvas.style.cursor='w-resize';
                          break;
                        case 4:
                        	tmp_canvas.style.cursor='e-resize';
                          break;
                        case 5:
                        	tmp_canvas.style.cursor='sw-resize';
                          break;
                        case 6:
                        	tmp_canvas.style.cursor='s-resize';
                          break;
                        case 7:
                        	tmp_canvas.style.cursor='se-resize';
                          break;
                      }
                      return;
                    }
                }
                
    			}//tmp_canvas.style.cursor='auto';  
            
            var message = 'Mouse position: ' + mouse.x + ',' + mouse.y;
            writeMessage(tmp_canvas, message);
            
         }, false);

       
         tmp_canvas.addEventListener('mousedown', function (e)
         {
            tmp_canvas.addEventListener('mousemove', onPaint, false);
            drag = true;
            mouse.x = typeof e.offsetX !== 'undefined' ? e.offsetX : e.layerX;
            mouse.y = typeof e.offsetY !== 'undefined' ? e.offsetY : e.layerY;
            
            start_mouse.x = mouse.x;
            start_mouse.y = mouse.y;

            // mysel draw ready   
            var l = boxes.length;
            
            for(var j=0; j<8; j++){ 
            	if(mySel!=null &&selectionHandlesX[j] < start_mouse.x && selectionHandlesX[j] + mySelBoxSize  > start_mouse.x 
            			&& selectionHandlesY[j] < start_mouse.y && 
            			selectionHandlesY[j] +mySelBoxSize > start_mouse.y){
            		isResizeDrag=true;
            		  console.log("선택된 포인트 점은 : "+j);
            		  expectResize = j;
            	}
            	
            }
            
            for (var i = l - 1; i >= 0; i--)
            {
               if (boxes[i].x < start_mouse.x && boxes[i].x + boxes[i].w > start_mouse.x && boxes[i].y < start_mouse.y && boxes[i].y + boxes[i].h >
                  start_mouse.y)
               {
                  mySel = boxes[i];
                  index = i;
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
                   //   mySel = boxes[i];
                      textarea1.style.left =  boxes[i].x + 'px';          
                      textarea1.style.top =  boxes[i].y + 'px';
                      textarea1.style.width =  boxes[i].w + 'px';
                      textarea1.style.height =  boxes[i].h + 'px';
                      textarea1.value =  boxes[i].textarea1;
                      textarea1.style.display = 'block';
                      context.strokeStyle = '#00FF00';
                      Vtx = true;
                   }
                }
            }
         }, false);

         tmp_canvas.addEventListener('mouseup', function ()
         {
        	 
        	 tmp_canvas.style.cursor='auto'; 
            tmp_canvas.removeEventListener('mousemove', onPaint, false);
			drag= false;
			
            addRect(parseInt(textarea1.style.left),
               parseInt(textarea1.style.top),
               parseInt(textarea1.style.width),
               parseInt(textarea1.style.height), textarea1.value);
			
			
				
			
            
            
            console.log("textarea1 값: " + textarea1.value);
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
            if(rect.textarea1!=""){
            	if(Vtx==false){
            	boxes.push(rect);
            	}else{
            		boxes[index].x=x;
            		boxes[index].y=y;
            		boxes[index].w=w;
            		boxes[index].h=h;
            		boxes[index].textarea1=textarea1;
            		Vtx=false;
            	}
            }
            
            
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

                  

                   //   context.strokeStyle = mySelColor;
                   //   context.lineWidth = mySelWidth;
                   //   context.strokeRect(this.x,this.y,this.w,this.h);
                      
                      // draw the boxes
                      
                      var half = mySelBoxSize / 2;
                      
                      // 0  1  2
                      // 3     4
                      // 5  6  7
                      
                      // top left, middle, right
                      selectionHandlesX[0] = mySel.x-half;
                      selectionHandlesY[0] = mySel.y-half;
                      
                      selectionHandlesX[1] = mySel.x+mySel.w/2-half;
                      selectionHandlesY[1] = mySel.y-half;
                      
                      selectionHandlesX[2] = mySel.x+mySel.w-half;
                      selectionHandlesY[2] = mySel.y-half;
                      
                      //middle left
                      selectionHandlesX[3] = mySel.x-half;
                      selectionHandlesY[3] = mySel.y+mySel.h/2-half;
                      
                      //middle right
                      selectionHandlesX[4] = mySel.x+mySel.w-half;
                      selectionHandlesY[4] = mySel.y+mySel.h/2-half;
                      
                      //bottom left, middle, right
                      selectionHandlesX[6] = mySel.x+mySel.w/2-half;
                      selectionHandlesY[6] = mySel.y+mySel.h-half;
                      
                      selectionHandlesX[5] = mySel.x-half;
                      selectionHandlesY[5] = mySel.y+mySel.h-half;
                      
                      selectionHandlesX[7] = mySel.x+mySel.w-half;
                      selectionHandlesY[7] = mySel.y+mySel.h-half;

                      
                     // context.fillStyle = mySelBoxColor;
                      for (var i = 0; i < 8; i ++) {
                       
                        context.fillRect(selectionHandlesX[i], selectionHandlesY[i], mySelBoxSize, mySelBoxSize);
                      }
                  
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
        // addRect(200, 200, 200, 200,"dsadad"); 
         invalidate();
      		//alert(<%=obj%>);
           // alert(<%= ShapePosX.get(0)%>);
        //   for(var ss=0; ss < <%=obj%>; ss++){
        	///   addRect(x, 1, 111, 33, dd);
        	 
          // }
          
        <% for (int ss=0; ss<3; ss++){%>
        	addRect(<%=ShapePosX.get(ss)%>, <%=ShapePosY.get(ss)%>, <%=ShapePosW.get(ss)%>, 
        	<%=ShapePosH.get(ss)%>, "<%=ShapePosT.get(ss)%>");
        	invalidate();
        <%}%><%
        
        
        %>
      </script>     
   
</body>

</html>