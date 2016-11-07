<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<% request.setCharacterEncoding("utf-8"); %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%

	// 데이터베이스 연결관련 변수 선언
	Connection conn = null;
	PreparedStatement pstmt = null;
	
	String state=request.getParameter("state");
	if(state==null){
		state="3";
	}
	// 데이터베이스 연결관련정보를 문자열로 선언
	String jdbc_driver = "com.mysql.jdbc.Driver";
	String jdbc_url = "jdbc:mysql://127.0.0.1/jspdb";
	String sql=null;
	try{
		// JDBC 드라이버 로드
		Class.forName(jdbc_driver);
		
		// 데이터베이스 연결정보를 이용해 Connection 인스턴스 확보
		conn = DriverManager.getConnection(jdbc_url,"jspbook","1234");
		
		if(state.equals("3")){
			 sql = "DELETE FROM jspdb.friend_info where username='"+request.getParameter("friend_rname")+"' and friend_request= '"+(String)session.getAttribute("loginid")+"'";
		
		}else{
		
		// Connection 클래스의 인스턴스로 부터 SQL  문 작성을 위한 Statement 준비
			 sql = "UPDATE jspdb.friend_info set friend_state= "+state+" where username='"+request.getParameter("friend_rname")+"' and friend_request= '"+(String)session.getAttribute("loginid")+"'";
		}
		pstmt = conn.prepareStatement(sql);
	
		// username 값을 입력한 경우 sql 문장을 수행.
		
			pstmt.executeUpdate();
		
		
	}
	catch(Exception e) {
		System.out.println(e);
	}
	 conn.close();    
	 pstmt.close();
		response.sendRedirect("index.jsp");

%>
</body>
</html>
