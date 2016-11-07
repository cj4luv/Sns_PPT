<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:include page="header.jsp" flush="false"/>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"
></script>
<%@ page import="java.util.Enumeration" %> 

<html>
<head>

<style>
body {
	background-color: #F8F8F8;
}

.container {
	width: 500px;
	background-color: #ffffff;
  	border: 1px solid;
  	border-color: #e5e6e9 #dfe0e4 #d0d1d5;
 	border-radius: 10px;
  	-moz-border-radius: 10px;
  	-webkit-border-radius: 10px;
  	-o-border-radius: 10px;
}

#Search_container {
	width: 100%;
  height: 50px;
		border: 1px solid;
		border-color: #e5e6e9 #dfe0e4 #d0d1d5;
 	border-radius: 10px;
  	-moz-border-radius: 10px;
  	-webkit-border-radius: 10px;
  	-o-border-radius: 10px;
  	 padding-right: 10px;
  padding-top: 2px;
  margin-bottom: 10px;
  	
}

.freinds_list_tit {
	border-bottom: 2px solid;
	border-color: #e5e6e9;
	margin-bottom: 10px;
}

h4 {
  text-decoration: none;
  color: #939297;
  background-color: transparent;
  font-weight: bold;
  border: none;
  font-size: 26px;
}
p {
text-decoration: none;
  color: #939297;
  
  background-color: transparent;
  border: none;
  font-size: 1em;

}
</style>

</head>
<body>
<% request.setCharacterEncoding("utf-8"); %>

<%
int cont=0;
String id = (String)session.getAttribute("loginid"); //#로그인한#id를#체크#
if (id != null) { //#로그인상태#
   // 데이터베이스 연결관련 변수 선언
   Connection conn = null;
   PreparedStatement pstmt = null;
   ResultSet rs1=null;
   ResultSet rs2=null;
   int total=0;
   // 데이터베이스 연결관련정보를 문자열로 선언
   String jdbc_driver = "com.mysql.jdbc.Driver";
   String jdbc_url = "jdbc:mysql://127.0.0.1/jspdb";
   String searchname = request.getParameter("searchname"); 
   
   try{
      // JDBC 드라이버 로드
      Class.forName(jdbc_driver);


		// 데이터베이스 연결정보를 이용해 Connection 인스턴스 확보
		conn = DriverManager.getConnection(jdbc_url,"jspbook","1234");
		String sql2 = "SELECT username FROM jspdb.jdbc_test where username like '%"+searchname+"%'";
		pstmt = conn.prepareStatement(sql2);
		rs2=pstmt.executeQuery();
		
		// username 값을 입력한 경우 sql 문장을 수행.
			
			%>
			<div class="container" >
				<div class="freinds_list_tit">
					<h4>Customer List</h4>
				</div>
				<% 
			while(rs2.next()){
				String rname=rs2.getString("username");
			 if(rname.equals(id)==false){
			%>
			<div id="Search_container"> 
			  <div class='post'>
			   <form class="navbar-form navbar-left">
			  		<p><%=rname%></p> 
				</form>
				  
				 <%String sql1 = "SELECT friend_info.username, friend_info.friend_request FROM jspdb.jdbc_test left join jspdb.friend_info on jdbc_test.username=friend_info.username where friend_info.username='"+rname+"' or friend_info.friend_request='"+rname+"'";
						pstmt = conn.prepareStatement(sql1);
						rs1=pstmt.executeQuery();
						while(rs1.next()){
							if((rs1.getString("friend_info.username").equals(id))&&(rs1.getString("friend_info.friend_request").equals(rname))){
								cont++;
							}
							if((rs1.getString("friend_info.username").equals(rname))&&(rs1.getString("friend_info.friend_request").equals(id))){
								cont++;
							}


		}
		if(cont==0){%>	
				 <form class="navbar-form navbar-right" action="process_requestFriend.jsp" method="post">
				 <input type=hidden name="friend_request" value="<%=rs2.getString("username")%>"> 
				 <button class="btn btn-default btn" type="submit"><span class="glyphicon glyphicon-plus"></span></button>
				 </form>
				 
				 </div>
				 </div>
							 <%
		} else { %>
			
			</div>
				 </div>
		<%}cont=0;
			 }
		%>	 
		<%}	 
	}
	catch(Exception e) {
		System.out.println(e);
	}
	 conn.close();    
	 pstmt.close();
	 
	  

}
%>
</div>
</body>
 </html>   

 
 
