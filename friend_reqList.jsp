<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*"%>
<%@ page import="java.util.Enumeration" %> 
<% 		
 			int count= 0;
			Connection conn = null;
			PreparedStatement pstmt = null;
		  	ResultSet rs=null;
			// 데이터베이스 연결관련정보를 문자열로 선언
			String jdbc_driver = "com.mysql.jdbc.Driver";
			String jdbc_url = "jdbc:mysql://127.0.0.1/jspdb";
			
			try{
				// JDBC 드라이버 로드
				Class.forName(jdbc_driver);


            // 데이터베이스 연결정보를 이용해 Connection 인스턴스 확보
            conn = DriverManager.getConnection(jdbc_url,"jspbook","1234");


				// Connection 클래스의 인스턴스로 부터 SQL  문 작성을 위한 Statement 준비
				String sql2 = "SELECT * FROM jspdb.friend_info where friend_request = '"+(String)session.getAttribute("loginid")+"' and friend_state=1";
				pstmt = conn.prepareStatement(sql2);
				rs=pstmt.executeQuery();
				while(rs.next()){
					count+=1;
					
				}
				rs=pstmt.executeQuery();
			}
			catch(Exception e) {
				System.out.println(e);
			}
			

 %>

<%if(count==0) {%>
    <li>친구 요청이 없습니다</li>
<%}else{

	while(rs.next()){%>	
	<li>
	<span><%=rs.getString("username")%></span> 
	<input type=hidden name="friend_rname" value="<%=rs.getString("username")%>">
	<button type="submit" class="btn btn-xs btn-primary" name="state" value=2>수락</button>
	<button type="submit" class="btn btn-xs btn-primary" name="state" value=3>거절</button>
	</li>
	<% %>


<%} %>



      <%
}
   conn.close();    
    pstmt.close();

%>