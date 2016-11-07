<%@page contentType="text/html;charset=utf-8" %>
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
<%@page import="org.apache.poi.hwpf.HWPFDocument"%>
<%@page import="org.apache.poi.hwpf.extractor.WordExtractor"%>
<%@page import="org.apache.poi.hwpf.usermodel.Range"%>
<%@page import="org.apache.poi.poifs.filesystem.POIFSFileSystem"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<title>Insert title here</title>
</head>
<body>
 

<%

		String o_name="Hellopoi.ppt";

		String pptFile = "C:\\Users\\ParkYoonJae\\git\\SnsPPT\\jspbook\\war\\upload\\"+o_name;
		String cvtImgFile = "C:\\Users\\ParkYoonJae\\git\\SnsPPT\\jspbook\\war\\upload\\img\\";
 		
		// PPT파일
		FileInputStream is = new FileInputStream(pptFile);
 
		SlideShow ppt = new SlideShow(is);
 		
		// PPT파일 닫기
		is.close();
 
		Dimension pgsize = ppt.getPageSize();
 
		Slide[] slide = ppt.getSlides();
 
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
			FileOutputStream oout = new FileOutputStream(cvtImgFile +o_name.substring(0, o_name.length()-3)+(i + 1)
					+ "."+"jpg");
			ImageIO.write(img, "jpg", oout);
			oout.close();
		}
	
	
	%>
</body>
</html>