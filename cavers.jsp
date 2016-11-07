<%@page import="javax.xml.crypto.dsig.keyinfo.RetrievalMethod"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" import="java.sql.*"%>
<%@ page import="java.io.*"%>
<%@ page import="org.apache.poi.hslf.model.*"%>
<%@ page import="org.apache.poi.hslf.usermodel.*"%>
<%@ page import="org.apache.poi.hslf.*"%>
<%@page import="org.apache.xmlbeans.impl.xb.xsdschema.Public"%>
<%@page import="java.util.ArrayList"%>
<%@ page import="java.io.*"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="org.apache.poi.ddf.EscherProperties" %>
<jsp:include page="header.jsp" flush="false" />

<!DOCTYPE HTML>
<html>
<head>

<style>
html, body {
	width: 100%;
	height: 100%;
}

table {
  background-color: transparent;
  border: 1px solid;
  border-color: #dfe0e4;
}
#sketch {
	height: 540px;
	width: 720px;
	position: absolute;

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
	border: 5px solid gray;
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

.menu {
	border: 1px solid gray;
	padding: 1.5px;
	height: 180px;
	width: 240px;
	position: relative;
	float: left;
}

#side {
	overflow-y: auto;
	overflow-x: hidden;
	height: 540px;
}

.btn-toolbar {
	border: 1px;
}

.click-nav {
	width: 150px;
	margin-left: 1200px;
}

.click-nav ul {
	position: relative;
	font-weight: 900;
}

.click-nav ul li {
	position: relative;
	list-style: none;
	cursor: pointer;
}

.click-nav ul li ul {
	position: absolute;
	left: 0;
	right: 0;
}

.click-nav ul .clicker {
	position: relative;
	background: #2284B5;
	color: #FFF;
}

.click-nav ul .clicker:hover, .click-nav ul .active {
	background: #196F9A;
}

.click-nav ul li a {
	transition: background-color 0.2s ease-in-out;
	-webkit-transition: background-color 0.2s ease-in-out;
	-moz-transition: background-color 0.2s ease-in-out;
	display: block;
	padding: 8px 10px 8px 40px;
	background: #FFF;
	color: #333;
	text-decoration: none;
}

.click-nav ul li a:hover {
	background: #F2F2F2;
}

.click-nav .no-js ul {
	display: none;
}

.click-nav .no-js:hover ul {
	display: block;
}

#jb-container {
  width: 120%;
  height: 800px;
  margin: 0px auto;
  padding: 20px;
  border: 1px solid;
  border-color: #e5e6e9 #dfe0e4 #d0d1d5;
  border-radius: 10px;
  -moz-border-radius: 10px;
  -webkit-border-radius: 10px;
  -o-border-radius: 10px;
  background-color: #F8F8F8;
}

#jb-header {
	padding: 20px;
	margin-bottom: 20px;

	border: 1px solid;
 	border-color: #e5e6e9 #dfe0e4 #d0d1d5;
 	border-radius: 10px;
   -moz-border-radius: 10px;
   -webkit-border-radius: 10px;
   -o-border-radius: 10px;
   background-color: #ffffff
}

#jb-sidebar-left {


  padding: inherit;
  margin-right: 20px;
  margin-bottom: 20px;
  float: left;
  border: 1px solid;
  border-color: #e5e6e9 #dfe0e4 #d0d1d5;
  border-radius: 10px;
  -moz-border-radius: 10px;
  -webkit-border-radius: 10px;
  -o-border-radius: 10px;
  background-color: #FfFfFf;

}

#jb-content {
	height: 600px;
	width: 800px;
  padding-left : 35px;
  padding-top : 20px;
  float: left;
  border: 1px solid;
  border-color: #e5e6e9 #dfe0e4 #d0d1d5;
  border-radius: 10px;
  -moz-border-radius: 10px;
  -webkit-border-radius: 10px;
  -o-border-radius: 10px;
  background-color: #Ffffff;

}

#jb-sidebar-right {



	width: 400px;
  padding: 20px;
  margin-bottom: 20px;
  float: right;
  border: 1px solid;
  border-color: #e5e6e9 #dfe0e4 #d0d1d5;
  border-radius: 10px;
  -moz-border-radius: 10px;
  -webkit-border-radius: 10px;
  -o-border-radius: 10px;
  background-color: #FfFfFf;
}

.custom-file-input {
  color: transparent;
height: 25px


}
.custom-file-input::-webkit-file-upload-button {
  visibility: hidden;

}
.custom-file-input::before {

  border: 1px solid #bcbcbc;
  border-radius: 3px;

  outline: none;
  white-space: nowrap;
  -webkit-user-select: none;



  display: inline-block;
  width: 25px;
  height: 25px;

  content: "";
  background: url("images/Image.png") no-repeat 0 0;
  background-size: 100%;
}
.custom-file-input:hover::before {
  border-color: gray;
}
.custom-file-input:active:focus  {
  border-color: black;
}



.image_layout {
	width: 25px;
	float: left;
}

h1 ,h2 {
text-decoration: none;
  color: #939297;

  background-color: transparent;
  border: none;
  font-size: 30px;

}

p, li, DIV {
	text-decoration: none;
  color: #939297;

  background-color: transparent;
  border: none;
  font-size: 1em;
}
.btn-group {
  margin-left: 5px;
  margin-right: 8px;
}



element.style {
  color: gray;
}
.save-btn{
 background: url("images/Save.png") no-repeat 0 0;
  width:25px;
   height:25px;
   display: block;
  background-size: 100%;
}

.italic-btn {
	background: url("images/Italic.png") no-repeat 0 0;
	width:20px;
	height:20px;
	display: block;
	background-size: 100%;
	float: left;
	margin-right: 5px;
}

.btn {
    padding: 10px 14px;

    font-weight: 700;
    letter-spacing: 1px;
    text-transform: uppercase;
    margin-bottom: 6px;
    float: left;
}

.second_menu {
	margin-top: 15px;
	padding: 5px;

}

label {
  margin-left: 8px;
  padding-top: 10px;
}

.new_slide_btn {
	background: url("images/New_Slide.png") no-repeat 0 0;
	width:20px;
	height:20px;
	display: block;
	background-size: 100%;
	float: left;
	margin-right: 5px;
}

.slide_del_btn {
	background: url("images/Slide_Del.png") no-repeat 0 0;
	width:20px;
	height:20px;
	display: block;
	background-size: 100%;
	float: left;
	margin-right: 5px;
}

.align_left_btn {
	background: url("images/Align_Left.png") no-repeat 0 0;
	width:20px;
	height:20px;
	display: block;
	background-size: 100%;
	float: left;
	margin-right: 5px;
}

.align_center_btn {
	background: url("images/Align_Center.png") no-repeat 0 0;
	width:20px;
	height:20px;
	display: block;
	background-size: 100%;
	float: left;
	margin-right: 5px;
}

.align_right_btn {
	background: url("images/Align_Right.png") no-repeat 0 0;
	width:20px;
	height:20px;
	display: block;
	background-size: 100%;
	float: left;
	margin-right: 5px;
}
</style>
</head>

<body>
	<div id="jb-container">
		<div class="btn-toolbar" id="jb-header">
		<button type="button" class="btn btn-default" >
		<form name="imageForm" method="post" class="image_layout">
			<input type="file" Name="custromInput" class="custom-file-input" onchange="handleImageView(this)">
		</form>
	</button>

			<form name="saveForm" method="post" class="first_menu" action="process_savewrite.jsp">
				<INPUT TYPE="hidden" NAME="hid1">
				<INPUT TYPE="hidden" NAME="hid2">
				<button type="button" class="btn btn-default" id="btn">
					<span class="save-btn"></span>
				</button>


				<label for="color">Fill</label> <input type="color" id="FillColor"
					name="FillColor" value="#ff0000" list="fcolors" onchange="border_Function(this)">
				<datalist id=fcolors>
					<option>#ffffff</option>
					<option>#ff0000</option>
					<option>#ff7700</option>
				</datalist>

				<label for="color">Font</label> <input type="color" id="FontColor"
					name="FontColor" value="#333333" list="colors">
				<datalist id=colors>
					<option>#ffffff</option>
					<option>#ff0000</option>
					<option>#ff7700</option>

				</datalist>

				<label>글꼴</label> <select id="font_select" style="color: black"
					onChange="fontselect_Function(this)">
					<option value="Gulim" selected="selected">굴림</option>
					<option value="Batang">바탕</option>
					<option value="Gothic">고딕</option>
					<option value="Dotum">돋움</option>
				</select>
			</form>
			<div class="second_menu">
			<div class="btn-group">
				<button type="button" onclick="check_button()"
					class="btn btn-default" id="taxt-creat">
					<span class="glyphicon glyphicon-font"></span> Text
				</button>
				<button type="button" class="btn btn-default"
					onclick="check_button_bold()">
					<span class="glyphicon glyphicon-bold"></span> Bold
				</button>

				<button type="button" class="btn btn-default"
					onclick="check_button_italic()">
					<span class="italic-btn"></span> Italic
				</button>
			</div>
			<div class="btn-group">
				<button type="button" class="btn btn-default"
					onclick="check_button_slide()">
					<span class="new_slide_btn"></span>
				</button>
				<button type="button" class="btn btn-default"
					onclick="del_button_slide()">
					<span class="slide_del_btn"></span>
				</button>
			</div>

			<div class="btn-group">
				<button type="button" onclick="align_left()" class="btn btn-default"
					id="taxt-creat"><span class="align_left_btn"></span></button>
				<button type="button" onclick="align_center()"
					class="btn btn-default" id="taxt-creat"><span class="align_center_btn"></button>
				<button type="button" onclick="align_right()"
					class="btn btn-default" id="taxt-creat"><span class="align_right_btn"></button>
			</div>



				<label>글크기</label> <select name="font_size"
					onChange="fontsize_Function(this)">
					<option value="11">11</option>
					<option value="24">24</option>
					<option value="36">36</option>
					<option value="48">48</option>
				</select> <label>테두리색</label> <select id="background_color"
					style="background-color: white"
					onChange="background_Function(this)">
					<option value="none" style="background-color: white"
						selected="selected">투명</option>
					<option value="#000000" style="background-color: black">&nbsp;
						&nbsp; &nbsp; &nbsp;</option>
					<option value="#ff0000" style="background-color: red">&nbsp;
						&nbsp; &nbsp; &nbsp;</option>
					<option value="#ffff00" style="background-color: Yellow">&nbsp;
						&nbsp; &nbsp; &nbsp;</option>
					<option value="#0000ff" style="background-color: blue">&nbsp;
						&nbsp; &nbsp; &nbsp;</option>
				</select> <label>폰트색</label> <select id="font_color" style="color: black"
					onChange="fontcolor_Function(this)">
					<option value="#000000" style="color: black" selected="selected">가</option>
					<option value="#ff0000" style="color: red">가</option>
					<option value="#ffff00" style="color: Yellow">가</option>
					<option value="#0000ff" style="color: blue">가</option>
				</select> <label>채우기색</label> <select id="border_color"
					style="background-color: white" onChange="border_Function(this)">
					<option value="none" style="background-color: white"
						selected="selected">투명</option>
					<option value="#000000" style="background-color: black">&nbsp;
						&nbsp; &nbsp; &nbsp;</option>
					<option value="#ff0000" style="background-color: red">&nbsp;
						&nbsp; &nbsp; &nbsp;</option>
					<option value="#ffff00" style="background-color: Yellow">&nbsp;
						&nbsp; &nbsp; &nbsp;</option>
					<option value="#0000ff" style="background-color: blue">&nbsp;
						&nbsp; &nbsp; &nbsp;</option>
				</select>
				<label>투명도</label> <select id="alpha"
					onChange="alpha_Function(this)">
					<option value="0">0</option>
					<option value="10">10</option>
					<option value="20">20</option>
					<option value="30">30</option>
					<option value="40">40</option>
					<option value="50">50</option>
					<option value="60">60</option>
					<option value="70">70</option>
					<option value="80">80</option>
					<option value="90">90</option>
					<option value="100">100</option></select>

			</div>
		</div>
<%
 class pasing{
	 public int x;
	 public int y;
	 public int w;
	 public int h;
	 public String txt;
	 public int fontSize;
	 public int page;
	 public int visible;
	 public String ftcolor;
	 public String bgcolor;
	 public String brcolor;
	 public int align;
	 public int form;
	 public int alpha;
	public pasing(int x, int y, int w, int h, String txt, int fontSize, int page, int visible, String ftcolor, String bgcolor, String brcolor, int align, int form, int alpha)
	 {
	  this.x=x;
	  this.y=y;
	  this.w=w;
	  this.h=h;
	  this.txt=txt;
	  this.fontSize=fontSize;
	  this.page=page;
	  this.visible=visible;
	  this.ftcolor=ftcolor;
	  this.bgcolor=bgcolor;
	  this.brcolor=brcolor;
	  this.align=align;
	  this.form=form;
	  this.alpha=alpha;
	 }
}
%>

<%!
public int alphaToInt(int e) {
	int count=1;
	//System.out.println("투명도 인트값"+e);

	if(e==0){
		return 0;
	}else{
		while(e<64764){
		if(count%2==0){
			e+=771;
		}else{
			e+=514;
		}count++;
		}
		//System.out.println("e 값"+e);
		//System.out.println("카운트 값"+count);
		  return count;
	}


}


%>

		<%
   String id = (String)session.getAttribute("loginid"); //#로그인한#id를#체크#

   if (id != null) { //#로그인상태#
      // 데이터베이스 연결관련 변수 선언
      Connection conn = null;
      PreparedStatement pstmt = null;
      ResultSet rs3=null;

      int total=0;
      // 데이터베이스 연결관련정보를 문자열로 선언
      String jdbc_driver = "com.mysql.jdbc.Driver";
      String jdbc_url = "jdbc:mysql://127.0.0.1/jspdb";

      try{
         // JDBC 드라이버 로드
         Class.forName(jdbc_driver);

         // 데이터베이스 연결정보를 이용해 Connection 인스턴스 확보
         conn = DriverManager.getConnection(jdbc_url,"jspbook","1234");
         String sql3 = "SELECT username,friend_request,friend_state FROM jspdb.friend_info where friend_state=2";

         pstmt = conn.prepareStatement(sql3);
         rs3=pstmt.executeQuery();



         // username 값을 입력한 경우 sql 문장을 수행.
         %>


		<div class="col-xs-6 col-sm-3 sidebar-offcanvas" role="navigation" id="jb-sidebar-right">
			<p>Friends List</p>
			<div class="well sidebar-nav" id="fflist">

			<jsp:include page="access_user.jsp" flush="false" />
			</div>
			<!--/.well -->
			<jsp:include page="chatClient.jsp" flush="false" />
		</div>


		<%  }
      catch(Exception e) {
		         System.out.println(e);
		      }
		       conn.close();
		       pstmt.close();
		   }  
    %>



		<% String a = request.getParameter("hid1");
   //System.out.println(a);


   int startSlide=0;

   //ArrayList<objectPos> opjectpos = new ArrayList<objectPos>();


   int slideCount;
   int objcount=0;
      String filename1 = request.getParameter("hid1");
      String writername = request.getParameter("hid2");
      String filename = null;
      if(filename1.charAt(0)=='%'){
       filename =   URLDecoder.decode(URLDecoder.decode(request.getParameter("hid1"),"utf-8"),"utf-8");
      }else{
    	  filename = filename1;
      }
      //filename = new String(filename.getBytes("8859_1"), "euc-kr");
    //  System.out.println(filename1);
    //  System.out.println(filename);
   //   System.out.println(writername);

      ArrayList<pasing> passing = new ArrayList <pasing>();
      ArrayList<Integer> obj = new ArrayList<Integer>();


      SlideShow src =
      new SlideShow(new HSLFSlideShow("C:\\apache-tomcat-7.0.72\\webapps\\jspbook2\\upload\\"+writername+"\\"+filename));
 	  
      Slide[] sl = src.getSlides();

      slideCount=sl.length;
      //get slides
      startSlide=sl.length;

    /*  PictureData[] pdata = src.getPictureData();
      System.out.print("dsasdasdsdsdsda asdasd "+pdata.length);
      for (int i = 0; i < pdata.length; i++){
    	    PictureData pict = pdata[i];

    	    // picture data
    	    byte[] data = pict.getData();

    	    int type = pict.getType();
    	    String ext;
    	    switch (type){
    	      case Picture.JPEG: ext=".jpg"; break;
    	      case Picture.PNG: ext=".png"; break;
    	      case Picture.WMF: ext=".wmf"; break;
    	      case Picture.EMF: ext=".emf"; break;
    	      case Picture.PICT: ext=".pict"; break;
    	      default: continue;
    	    }
    	    FileOutputStream out1 = new FileOutputStream("C:\\Users\\ParkYoonJae\\git\\SnsPPT\\jspbook\\war\\upload\\pcc"+i + ext);
    	      out1.write(data);
    	      out1.close();

    	  } */ ///이미지 추출

      int piccount=0;
      for (int i = 0; i < sl.length; i++){

    		int passX= 0;
    		int passY= 0;
    		int passW= 0;
    		int passH= 0;
    		String passTxt= "";
    		String passFont=" ";
    		int passPage=0;
    		int passVisible = 1;
    		String passFtcolor = "";
    		String passBgcolor = "";
    		String passBrcolor = "";
    		int passAlign = 0;
    	    String rColor = "";
    	    String gColor = "";
    	    String bColor = "";
    	    String tempColor = "";
    		int passFontSize= 0;
    		int passForm = 0;
    		int passAlpha = 0;
        Shape[] sh = sl[i].getShapes();
        Slide s = sl[i];

       // System.out.println("사진이 뭐가있나요"+ src.getPictureData().toString());


        TextRun[] trs = s.getTextRuns();
        obj.add(sh.length);

      //  System.out.println("obj 갯수:"+sh.length);
     //   System.out.println("슬라이드 갯수:"+sl.length);
     //   System.out.println("오브젝트 갯수:"+obj.get(i));
        objcount = objcount + obj.get(i);



       for (int k = 0; k < trs.length; k++) {
           TextRun tr = trs[k];         //여긴 무시
        //   System.out.println("tr:"+tr.getText());
       }

        for (int p = 0; p < sh.length; p++){
          //name of the shape
          String name = sh[p].getShapeName();

          //shapes's anchor which defines the position of this shape in the slide
          java.awt.Rectangle anchor = sh[p].getAnchor();

       	  passPage = i;
       	  passX = sh[p].getAnchor().x;
       	  passY = sh[p].getAnchor().y;
       	  passW = sh[p].getAnchor().width;
       	  passH = sh[p].getAnchor().height;


          if (sh[p] instanceof Line){
            Line line = (Line)sh[p];

            //work with Line
          } else if (sh[p] instanceof AutoShape){
            AutoShape shape = (AutoShape)sh[p];
          //  ShapePosT.add(shape.getText());
            passTxt = shape.getText();

            System.out.println("텍스트"+passTxt);
            if(passTxt.indexOf("\n")>-1){
            	System.out.println("이텍스트는 줄바꿈 없음");
            }else{
            	System.out.println("이텍스트는 줄바꿈 있음");

                passTxt = passTxt.replaceAll("\n","@n@");

            }

             if(shape.getText()!=null){
            RichTextRun rt = shape.getTextRun().getRichTextRuns()[0];

            //System.out.println("채우기"+shape.getFillColor());
           // System.out.println("라인"+shape.getLineColor());

            if(shape.getFillColor()!=null){         //백드라운드 색상이 null이 아닐때
			tempColor = shape.getFillColor().toString();
            rColor = tempColor.substring(tempColor.indexOf("r=")+2 ,tempColor.indexOf(",g"));
            gColor = tempColor.substring(tempColor.indexOf("g=")+2 ,tempColor.indexOf(",b"));
            bColor = tempColor.substring(tempColor.indexOf("b=")+2 ,tempColor.length()-1);
            rColor =  String.format("%02x", Integer.parseInt(rColor));
            gColor =  String.format("%02x", Integer.parseInt(gColor));
            bColor =  String.format("%02x", Integer.parseInt(bColor));
            passBgcolor="#"+rColor+gColor+bColor;
            passAlpha=alphaToInt(shape.getEscherProperty(EscherProperties.FILL__FILLOPACITY));

            }else{
            	passBgcolor="none";
            }
            if(shape.getLineColor()!=null){         //백드라운드 색상이 null이 아닐때
			tempColor = shape.getFillColor().toString();
            rColor = tempColor.substring(tempColor.indexOf("r=")+2 ,tempColor.indexOf(",g"));
            gColor = tempColor.substring(tempColor.indexOf("g=")+2 ,tempColor.indexOf(",b"));
            bColor = tempColor.substring(tempColor.indexOf("b=")+2 ,tempColor.length()-1);
            rColor =  String.format("%02x", Integer.parseInt(rColor));
            gColor =  String.format("%02x", Integer.parseInt(gColor));
            bColor =  String.format("%02x", Integer.parseInt(bColor));
            passBrcolor="#"+rColor+gColor+bColor;
            }else{
            	passBrcolor="none";
            }

              //System.out.println(shape.getAnchor());
		      System.out.println(rt.getFontSize()+"px "+rt.getFontName());
              System.out.println(rt.getFontColor());
              tempColor = rt.getFontColor().toString();
              rColor = tempColor.substring(tempColor.indexOf("r=")+2 ,tempColor.indexOf(",g"));
              gColor = tempColor.substring(tempColor.indexOf("g=")+2 ,tempColor.indexOf(",b"));
              bColor = tempColor.substring(tempColor.indexOf("b=")+2 ,tempColor.length()-1);
              rColor =  String.format("%02x", Integer.parseInt(rColor));
              gColor =  String.format("%02x", Integer.parseInt(gColor));
              bColor =  String.format("%02x", Integer.parseInt(bColor));
              passFtcolor="#"+rColor+gColor+bColor;
              //폰트색


            //  System.out.println(Integer.toHexString(Integer.parseInt(rColor))+ " " +gColor+ "  "+ bColor);
              passFont = rt.getFontName();         //폰트이름만 한글은 영어로 바꿔줘야됨 또 뒤에 px도 붙여줘야됨
			  passFontSize = rt.getFontSize();
              passAlign = rt.getAlignment();
              passVisible = 1;
             }

             if(shape.getFillColor()!=null){         //백드라운드 색상이 null이 아닐때
     			tempColor = shape.getFillColor().toString();
                 rColor = tempColor.substring(tempColor.indexOf("r=")+2 ,tempColor.indexOf(",g"));
                 gColor = tempColor.substring(tempColor.indexOf("g=")+2 ,tempColor.indexOf(",b"));
                 bColor = tempColor.substring(tempColor.indexOf("b=")+2 ,tempColor.length()-1);
                 rColor =  String.format("%02x", Integer.parseInt(rColor));
                 gColor =  String.format("%02x", Integer.parseInt(gColor));
                 bColor =  String.format("%02x", Integer.parseInt(bColor));
                 passBgcolor="#"+rColor+gColor+bColor;
                 passAlpha=alphaToInt(shape.getEscherProperty(EscherProperties.FILL__FILLOPACITY));

                 }else{
                 	passBgcolor="none";
                 }
                 if(shape.getLineColor()!=null){         //백드라운드 색상이 null이 아닐때
     			tempColor = shape.getFillColor().toString();
                 rColor = tempColor.substring(tempColor.indexOf("r=")+2 ,tempColor.indexOf(",g"));
                 gColor = tempColor.substring(tempColor.indexOf("g=")+2 ,tempColor.indexOf(",b"));
                 bColor = tempColor.substring(tempColor.indexOf("b=")+2 ,tempColor.length()-1);
                 rColor =  String.format("%02x", Integer.parseInt(rColor));
                 gColor =  String.format("%02x", Integer.parseInt(gColor));
                 bColor =  String.format("%02x", Integer.parseInt(bColor));
                 passBrcolor="#"+rColor+gColor+bColor;
                 }else{
                 	passBrcolor="none";
                 }




            }
            else if (sh[p] instanceof TextBox){
            TextBox shape = (TextBox)sh[p];
            //ShapePosT.add(shape.getText());
            passTxt = shape.getText();



            if(shape.getText()!=null){
            RichTextRun rt = shape.getTextRun().getRichTextRuns()[0];



            if(shape.getFillColor()!=null){         //백드라운드 색상이 null이 아닐때
			tempColor = shape.getFillColor().toString();
            rColor = tempColor.substring(tempColor.indexOf("r=")+2 ,tempColor.indexOf(",g"));
            gColor = tempColor.substring(tempColor.indexOf("g=")+2 ,tempColor.indexOf(",b"));
            bColor = tempColor.substring(tempColor.indexOf("b=")+2 ,tempColor.length()-1);
            rColor =  String.format("%02x", Integer.parseInt(rColor));
            gColor =  String.format("%02x", Integer.parseInt(gColor));
            bColor =  String.format("%02x", Integer.parseInt(bColor));
            passAlpha=alphaToInt(shape.getEscherProperty(EscherProperties.FILL__FILLOPACITY));
            passBgcolor="#"+rColor+gColor+bColor;
            }else{
            	passBgcolor="none";
            }
            if(shape.getLineColor()!=null){         //백드라운드 색상이 null이 아닐때
			tempColor = shape.getFillColor().toString();
            rColor = tempColor.substring(tempColor.indexOf("r=")+2 ,tempColor.indexOf(",g"));
            gColor = tempColor.substring(tempColor.indexOf("g=")+2 ,tempColor.indexOf(",b"));
            bColor = tempColor.substring(tempColor.indexOf("b=")+2 ,tempColor.length()-1);
            rColor =  String.format("%02x", Integer.parseInt(rColor));
            gColor =  String.format("%02x", Integer.parseInt(gColor));
            bColor =  String.format("%02x", Integer.parseInt(bColor));
            passBrcolor="#"+rColor+gColor+bColor;
            }else{
            	passBrcolor="none";
            }

           //   System.out.println(shape.getLineColor());
           //   System.out.println(shape.getFillColor());
              //System.out.println(rt.getFontColor());

            //  System.out.println("폰트이름: "+rt.getFontName()+"폰트사이즈: "+rt.getFontSize());
            //  System.out.println("글씨 투명도 정보 보자: "+shape.getText());
            //  passAlpha=alphaToInt(shape.getEscherProperty(EscherProperties.FILL__FILLOPACITY));
            //  System.out.println("투명도"+shape.getEscherProperty(EscherProperties.FILL__FILLOPACITY));
           //   System.out.println("리턴"+alphaToInt(shape.getEscherProperty(EscherProperties.FILL__FILLOPACITY)));
              String str = ((Object) (shape.getEscherProperty(EscherProperties.FILL__FILLOPACITY))).getClass().getName();
          //    System.out.println("타입"+str);
             // int passAlpha =alphaToInt(shape.getEscherProperty(EscherProperties.FILL__FILLOPACITY));
           //   System.out.println("투명도 변환"+passAlpha);
             // ShapeFont.add(rt.getFontName());
             // ShapeFontSize.add(rt.getFontSize());
              passFontSize = rt.getFontSize();
              passAlign = rt.getAlignment();

              tempColor = rt.getFontColor().toString();
              rColor = tempColor.substring(tempColor.indexOf("r=")+2 ,tempColor.indexOf(",g"));
              gColor = tempColor.substring(tempColor.indexOf("g=")+2 ,tempColor.indexOf(",b"));
              bColor = tempColor.substring(tempColor.indexOf("b=")+2 ,tempColor.length()-1);
              rColor =  String.format("%02x", Integer.parseInt(rColor));
              gColor =  String.format("%02x", Integer.parseInt(gColor));
              bColor =  String.format("%02x", Integer.parseInt(bColor));
              passFtcolor="#"+rColor+gColor+bColor;
              System.out.println(passTxt);
              if(passTxt.indexOf("\n")==-1){
              	System.out.println("이텍스트는 줄바꿈 없음");
              }else{
            	  passTxt = passTxt.replaceAll("\n","@n@");

              }

            }else{
              //   ShapeFont.add(null)
              //    ShapeFontSize.add(null);

            }
           // System.out.println(shape.getText());
            //work with TextBox
          } else if (sh[p] instanceof Picture){
            Picture shape = (Picture)sh[p];
            //work with Picture
            passForm = 3;
            PictureData pictData = shape.getPictureData();
            byte[] data = pictData.getData();
            int type = pictData.getType();
           // "upload/pcc0.jpg";
            if (type == Picture.JPEG){
            	passTxt = "upload/"+writername+"/"+filename.substring(0,filename.length()-4)+"_"+piccount+".jpg";
            FileOutputStream out1 = new FileOutputStream("C:\\apache-tomcat-7.0.72\\webapps\\jspbook2\\upload\\"+writername+"\\"+filename.substring(0,filename.length()-4)+"_"+piccount+".jpg");
                out1.write(data);
                out1.close();
              } else if (type == Picture.PNG){
            	passTxt = "upload/"+writername+"/"+filename.substring(0,filename.length()-4)+"_"+piccount+".png";
            FileOutputStream out1 = new FileOutputStream("C:\\apache-tomcat-7.0.72\\webapps\\jspbook2\\upload\\"+writername+"\\"+filename.substring(0,filename.length()-4)+"_"+piccount+".png");
                out1.write(data);
                out1.close();
              }

            piccount++;
          }

        passing.add(new pasing(passX,passY,passW,passH,passTxt,passFontSize,passPage,passVisible
        		,passFtcolor,passBgcolor,passBrcolor,passAlign,passForm,passAlpha));
        passForm=0;
        }

      }  //슬라이드 갯수만큼 포문

      for(int i=0; i<passing.size();i++){
    	  if(passing.get(i).align==-1){
    		  passing.get(i).align=0;
    	  }
      }


   %>



   	<div id="jb-sidebar-left">
			<div id="side">
				<table border=1 id="test">
					<%for(int i=0;i<slideCount;i++) {%>
					<tr>
						<td>
							<div id="menu" class="menu">
								<canvas id="ssCanvas<%=i%>" class="cc"></canvas>
							</div>
						</td>
					</tr>
					<%} %>
				</table>
			</div>
		</div>
			<div id="jb-content">
			<div id="sketch">
				<canvas id="myCanvas" onload="initializeCanvas"></canvas>
			</div>
		</div>

	<script>
         var textareadisplay = 'none';

         var tempX;
         var tempY;
         var index;
         var drag= false;
         var isResizeDrag = false;
         var expectResize;
         var textarea = null;
         var canvasValid = true;
         var canvasValid1 = true;
         var INTERVAL = 20;
         var Vtx = false;
         var selectionHandlesX = [];
         var selectionHandlesY = [];
         var mySelBoxSize = 12;
         var nowpage=0;
         var textblock =true ;
         var canvas = document.querySelector('#myCanvas');
         var context = canvas.getContext('2d');
         var sketch = document.querySelector('#sketch');
         var sketch_style = getComputedStyle(sketch);
         canvas.width = parseInt(sketch_style.getPropertyValue('width'));
         canvas.height = parseInt(sketch_style.getPropertyValue('height'));
		 	 	var livepagecount=0;
        var delpagecount = [];
     	 	var delindex = 0;
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

         function check_button(){
        	 textblock=false;
             console.log("텍스트 버튼");
             textareadisplay = 'block';
           }


         function check_button_bold(){

        	var tempfont=boxes[index].font.split(" ");
  			var boldct=0;
          		if(tempfont[0]=="italic"){
          			if(tempfont[1]=="bold"){       //이탤릭 볼드
          				boxes[index].font= "italic " + boxes[index].font.substr(12,boxes[index].font.length);
          				boldct++;
          			}
          		}

          		if(tempfont[0]=="bold"){
          			if(tempfont[1]=="italic"){       //볼드 이탤릭
          				boxes[index].font= "italic " + boxes[index].font.substr(12,boxes[index].font.length);
          				boldct++;
          			}
          		}

          		if(tempfont[0]=="bold"){
          			if(tempfont[1]!="italic"){       //볼드
          				boxes[index].font= boxes[index].font.substr(4,boxes[index].font.length);
          				boldct++;
          			}
          		}

          		if(tempfont[0]=="italic"){
          			if(tempfont[1]!="bold"){       //이탤릭
          				boxes[index].font="bold "+boxes[index].font;
          				boldct++;
          			}
          		}

				if(boldct==0){        //그냥
					boxes[index].font= "bold " + boxes[index].font;
				}
				//alert(boxes[index].font);
				boldct=0;
                invalidate();
        	    invalidate1();
           }

         function check_button_italic(){

         	var tempitfont=boxes[index].font.split(" ");
   			var itct=0;
           		if(tempitfont[0]=="italic"){
           			if(tempitfont[1]=="bold"){       //이탤릭 볼드
           				boxes[index].font= "bold " + boxes[index].font.substr(12,boxes[index].font.length);
           				itct++;
           			}
           		}

           		if(tempitfont[0]=="bold"){
           			if(tempitfont[1]=="italic"){       //볼드 이탤릭
           				boxes[index].font= "bold " + boxes[index].font.substr(12,boxes[index].font.length);
           				itct++;
           			}
           		}

           		if(tempitfont[0]=="bold"){
           			if(tempitfont[1]!="italic"){       //볼드
           				boxes[index].font= "italic " + boxes[index].font;
           				itct++;
           			}
           		}

           		if(tempitfont[0]=="italic"){
           			if(tempitfont[1]!="bold"){       //이탤릭
           				boxes[index].font= boxes[index].font.substr(6,boxes[index].font.length);
           				itct++;
           			}
           		}

 				if(itct==0){        //그냥
 					boxes[index].font= "italic " + boxes[index].font;
 				}

 				//alert(boxes[index].font);
 				itct=0;
                 invalidate();
         	    invalidate1();

         }


         var textarea1 = document.createElement('textarea');
         textarea1.id = 'text_tool';
         sketch.appendChild(textarea1);


         textarea1.addEventListener('mouseup', function (e)
         {   drag = false;
           isResizeDrag = false;
           expectResize = null;
            tmp_canvas.removeEventListener('mousemove', onPaint, false);

         }, false);

         /* Mouse Capturing Work */
         tmp_canvas.addEventListener('mousemove', function (e)
         {
            mouse.x = typeof e.offsetX !== 'undefined' ? e.offsetX : e.layerX;
            mouse.y = typeof e.offsetY !== 'undefined' ? e.offsetY : e.layerY;



            if(mySel!=null){
                if(drag==true && isResizeDrag==false){


                     boxes[index].x = mouse.x-Math.abs(tempX);

                     boxes[index].y = mouse.y-Math.abs(tempY);

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
                          invalidate1();
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

          //  var message = 'Mouse position: ' + mouse.x + ',' + mouse.y;
          //  writeMessage(tmp_canvas, message);

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
                   // console.log("선택된 포인트 점은 : "+j);
                    expectResize = j;

               }

            }


            //for (var i = l - 1; i >= 0; i--)

            for (var i = 0; i<l; i++)
            {
               if (boxes[i].x < start_mouse.x && boxes[i].x + boxes[i].w > start_mouse.x && boxes[i].y < start_mouse.y && boxes[i].y + boxes[i].h >
                  start_mouse.y)
               {
                  if(nowpage==boxes[i].page){
                	  if(textblock){
                  mySel = boxes[i];

             /*     console.log("박스에 대한 정보 x: "+rect.x);
                  console.log("박스에 대한 정보 y: "+rect.y);
                  console.log("박스에 대한 정보 w: "+rect.w);
                  console.log("박스에 대한 정보 h: "+rect.h);
                  console.log("박스에 대한 정보 t: "+rect.textarea1);
                  console.log("박스에 대한 정보 f: "+rect.font);
                  console.log("박스에 대한 정보 p: "+rect.page);
                  console.log("박스에 대한 정보 v: "+rect.visible);
                  console.log("박스에 대한 정보 f: "+rect.ftcolor);
                  console.log("박스에 대한 정보 b: "+rect.bgcolor);
                  console.log("박스에 대한 정보 a: "+rect.align);
                  console.log("박스에 대한 정보 f: "+rect.form);

                 */

                  //alert(i+ "선택된 박스번호"+boxes[i].visible);
                  index = i;
                 // tempXX=boxes[index].x;
                  tempX=mySel.x-mouse.x;
                  tempY=mySel.y-mouse.y;

                  context.strokeStyle = '#000000';
                  invalidate();

                  return;
                	  }


                  }
               }

            }


            mySel = null;
            invalidate();

         }, false);

         tmp_canvas.addEventListener('dblclick', function ()
         {
            tmp_canvas.removeEventListener('mousemove', onPaint, false);
            if (mySel != null && mySel.form !=3)
            {
             // mysel draw ready
                var l = boxes.length;
                for (var i = l - 1; i >= 0; i--)
                {
                   if (boxes[i].x < start_mouse.x && boxes[i].x + boxes[i].w > start_mouse.x && boxes[i].y < start_mouse.y && boxes[i].y + boxes[i].h >
                      start_mouse.y)
                   {
                   //   mySel = boxes[i];
                      var align=0;

                          if(boxes[i].align==0){
                         	 align="left";
                          }else if(boxes[i].align==1){
                         	 align="center";
                          }else if(boxes[i].align==2){
                         	 align="right";
                          }
                      textarea1.style.left =  boxes[index].x + 'px';
                      textarea1.style.top =  boxes[index].y + 'px';
                      textarea1.style.width =  boxes[index].w + 'px';
                      textarea1.style.height =  boxes[index].h + 'px';
                      textarea1.value =  boxes[index].textarea1;
                      textarea1.font = boxes[i].font; //텍스트 폰트
                      textarea1.bgcolor = boxes[i].bgcolor;
                      textarea1.style.display = 'block';
                      textarea1.textAlign  = align;
                      context.strokeStyle = '#00FF00';
                      Vtx = true;
                   }
                }
            }
         }, false);

         tmp_canvas.addEventListener('mouseup', function ()
         {
            var align=0;
            tmp_canvas.style.cursor='auto';
            tmp_canvas.removeEventListener('mousemove', onPaint, false);
            textblock=true;

         drag = false;
         isResizeDrag = false;
         expectResize = null;

         if(textarea1.textAlign=='left'){
        	 align=0;
         }else if(textarea1.textAlign=='center'){
        	 align=1;
         }else if(textarea1.textAlign=='right'){
        	 align=2;
         }

         addRect(parseInt(textarea1.style.left),                //x
                 parseInt(textarea1.style.top),					//y
                 parseInt(textarea1.style.width),				//w
                 parseInt(textarea1.style.height), 				//h
                 textarea1.value, 								//text
                 textarea1.font, 								//font
                 nowpage,										//page
                 1, 											//visible
                 document.getElementById("font_color").value, 	//fontcolor    ftcolor
                 document.getElementById("border_color").value ,	//background bgcolor
                 document.getElementById("background_color").value ,		//boardcolor brcolor
                 align,
                 0,
                 document.getElementById("alpha").value
         );


        // x, y, w, h, textarea1, font, page, visible, ftcolor, bgcolor, brcolor, align



            // Clearing tmp canvas
            tmp_ctx.clearRect(0, 0, tmp_canvas.width, tmp_canvas.height);

            // clearInterval(sprayIntervalID);
            textareadisplay = 'none';
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

            textarea1.style.display = textareadisplay;
            }
         };

         //Box object to hold data for all drawn rects
         function Box()
         {
            this.x = 0;
            this.y = 0;
            this.w = 1; // default width and height?
            this.h = 1;
            this.textarea1 = null;
            this.font = '20px Gulim';
            this.page = 0;
            this.visible = 1;
            this.ftcolor = "#000000";
            this.bgcolor = "#000000";
            this.brcolor = "#000000";
            this.align = 0;
            this.form = 0;
            this.alpha = 0;
         }

         //Initialize a new Box, add it, and invalidate the canvas
         function addRect(x, y, w, h, textarea1, font, page, visible, ftcolor, bgcolor, brcolor, align, form, alpha)
         {
            var rect = new Box;
            rect.x = x;
            rect.y = y;
            rect.w = w;
            rect.h = h;
            rect.textarea1 = textarea1;
            rect.font= font || '20px Gulim';
            rect.page = page;
            rect.visible = visible|| 1;
            rect.ftcolor = ftcolor || "#000000";
            rect.bgcolor = bgcolor || "#000000";
            rect.brcolor = bgcolor || "#000000";
            rect.align = align || 0 ;
            rect.form = form || 0 ;
            rect.alpha = alpha || 0;
            console.log("에드 글내용 "+rect.textarea1);

            if(rect.textarea1!=""){


               if(Vtx==false){
                  if(rect.textarea1=="null"){
                       rect.textarea1 = "";
                         boxes.push(rect);
                  }else{
                     boxes.push(rect);
                  }
               }else{
                  boxes[index].x=x;
                  boxes[index].y=y;
                  boxes[index].w=w;
                  boxes[index].h=h;
                  boxes[index].textarea1=textarea1;
                  boxes[index].font=font;
                  boxes[index].page = page;
                  boxes[index].visible = visible;
                  boxes[index].ftcolor = ftcolor;
                  boxes[index].bgcolor = bgcolor;
                  boxes[index].brcolor = brcolor;
                  boxes[index].align = align;
                  boxes[index].form = form;
                  boxes[index].alpha = alpha;
                  Vtx=false;
               }

            }


         }

         function trim(txt)
         {
             return txt.replace(/(^\s*)|(\s*$)/g, "");
         }



         function invalidate()
         {
            canvasValid = false;
           // console.log("인발리 ");
         }

         function invalidate1()
         {
            canvasValid1 = false;
           // console.log("인발리 ");
         }

         function draw()
         {
            if (canvasValid == false)
            {
               context.clearRect(0, 0, tmp_canvas.width, tmp_canvas.height);

               // Add stuff you want drawn in the background all the time here
               // draw all boxes
               var l = boxes.length;
               console.log("박스 갯수는"+l);
               for (var i = 0; i < l; i++)
               {  //console.log("지금 페이지"+nowpage);console.log("지금 박스 페이지"+boxes[i].page);
                  if(nowpage==boxes[i].page){
                	  if(boxes[i].visible==1){
 					  if(boxes[i].form!=3){
                    drawshape(context, boxes[i], boxes[i].textarea1, boxes[i].font, boxes[i].ftcolor, boxes[i].bgcolor, boxes[i].brcolor );
 					  }else{
 						var image = new Image();
 						image.src = boxes[i].textarea1;
 						context.drawImage(image, boxes[i].x, boxes[i].y, boxes[i].w, boxes[i].h);
 						invalidate();
 						invalidate1();
 					  }
                		  }
                     }


                  //image.src= "upload/pcc0.jpg";


               }
               canvasValid = true;

               // draw selection
               // right now this is just a stroke along the edge of the selected box
               if (mySel != null)
               {

            	  context.strokeStyle = '#FF0000';
                  context.strokeRect(mySel.x, mySel.y, mySel.w, mySel.h);

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
                    	 context.fillStyles = '#FF0000';
                        context.fillRect(selectionHandlesX[i], selectionHandlesY[i], mySelBoxSize, mySelBoxSize);
                      }

               }
               else
               {

               }

            }/// if문 끝
         }

         function drawshape(context, shape, textarea1, font, ftcolor, bgcolor, brcolor )
         {
            // We can skip the drawing of elements that have moved off the screen:
            if (shape.x > tmp_canvas.width || shape.y > tmp_canvas.height) return;
            if (shape.x + shape.w < 0 || shape.y + shape.h < 0) return;
			var bgcount=0;
			var brcount=0;
            var lines = textarea1.split('\n');
            var ftsize=0;
            var ftct=0;
        	var tempfont=font.split(" ");

			if(tempfont[0]=="italic"){
      			if(tempfont[1]=="bold"){       //이탤릭 볼드
     				var a=font.substring(font.indexOf("bold")+5,font.indexOf("px"));
    				ftsize=a;
      				ftct++;
      			}
      		}

      		if(tempfont[0]=="bold"){
      			if(tempfont[1]=="italic"){       //볼드 이탤릭
      				var a=font.substring(font.indexOf("italic")+7,font.indexOf("px"));

      				ftsize=a;
      				ftct++;
      			}
      		}

      		if(tempfont[0]=="bold"){
      			if(tempfont[1]!="italic"){       //볼드
      				var a=font.substring(font.indexOf("bold")+5,font.indexOf("px"));
      				ftsize=a;
      				ftct++;
      			}
      		}

      		if(tempfont[0]=="italic"){
      			if(tempfont[1]!="bold"){       //이탤릭
      				var a=font.substring(font.indexOf("italic")+7,font.indexOf("px"));

      				ftsize=a;
      				ftct++;
      			}
      		}

			if(ftct==0){        //그냥
				var a=font.substring(0,font.indexOf("px"));
				ftsize=a;
			}



		       	var  strlen=[];
	        	for (var i = 0; i < lines.length; i++){                   //문자열 마다 길이 구하기

	        		for (var j=0; j< lines[i].length; j++){
	        	    	// alert(lines[i].charCodeAt(j));
	        	    	 if(lines[i].charCodeAt(j)>=32&&lines[i].charCodeAt(j)<=64){  //특수문자~숫자
	        	    		 if(typeof(strlen[i])!="undefined"){
	        	    			 strlen[i]=parseInt(ftsize)/1.9+strlen[i];
	        	    		 } else{
	        	    			 strlen[i]= parseInt(ftsize);
	        	    		 }
	        	    	 }else if(lines[i].charCodeAt(j)>=65&&lines[i].charCodeAt(j)<=90){  //대문자
	        	    		 if(typeof(strlen[i])!="undefined"){
	        	    		 strlen[i]=parseInt(ftsize)/1.6+strlen[i];
	        	    		 }else{
	        	    			 strlen[i]= parseInt(ftsize);
	        	    		 }
	        	    	 }else if(lines[i].charCodeAt(j)>=97&&lines[i].charCodeAt(j)<=122){  //소문자
	        	    		 if(typeof(strlen[i])!="undefined"){
	        	    			 strlen[i]=parseInt(ftsize)/1.9+strlen[i];
	        	    		 }else{
	        	    			 strlen[i]= parseInt(ftsize);
	        	    		 }
	        	    	 }else{
	        	    		 if(typeof(strlen[i])!="undefined"){
	        	    			 strlen[i]=parseInt(ftsize)+strlen[i];
	        	    		 }else{
	        	    			 strlen[i]= parseInt(ftsize);
	        	    		 }
	        	    	 }
	        	     }

	            }

            for (var i = 0; i < lines.length; i++)       //줄바꿈 으로 검색해서 라인으로 그림
            {
            	if(shape.form!=3){
            	//alert(strlen[i]);
         		if(bgcount==0){
           		if(bgcolor!="none"){
           		var tempAlpha = shape.alpha/100;

           		context.globalAlpha = 1- tempAlpha;

           		context.fillStyle = bgcolor;
           		context.fillRect(shape.x,shape.y,shape.w,shape.h);
           		context.fillStyle = "";
           		bgcount++;
           		context.globalAlpha = 1;
           			}
           		}

         		if(brcount==0){
           		if(brcolor!="none"){
           		context.strokeStyle = brcolor;
           		context.strokeRect(shape.x,shape.y,shape.w,shape.h);
           		context.strokeStyle = "";
           		brcount++;
           			}
         		}

        		context.fillStyle = ftcolor;
    			context.font=font;
         		if(shape.align==0){
            		var tempAlpha = shape.alpha/100;
               		context.globalAlpha = 1- tempAlpha;
               		if(!(lines[i].indexOf("@n@")>-1)){

         			context.fillText(lines[i], shape.x, shape.y + (i * parseInt(ftsize))+ parseInt(ftsize));
               		}else{
               			var nlines = lines[i].split("@n@");
               			for(var z=0;z<nlines.length;z++){
               				context.fillText(nlines[z], shape.x, shape.y + (z * parseInt(ftsize))+ parseInt(ftsize));

               			}
               		}
         			context.globalAlpha = 1;
           		}else if(shape.align==1){
            		var tempAlpha = shape.alpha/100;
               		context.globalAlpha = 1- tempAlpha;
               		if(!(lines[i].indexOf("@n@")>-1)){

                context.fillText(lines[i], (shape.x+(shape.w/2))-strlen[i]/2, shape.y + (i * parseInt(ftsize))+ parseInt(ftsize)  );
               		}else{
               			var nlines = lines[i].split("@n@");
               			for(var z=0;z<nlines.length;z++){
               			// var eee= sumlen(nlines[z],parseInt(ftszie));
               			    var eee=parseInt(sumstr(nlines[z],ftsize));

               				context.fillText(nlines[z], (shape.x+(shape.w/2))-eee/2, shape.y + (z * parseInt(ftsize))+ parseInt(ftsize));

               			}

               		}

               		context.globalAlpha = 1;
           		}else if(shape.align==2){
            		var tempAlpha = shape.alpha/100;
               		context.globalAlpha = 1- tempAlpha;
               		if(!(lines[i].indexOf("@n@")>-1)){
           		    context.fillText(lines[i], shape.x+shape.w-strlen[i], shape.y + (i * parseInt(ftsize))+ parseInt(ftsize));
               		}else{
               			var nlines = lines[i].split("@n@");
               			for(var z=0;z<nlines.length;z++){
               			    var eee=parseInt(sumstr(nlines[z],ftsize));

               				context.fillText(nlines[z], shape.x+shape.w-eee, shape.y + (z * parseInt(ftsize))+ parseInt(ftsize));

               			}

               		}


           		    context.globalAlpha = 1;
           		}


                invalidate1();
            	}
            }

      	  //console.log("폼 종류는"+boxes[i].form);
   	/*		if(shape.form==3){
   			   var image=new Image();
   			   image.src= trim(textarea1);
   			   context.drawImage(image, shape.x,  shape.y, shape.w, shape.h);

   			} */


            //ftsize=0;
            bgcount=0;
            brcount=0;

            // str='ABC';
        	//alert(str.charCodeAt(0));


         }










        <%
        for (int ss=0; ss< objcount; ss++){
        //	for(int ss=objcount-1; ss>= 0; ss--){
       	 /* System.out.println("x값 "+passing.get(ss).x);
        	  System.out.println("y값 "+passing.get(ss).y);
        	  System.out.println("w값 "+passing.get(ss).w);
        	  System.out.println("h값 "+passing.get(ss).h);
        	  System.out.println("txt값 "+passing.get(ss).txt);
        	  System.out.println("fontsize값 "+passing.get(ss).fontSize);
        	  System.out.println("page값 "+passing.get(ss).page);
        	  System.out.println("algin값 "+passing.get(ss).align);
        	  System.out.println("form  "+passing.get(ss).form);
        	  System.out.println("ftcolor  "+passing.get(ss).ftcolor);
        	  System.out.println("bgcolor  "+passing.get(ss).bgcolor);
        	  System.out.println("alpha  "+passing.get(ss).alpha);  */
        %>


        <%//if(ShapePage.get(ss)==0){%>
        addRect(<%=passing.get(ss).x%>,
     		   <%=passing.get(ss).y%>,
     		   <%=passing.get(ss).w%>,
     		   <%=passing.get(ss).h%>,
     		   "<%=passing.get(ss).txt%>",
     		   <%=passing.get(ss).fontSize%>+"px Gulim",
     		   <%=passing.get(ss).page%>,
     		   1,
     		   "<%=passing.get(ss).ftcolor%>",
     		   "<%=passing.get(ss).bgcolor%>",
     		   "<%=passing.get(ss).brcolor%>",
     	        <%=passing.get(ss).align%>,
     			<%=passing.get(ss).form%>,
     			<%=passing.get(ss).alpha%>
        );
        invalidate();
        invalidate1();


     <%
        }
     %>


      </script>









	<script type="text/javascript">

var canv = new Array();
var sscanvas= new Array();
var sscontext= new Array();
var menu= new Array();
var menu_style= new Array();
var delindex = 0;

var aSlide=<%=startSlide%>;
function check_button_slide(){

	eval("document.getElementById('test').insertRow().insertCell().innerHTML='<div id=menu"+aSlide+" class=menu></div>';");
	 //var cavnv = document.createElement('canvas');
    // canv[0]=document.createElement('canvas');
	eval(" canv["+aSlide+"] = document.createElement('canvas');");
	eval("canv["+aSlide+"].id = 'ssCanvas"+aSlide+"';");

	eval("document.getElementById('menu"+aSlide+"').appendChild(canv["+aSlide+"]);");

	eval(" sscanvas["+aSlide+"] = document.querySelector('#ssCanvas"+aSlide+"');");
	eval(" sscontext["+aSlide+"] = sscanvas["+aSlide+"].getContext('2d');");


	eval("  menu"+aSlide+" = document.querySelector('.menu');");
	eval("  menu_style"+aSlide+" = getComputedStyle(menu"+aSlide+");");
	eval(" sscanvas["+aSlide+"].width = parseInt(menu_style"+aSlide+".getPropertyValue('width'));");
	eval(" sscanvas["+aSlide+"].height = parseInt(menu_style"+aSlide+".getPropertyValue('height'));");

	//  eval("sscontext["+aSlide+"].fillText('2222',10,10);");

	eval("sscanvas["+aSlide+"].addEventListener('mousedown', function (e) { nowpage="+aSlide+";    invalidate();   }, false);");

	aSlide++;

}


function del_button_slide(){
	livepagecount=0;
	document.getElementById('test').rows[nowpage].style.display = 'none';

	var TableLen =  document.getElementById('test').rows.length;

	//alert(" 행의 수 : " + TableLen);

	for(var i=0;i<TableLen;i++){
		if('none'!=document.getElementById('test').rows[i].style.display){
			livepagecount++;

		}
	}
	//alert("살아있는 페이지 갯수"+livepagecount);

    for(var i=0;i<boxes.length;i++){
    	if(boxes[i].page==nowpage){
    		boxes[i].visible=0;
    	}
    }


}







<% for(int j=0;j<slideCount;j++){ %>

 sscanvas[<%=j%>] = document.querySelector('#ssCanvas<%=j%>');
 sscontext[<%=j%>] = sscanvas[<%=j%>].getContext('2d');
var menu<%=j%> = document.querySelector('.menu');
var menu_style<%=j%> = getComputedStyle(menu<%=j%>);
sscanvas[<%=j%>].width = parseInt(menu_style<%=j%>.getPropertyValue('width'));
sscanvas[<%=j%>].height = parseInt(menu_style<%=j%>.getPropertyValue('height'));

sscanvas[<%=j%>].addEventListener('mousedown', function (e)
        {   nowpage=<%=j%>;

         invalidate();
        }, false);
<%}%>





function slideDraw(){
    if (canvasValid1 == false){
       for(var i=0; i< aSlide ;i++){
       eval("sscontext["+i+"].clearRect(0, 0, sscanvas["+i+"].width, sscanvas["+i+"].height);");
       }


       for(var i=0; i< boxes.length;i++){
    	   if(boxes[i].form!=3){
        var temptxt = boxes[i].textarea1.split('\n');

        var bgcount=0;
    	var brcount=0;
        var ftsize=0;
        var ftct=0;
        var font=0;
    	var tempfont=boxes[i].font.split(" ");

       	var  strlen=[];

    	if(tempfont[0]=="italic"){
    			if(tempfont[1]=="bold"){       //이탤릭 볼드
    				var a=boxes[i].font.substring(boxes[i].font.indexOf("bold")+5,boxes[i].font.indexOf("px"));
    				ftsize=a;
    				font=boxes[i].font.substring(boxes[i].font.indexOf("px")+3,boxes[i].font.length);
    				font="italic bold "+parseInt(ftsize/3)+"px "+boxes[i].font.substring(boxes[i].font.indexOf("px")+3,boxes[i].font.length);
    				ftct++;
    			}
    		}

    		if(tempfont[0]=="bold"){
    			if(tempfont[1]=="italic"){       //볼드 이탤릭
    				var a=boxes[i].font.substring(boxes[i].font.indexOf("italic")+7,boxes[i].font.indexOf("px"));
    				ftsize=a;
    				font=boxes[i].font.substring(boxes[i].font.indexOf("px")+3,boxes[i].font.length);
    				font="bold italic "+parseInt(ftsize/3)+"px "+boxes[i].font.substring(boxes[i].font.indexOf("px")+3,boxes[i].font.length);
    				ftct++;
    			}
    		}

    		if(tempfont[0]=="bold"){
    			if(tempfont[1]!="italic"){       //볼드
    				var a=boxes[i].font.substring(boxes[i].font.indexOf("bold")+5,boxes[i].font.indexOf("px"));
    				ftsize=a;
    				font=boxes[i].font.substring(boxes[i].font.indexOf("px")+3,boxes[i].font.length);
    				font="bold "+parseInt(ftsize/3)+"px "+boxes[i].font.substring(boxes[i].font.indexOf("px")+3,boxes[i].font.length);
    				ftct++;
    			}
    		}

    		if(tempfont[0]=="italic"){
    			if(tempfont[1]!="bold"){       //이탤릭
    				var a=boxes[i].font.substring(boxes[i].font.indexOf("italic")+7,boxes[i].font.indexOf("px"));
    				ftsize=a;
    				font=boxes[i].font.substring(boxes[i].font.indexOf("px")+3,boxes[i].font.length);

    				font="italic "+parseInt(ftsize/3)+"px "+boxes[i].font.substring(boxes[i].font.indexOf("px")+3,boxes[i].font.length);

    				ftct++;
    			}
    		}

    	if(ftct==0){        //그냥
    		var a=boxes[i].font.substring(0,boxes[i].font.indexOf("px"));
    		ftsize=a;
			font=boxes[i].font;
			//font.replace(ftsize+"px",parseInt(ftsize)/3+"px");

			//alert(parseInt(ftsize/3));
			font=parseInt(ftsize/3)+"px "+boxes[i].font.substring(boxes[i].font.indexOf("px")+3,boxes[i].font.length);
    	}

    	ftct=0;

       	for (var o = 0; o < temptxt.length; o++){                   //문자열 마다 길이 구하기
   	     for (var j=0; j< temptxt[o].length; j++){
   	    	//alert(lines[i].charCodeAt(j));
   	    	 if(temptxt[o].charCodeAt(j)>=33&&temptxt[o].charCodeAt(j)<=64){  //특수문자~숫자
   	    		 if(typeof(strlen[o])!="undefined"){
   	    			 strlen[o]=parseInt(ftsize)/1.9+strlen[o];
   	    		 } else{
   	    			 strlen[o]= parseInt(ftsize);
   	    		 }
   	    	 }else if(temptxt[o].charCodeAt(j)>=65&&temptxt[o].charCodeAt(j)<=90){  //대문자
   	    		 if(typeof(strlen[o])!="undefined"){
   	    		 strlen[o]=parseInt(ftsize)/1.6+strlen[o];
   	    		 }else{
   	    			 strlen[o]= parseInt(ftsize);
   	    		 }
   	    	 }else if(temptxt[o].charCodeAt(j)>=97&&temptxt[o].charCodeAt(j)<=122){  //소문자
   	    		 if(typeof(strlen[o])!="undefined"){
   	    			 strlen[o]=parseInt(ftsize)/1.9+strlen[o];
   	    		 }else{
   	    			 strlen[o]= parseInt(ftsize);
   	    		 }
   	    	 }else{
   	    		 if(typeof(strlen[o])!="undefined"){
   	    			 strlen[o]=parseInt(ftsize)+strlen[o];
   	    		 }else{
   	    			 strlen[o]= parseInt(ftsize);
   	    		 }
   	    	 }

   	     }
       }



 		if(boxes[i].bgcolor!="none"){
 			eval("var tempAlpha = boxes[i].alpha/100;");
       		eval("sscontext["+boxes[i].page+"].globalAlpha=1-tempAlpha;");
       	    eval("sscontext["+boxes[i].page+"].fillStyle=boxes["+i+"].bgcolor;");

         	eval("sscontext["+boxes[i].page+"].fillRect(boxes["+i+"].x/3, boxes["+i+"].y/3, boxes["+i+"].w/3, boxes["+i+"].h/3);");

         	eval("sscontext["+boxes[i].page+"].globalAlpha=1;");
       		}

       		if(boxes[i].brcolor!="none"){

       	    eval("sscontext["+boxes[i].page+"].strokeStyle=boxes["+i+"].brcolor;");

         	eval("sscontext["+boxes[i].page+"].strokeRect(boxes["+i+"].x/3, boxes["+i+"].y/3, boxes["+i+"].w/3, boxes["+i+"].h/3);");


       		}

      eval("sscontext["+boxes[i].page+"].font=font;");
      eval("sscontext["+boxes[i].page+"].fillStyle=boxes["+i+"].ftcolor;");

      for(var j=0;j<temptxt.length;j++){
    	  //alert(strlen[j]);






    	  if(boxes[i].align==0){
    		  if(!(boxes[i].textarea1.indexOf("@n@")>-1)){
    			  eval("sscontext["+boxes[i].page+"].fillText(temptxt["+j+"], boxes["+i+"].x/3,(boxes["+i+"].y/3)+("+j+"*"+(parseInt(ftsize)/3)+")+"+(parseInt(ftsize)/3)+");");
    		  }else{
       			var nlines = boxes[i].textarea1.split("@n@");
     			for(var z=0;z<nlines.length;z++){
     				  eval("sscontext["+boxes[i].page+"].fillText(nlines["+z+"], boxes["+i+"].x/3,(boxes["+i+"].y/3)+("+z+"*"+(parseInt(ftsize)/3)+")+"+(parseInt(ftsize)/3)+");");
     				}
    		 	 }
    		  }else if(boxes[i].align==1){

    			  if(!(boxes[i].textarea1.indexOf("@n@")>-1)){
    				  eval("sscontext["+boxes[i].page+"].fillText(temptxt["+j+"], (boxes["+i+"].x/3)+((boxes["+i+"].w/3)/2)-(((strlen["+j+"])/3)/2),(boxes["+i+"].y/3)+("+j+"*"+(parseInt(ftsize)/3)+")+"+(parseInt(ftsize)/3)+");");

    			  }else{
    	       			var nlines = boxes[i].textarea1.split("@n@");
    	     			for(var z=0;z<nlines.length;z++){

    	     				  var eee=parseInt(sumstr(nlines[z],ftsize));

    	     				  eval("sscontext["+boxes[i].page+"].fillText(nlines["+z+"], (boxes["+i+"].x/3)+((boxes["+i+"].w/3)/2)-((("+eee+")/3)/2),(boxes["+i+"].y/3)+("+z+"*"+(parseInt(ftsize)/3)+")+"+(parseInt(ftsize)/3)+");");
    	     				}
    	    		 	 }
    		 	}else if(boxes[i].align==2){
    		 		 if(!(boxes[i].textarea1.indexOf("@n@")>-1)){
    		 			eval("sscontext["+boxes[i].page+"].fillText(temptxt["+j+"], (boxes["+i+"].x/3)+(boxes["+i+"].w/3)-((strlen["+j+"])/3),(boxes["+i+"].y/3)+("+j+"*"+(parseInt(ftsize)/3)+")+"+(parseInt(ftsize)/3)+");");

    		 		 }else{
    	       			var nlines = boxes[i].textarea1.split("@n@");
    	     			for(var z=0;z<nlines.length;z++){
  	     				  var eee=parseInt(sumstr(nlines[z],ftsize));

    	     				  eval("sscontext["+boxes[i].page+"].fillText(nlines["+z+"], (boxes["+i+"].x/3)+(boxes["+i+"].w/3)-(("+eee+")/3),(boxes["+i+"].y/3)+("+z+"*"+(parseInt(ftsize)/3)+")+"+(parseInt(ftsize)/3)+");");
    	     				}
    	    		 	 }

        	 }
      	}
      }       if(boxes[i].form==3){


   			 eval("var image=new Image();");
   			 eval("image.src= trim(boxes["+i+"].textarea1);");
   			  eval("sscontext["+boxes[i].page+"].drawImage(image, (boxes["+i+"].x/3),(boxes["+i+"].y/3),(boxes["+i+"].w/3),(boxes["+i+"].h/3));");
   			}
       canvasValid1=true;
       }
   }
}




setInterval(slideDraw, INTERVAL);

function alpha_Function(selectObj){
//	alert(selectObj.value + "가 선택 되었습니다.");
	if(mySel!=null){

		boxes[index].alpha=selectObj.value;
	}
}
function fontsize_Function(selectObj){

	var tempfont=boxes[index].font.split(" ");
	var ftct=0;
//	alert(selectObj.value + "가 선택 되었습니다.");
	var temp;
//	alert(boxes[index].font.indexOf("px"));

	if(mySel!=null){
      		if(tempfont[0]=="italic"){
      			if(tempfont[1]=="bold"){       //이탤릭 볼드
     				var a=boxes[index].font.substring(boxes[index].font.indexOf("bold")+5,boxes[index].font.indexOf("px"));
    				//alert("이탤릭볼드"+a);
      			    temp=boxes[index].font.replace(a, selectObj.value);
    				boxes[index].font=temp;
      				ftct++;
      			}
      		}

      		if(tempfont[0]=="bold"){
      			if(tempfont[1]=="italic"){       //볼드 이탤릭
      				var a=boxes[index].font.substring(boxes[index].font.indexOf("italic")+7,boxes[index].font.indexOf("px"));
    				//alert("볼드 이탤릭"+a);
      			    temp=boxes[index].font.replace(a, selectObj.value);
    				boxes[index].font=temp;
      				ftct++;
      			}
      		}

      		if(tempfont[0]=="bold"){
      			if(tempfont[1]!="italic"){       //볼드
      				var a=boxes[index].font.substring(boxes[index].font.indexOf("bold")+5,boxes[index].font.indexOf("px"));
    				//alert("볼드"+a);
      			    temp=boxes[index].font.replace(a, selectObj.value);
    				boxes[index].font=temp;
      				ftct++;
      			}
      		}

      		if(tempfont[0]=="italic"){
      			if(tempfont[1]!="bold"){       //이탤릭
      				var a=boxes[index].font.substring(boxes[index].font.indexOf("italic")+7,boxes[index].font.indexOf("px"));
    				//alert("볼드 이탤릭"+a);
      			    temp=boxes[index].font.replace(a, selectObj.value);
    				boxes[index].font=temp;
      				ftct++;
      			}
      		}

			if(ftct==0){        //그냥
				var a=boxes[index].font.substring(0,boxes[index].font.indexOf("px"));
				temp=boxes[index].font.replace(a, selectObj.value);
				boxes[index].font=temp;
			}

			boldct=0;

	}
	//alert(boxes[index].font.substring(0,boxes[index].font.indexOf("px")));
	//alert(boxes[index].font);

    invalidate();
    invalidate1();
}

function fontselect_Function(selectObj){
	 //alert(selectObj.value + "가 선택 되었습니다.");

	 if(mySel!=null){
		 var a=boxes[index].font.substring(boxes[index].font.indexOf("px")+3,boxes[index].font.length);
			//alert(a);
		 temp=boxes[index].font.replace(a, selectObj.value);
			boxes[index].font=temp;
		 }

    invalidate();
    invalidate1();
}

function fontcolor_Function(selectObj) {
	//this.style.backgroundColor=this.options[this.selectedIndex].style.backgroundColor;
	// alert(selectObj.value + "가 선택 되었습니다.");

	 var e = document.getElementById("font_color");
	// var strUser = e.options[e.selectedIndex].value;
	//alert(strUser);
	 e.style.color=selectObj.value ;

	 if(mySel!=null){
	 boxes[index].ftcolor = selectObj.value;
	 }

     invalidate();
     invalidate1();
	//this.style.backgroundColor=this.options[this.selectedIndex].style.backgroundColor;
	//myselect.blur();
	} // 폰트 색상 선택


	$(function(){
		//Color
		var FtColor 	 = $('#FontColor').val();
		var FillColor    = $('#FillColor').val();



		$('#FontColor').on('change', function() {

			 if(mySel!=null){
				 boxes[index].ftcolor = this.value;
				 }
		     invalidate();
		     invalidate1();
		});

		$('#FillColor').on('change', function() {

			 if(mySel!=null){
				 boxes[index].bgcolor = this.value;
				 }
		     invalidate();
		     invalidate1();
		});

	});

	function fn_clearFilePath(val){
	    var tmpStr = val;

	    var cnt = 0;
	    while(true){
	        cnt = tmpStr.indexOf("/");
	        if(cnt == -1) break;
	        tmpStr = tmpStr.substring(cnt+1);
	    }
	    while(true){
	        cnt = tmpStr.indexOf("\\");
	        if(cnt == -1) break;
	        tmpStr = tmpStr.substring(cnt+1);
	    }

	    return tmpStr;
	}


	function handleImageView(inputfiles){

	    var files=inputfiles.files
		var file = files[0];
		if(!file.type.match(/image.*/)){
		//	alert("not image file!");
		}var reader = new FileReader();
		reader.onload = function(e){
			var img = new Image();
			img.onload = function(){

				context.drawImage(img,0,0,480,320);
			}
			img.src = e.target.result;

		}
		//alert(inputfiles.value);
		reader.readAsDataURL(file);

		var imname= "upload/"+<%=(String)session.getAttribute("loginid")%>+"/"+fn_clearFilePath(inputfiles.value);
	    alert(imname);

		addRect(0,
				0,
				480,
				320,
				imname,
				"24px Gulim",
				nowpage ,
				1,
				document.getElementById("font_color").value,
				document.getElementById("border_color").value,
				  document.getElementById("background_color").value,
				  0,
				  3,
				  0);
		//alert("됬나");

		invalidate();
		invalidate1();




		var uploadFile = document.querySelector("#custromInput");

		var xhr = new XMLHttpRequest();

		xhr.open("POST", "http://localhost:8080/jspbook2/fileupload.jsp", true);
		xhr.setRequestHeader("X-File-Name", encodeURIComponent(file.name));
		 alert("성공");
		xhr.send(file);







	}
/*	function repath(inputfiles) {
		alert( inputfiles.value);
		var path =inputfiles.select();
		//var path=document.selection.createRange().text.toString();
		alert(path);
		return path;



	}*/

function background_Function(selectObj){
	 //alert("bg"+selectObj.value + "가 선택 되었습니다.");

	 var e = document.getElementById("background_color");
	// var strUser = e.options[e.selectedIndex].value;
	//alert(strUser);
	if(selectObj.value=="none"){
		 e.style.backgroundColor="#ffffff"
	}else{
	 e.style.backgroundColor=selectObj.value ;
	}
	//this.style.backgroundColor=this.options[this.selectedIndex].style.backgroundColor;
	//myselect.blur();
	 if(mySel!=null){
		 boxes[index].brcolor = selectObj.value;
		 }
     invalidate();
     invalidate1();
	}
function border_Function(selectObj){
	 //alert(selectObj.value + "가 선택 되었습니다.");

	 var e = document.getElementById("border_color");
	// var strUser = e.options[e.selectedIndex].value;
	//alert(strUser);
	if(selectObj.value=="none"){
		 e.style.backgroundColor="#ffffff"
	}else{

	 e.style.backgroundColor=selectObj.value ;
	}
	//this.style.backgroundColor=this.options[this.selectedIndex].style.backgroundColor;
	//myselect.blur();
	 if(mySel!=null){
		 boxes[index].bgcolor = selectObj.value;
		 }
     invalidate();
     invalidate1();
	}

function align_left(){
	 if(mySel!=null){
		 boxes[index].align = 0;
		 }
	 invalidate();
     invalidate1();
}

function align_center(){
	 if(mySel!=null){
		 boxes[index].align = 1;
		 }
	invalidate();
    invalidate1();
}

function align_right(){
	 if(mySel!=null){
		 boxes[index].align = 2;
		 }
	invalidate();
    invalidate1();
}


function  sumstr(e,e1) {

	alert(e);
	alert(e1);
	var len=0;
	var size;


	for (var j=0; j< e.length; j++){
    	// alert(lines[i].charCodeAt(j));
    	 if(e.charCodeAt(j)>=32&&e.charCodeAt(j)<=64){  //특수문자~숫자
    		 if(len!=0){
    			 len=parseInt(e1)/1.9+len;
    		 } else{
    			 len= parseInt(e1);
    		 }
    	 }else if(e.charCodeAt(j)>=65&&e.charCodeAt(j)<=90){  //대문자
    		 if(len!=0){
    			 len=parseInt(e1)/1.6+len;
    		 }else{
    			 len= parseInt(e1);
    		 }
    	 }else if(e.charCodeAt(j)>=97&&e.charCodeAt(j)<=122){  //소문자
    		 if(len!=0){
    			 len=parseInt(e1)/1.9+len;
    		 }else{
    			 len= parseInt(e1);
    		 }
    	 }else{
    		 if(len!=0){
    			 len=parseInt(e1)+len;
    		 }else{
    			 len= parseInt(e1);
    		 }
    	 }
     }


		return len;

}

</script>

	<script type="text/javascript">
  $(document).ready(function() {

	  $("#btn").click(function() {

    	 livepagecount=0;

    		var TableLen =  document.getElementById('test').rows.length;

    		//alert(" 행의 수 : " + TableLen);

    		for(var i=0;i<TableLen;i++){
    			if('none'!=document.getElementById('test').rows[i].style.display){
    				livepagecount++;
    				delpagecount[delindex]=i;
    				delindex++;
    			}
    		}


      //  alert("살아있는 페이지 갯수는 몇개"+livepagecount);
       var a = new Array(boxes.length);//행(0,1,2,3)까지 총 4개

        for (var i=0; i < a.length; i++) {// 4행의 배열 세로

             a[i] ="[" + parseInt(boxes[i].x, 10) +", "+parseInt(boxes[i].y, 10)+", "+parseInt(boxes[i].w, 10)+", "+parseInt(boxes[i].h, 10)+", "+boxes[i].textarea1+", "+boxes[i].font+", "+boxes[i].page+", "+boxes[i].visible+", "+boxes[i].ftcolor+", "+boxes[i].bgcolor+", "+boxes[i].brcolor+", "+boxes[i].align+", "+boxes[i].form+", "+boxes[i].alpha+"]";

        }

		for (var m=0; m < delpagecount.length ; m++){
			                    //살아있는 페이지 갯수
			a[a.length]= "[" + delpagecount[m] + "]";
		}
		a[a.length]="["+livepagecount+"]";           //페이지갯수

		a[a.length]="[" + boxes.length + "]";       // 오브젝트갯수

		var filename="<%=filename%>";
		alert("파일이름" + filename);
		var username= <%=(String)session.getAttribute("loginid")%>;
		a[a.length]="[" + username + "]";      //파일명

		a[a.length]="[" + "<%=filename%>" + "]";      //파일명

         var string = a;
         var vParam = "test";
          $.ajax({
            url: "<%=request.getContextPath()%>/requestServlet.do",
            type: "GET",
            data: {"string":string},

            async: false,
            success: function(data) {
               //alert(data.result+"\n"+data.msg);
               var as = eval(data);
             //  alert("data:"+as[0]+"/"+as[1]);

               //alert(as);

          	  document.saveForm.hid1.value=as[2];
        	  document.saveForm.hid2.value= "<%=(String)session.getAttribute("loginid")%>";

               document.saveForm.submit();
            },
            error: function(msg, error) {
               alert(error);
            }
         });




        //  alert(document.getElementById("hid_filename").value);


          delindex=0;
          livepagecount=0;
     });// end .click()

     $('body').keydown(function( event ) {

 		if(event.keyCode==46){
 			if(mySel!=null){
 			//	alert("삭제");
 				var i=index;
 				for(i;i<boxes.length;i++){
 					if(i<boxes.length){
 						boxes[i]=boxes[i+1];

 					}
 				}
 				boxes.length=boxes.length-1;
 				mySel=null;
 				invalidate();
 				invalidate1();
 			}
 		}


 	});





  });
  //end jQuery ready




</script>


	</div>

</body>

</html>
