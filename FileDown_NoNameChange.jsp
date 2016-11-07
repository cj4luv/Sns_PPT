<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*"%>
<%@ page import="java.text.*" %>
<%@ page import="java.lang.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.net.*" %>
<%
request.setCharacterEncoding("UTF-8");
response.setCharacterEncoding("UTF-8");
// 파일이 저장될 경로.
   String realPath = "C:\\apache-tomcat-7.0.72\\webapps\\jspbook2\\upload";

// 파일 이름이 파라미터로 넘어오지 않으면 리다이렉트 시킨다.
if(request.getParameter("fileName") == null || "".equals(request.getParameter("fileName"))){

	response.sendRedirect("/redirect.jsp");

}else{

	// 파라미터로 받은 파일 이름.
	String requestFileNameAndPath = request.getParameter("fileName");
	
	// 서버에서 파일찾기 위해 필요한 파일이름(경로를 포함하고 있음)
	// 한글 이름의 파일도 찾을 수 있도록 하기 위해서 문자셋 지정해서 한글로 바꾼다.
	String UTF8FileNameAndPath = new String(requestFileNameAndPath.getBytes("8859_1"), "UTF-8");
	
	// 파일이름에서 path는 잘라내고 파일명만 추출한다.
	String UTF8FileName = UTF8FileNameAndPath.substring(UTF8FileNameAndPath.lastIndexOf("/") + 1).substring(UTF8FileNameAndPath.lastIndexOf(File.separator) + 1);
	
	// 브라우저가 IE인지 확인할 플래그.
	boolean MSIE = request.getHeader("user-agent").indexOf("MSIE") != -1;
	
	// 파일 다운로드 시 받을 때 저장될 파일명
	String fileNameToSave = "";

	// IE,FF 각각 다르게 파일이름을 적용해서 구분해주어야 한다.
	if(MSIE){
		// 브라우저가 IE일 경우 저장될 파일 이름
		// 공백이 '+'로 인코딩된것을 다시 공백으로 바꿔준다.
		fileNameToSave = URLEncoder.encode(UTF8FileName, "UTF8").replaceAll("\\+", " ");
	}else{
		// 브라우저가 IE가 아닐 경우 저장될 파일 이름
		fileNameToSave = new String(UTF8FileName.getBytes("UTF-8"), "8859_1");
	}

	// 다운로드 알림창이 뜨도록 하기 위해서 컨텐트 타입을 8비트 바이너리로 설정한다.
	response.setContentType("application/octet-stream");
	
	// 저장될 파일 이름을 설정한다.
	response.setHeader("Content-Disposition", "attachment; filename=\"" + fileNameToSave + "\";");
	
	// 파일패스 및 파일명을 지정한다.
	//  String filePathAndName = pageContext.getServletContext().getRealPath("/") + UTF8FileNameAndPath;
	String filePathAndName = realPath + UTF8FileNameAndPath;
	File file = new File(filePathAndName);
	
	// 버퍼 크기 설정
	byte bytestream[] = new byte[2048000];

	// response out에 파일 내용을 출력한다.
	if (file.isFile() && file.length() > 0){
		
		FileInputStream fis = new FileInputStream(file);
		BufferedInputStream bis = new BufferedInputStream(fis);
		BufferedOutputStream bos = new BufferedOutputStream(response.getOutputStream());
			
		int read = 0;
			
		while ((read = bis.read(bytestream)) != -1){
			bos.write(bytestream , 0, read);
		}
		
		bos.close();
		bis.close();
		
	}

}


%>