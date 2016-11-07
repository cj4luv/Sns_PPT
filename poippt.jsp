<%@ page import="java.io.*"%>
<%@ page import="org.apache.poi.hslf.model.*"%>
<%@ page import="org.apache.poi.hslf.usermodel.*"%>
<%@ page import="org.apache.poi.hslf.*"%>

<%



    SlideShow ppt = 

          new SlideShow(

          new HSLFSlideShow("C:\\Users\\ParkYoonJae\\git\\SnsPPT\\jspbook\\war\\upload\\Hellopoi.ppt")); 

//get slides 
Slide[] slide = ppt.getSlides();
for (int i = 0; i < slide.length; i++){
  Shape[] sh = slide[i].getShapes();
  for (int j = 0; j < sh.length; j++){
    //name of the shape
    String name = sh[j].getShapeName();

    //shapes's anchor which defines the position of this shape in the slide
    java.awt.Rectangle anchor = sh[j].getAnchor();
    System.out.println( sh[j].getAnchor());
    if (sh[j] instanceof Line){
      Line line = (Line)sh[j];
      //work with Line
    } else if (sh[j] instanceof AutoShape){
      AutoShape shape = (AutoShape)sh[j];
      //System.out.println(shape.getAnchor());
      
      //work with AutoShape
    } else if (sh[j] instanceof TextBox){
      TextBox shape = (TextBox)sh[j];
      
      //work with TextBox
    } else if (sh[j] instanceof Picture){
      Picture shape = (Picture)sh[j];
      //work with Picture
    }
  }
}

%>
