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

<!DOCTYPE html>
<html>


<head>

  <meta charset="UTF-8">

  <title>martin</title>

    <link rel="stylesheet" href="css/style.css" media="screen" type="text/css" />

</head>
<script src="http://code.jquery.com/jquery-1.5.js">
</script>
<script>

var agt = navigator.userAgent.toLowerCase();
if (agt.indexOf("chrome") != -1) {
	
	
}else{
	alert("Chrome 브라우져만 지원합니다.");
	location.href ="index.jsp";
}

var url = location.toString();
var sp1 = url.split('?');
var eqSp1 = sp1[1].split('=');

var sp2 = url.split('?');
var eqSp2 = sp2[2].split('=');



</script>
<FORM METHOD="POST" NAME="testform" action="cavers.jsp">
   <INPUT TYPE="hidden" NAME="hid1" VALUE="아무것도 안나와요">
      <INPUT TYPE="hidden" NAME="hid2" VALUE="아무것도 안나와요">
</FORM>





</body>
 <script type="text/javascript">
	
	document.testform.hid1.value=eqSp1[1];
	document.testform.hid2.value=eqSp2[1];
	
	document.testform.submit();
	
</script>
</html>