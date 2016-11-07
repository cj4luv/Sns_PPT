<%@page import="javax.sql.rowset.spi.SyncFactory"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*"%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"> 
<%@page import="java.io.File"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.awt.Color"%>
<%@page import="java.awt.Dimension"%>
<%@page import="java.awt.Graphics2D"%>
<%@page import="java.awt.geom.Rectangle2D"%>
<%@page import="java.awt.image.BufferedImage"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="java.io.IOException"%>
<%@page import="javax.imageio.ImageIO"%>
<%@page import="org.apache.poi.hslf.model.Slide"%>
<%@page import="org.apache.poi.hslf.usermodel.SlideShow"%>
<% request.setCharacterEncoding("utf-8"); %> 

 
<% 
//String username= (String)session.getAttribute("loginid"); 	
String filename = request.getParameter("hid1");
String filename1 = request.getParameter("hid1")+".ppt";
String writername = request.getParameter("hid2");
System.out.println("파일이름"+filename);
System.out.println("파일사람이름"+writername);
   File filedir = new File("C:\\apache-tomcat-7.0.72\\webapps\\jspbook2\\upload\\", writername);
if(!filedir.exists()){
	filedir.mkdir();
 }

   File imgdir = new File("C:\\apache-tomcat-7.0.72\\webapps\\jspbook2\\upload\\"+writername+"\\", "img");
if(!imgdir.exists()){
    imgdir.mkdir();
 }


   String saveDir = "C:\\apache-tomcat-7.0.72\\webapps\\jspbook2\\upload\\"+writername;



//데이터베이스 연결관련 변수 선언 
Connection conn = null; 
PreparedStatement pstmt = null; 
Statement stmt =null; 
ResultSet rs=null; 
//데이터베이스 연결관련정보를 문자열로 선언 
String jdbc_driver = "com.mysql.jdbc.Driver"; 
String jdbc_url = "jdbc:mysql://127.0.0.1/jspdb"; 


Slide[] slide=null;

///ppt jpg 작업
if(filename1.contains(".ppt")){
   String pptFile = "C:\\apache-tomcat-7.0.72\\webapps\\jspbook2\\upload\\"+writername+"\\"+filename+".ppt";
   String cvtImgFile = "C:\\apache-tomcat-7.0.72\\webapps\\jspbook2\\upload\\"+writername+"\\img\\";
		
	System.out.println("파일이름1"+pptFile);
	System.out.println("파일이름"+cvtImgFile);
	// PPT파일
	FileInputStream is = new FileInputStream(pptFile);

	SlideShow ppt = new SlideShow(is);

	// PPT파일 닫기
	is.close();

	Dimension pgsize = ppt.getPageSize();

	 slide = ppt.getSlides();

	for (int i = 0; i < slide.length; i++) {

		BufferedImage img = new BufferedImage(pgsize.width, pgsize.height,
				BufferedImage.TYPE_INT_RGB);
		Graphics2D graphics = img.createGraphics();
		// 이미지 영역을 클리어
		graphics.setPaint(Color.white);
		graphics.fill(new Rectangle2D.Float(0, 0, pgsize.width,
				pgsize.height));

		// 이미지 그리기
		slide[i].draw(graphics);

		// 파일로 저장
		FileOutputStream oout = new FileOutputStream(cvtImgFile+filename+(i + 1)+ "."+"jpg");
		ImageIO.write(img, "jpg", oout);
		oout.close();
	}
}

try{ 
// JDBC 드라이버 로드 
Class.forName(jdbc_driver); 
// 데이터베이스 연결정보를 이용해 Connection 인스턴스 확보 
conn = DriverManager.getConnection(jdbc_url,"jspbook","1234"); 
long now = System.currentTimeMillis();  // 시간 

String sql1="SELECT max(boardno) FROM jspdb.board"; 
stmt=conn.createStatement();                
rs=stmt.executeQuery(sql1);			 
rs.next(); 
int boardno=(rs.getInt(1)+1); 
String sql2 = "insert into board values(?,?,?,?,?,?,?)"; 
 		pstmt = conn.prepareStatement(sql2); 
 		pstmt.setInt(1, boardno); 
 		pstmt.setString(2,writername); 
 		pstmt.setString(3,filename); 
 		pstmt.setString(4,writername+"수정본"); 
 		pstmt.setLong(5,now); 
 		pstmt.setString(6,filename+".ppt"); 

 		pstmt.setInt(7,slide.length); 
 		// username 값을 입력한 경우 sql 문장을 수행. 
 		
 		pstmt.executeUpdate(); 
		 
 	} 
	catch(Exception e) { 
 		System.out.println(e); 
	} 
 conn.close();     
	




response.sendRedirect("index.jsp"); 
%> 
   
