<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" import="java.sql.*"%>
<%@ page import="java.util.*" %>


<jsp:useBean id="example_access_user" class="java.util.ArrayList" scope="application" />

<%
int k=1;

String user_ip = request.getRemoteAddr();
String user_id = (session.getAttribute("loginid")==null)?"":session.getAttribute("loginid")+"";

HashMap user_info = new HashMap();
user_info.put("session_id",session.getId());
user_info.put("user_id",user_id);
user_info.put("user_ip",user_ip);

user_info.put("access_time",System.currentTimeMillis());

//System.out.println(example_access_user.size());

int update_no = -1;
ArrayList remove_list = new ArrayList();
for(int i=0;i<example_access_user.size();i++){
	Map map = (Map)example_access_user.get(i);
	String session_id = map.get("session_id")+"";
	if(session_id.equals(session.getId())) update_no = i;

	long access_time = Long.parseLong(map.get("access_time")+"");
	if((System.currentTimeMillis()-access_time) > 5000) remove_list.add(i+"");
}

//사용자정보 갱신
if(update_no>-1) {
	example_access_user.remove(update_no);//제거후 추가
	example_access_user.add(update_no,user_info);
}else{
	example_access_user.add(user_info);
}


//5초 동안 접속이 없는자 제거
for(int i=0;i<remove_list.size();i++){
	int remove_no = Integer.parseInt(remove_list.get(i)+"");
	example_access_user.remove(remove_no);
}

%>


		<%   
   String idd = (String)session.getAttribute("loginid"); //#로그인한#id를#체크#

   if (idd != null) { //#로그인상태#
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
         
         k=0;

         // username 값을 입력한 경우 sql 문장을 수행.
         %>


				<p>친구목록</p>
				<ul class="nav" id="frlist">
					
					<%while(rs3.next()) {%>

					<%if((rs3.getString("username").equals(idd))){%>
					<li onclick="tempMid(this)" class="frshow" id="<%=rs3.getString("friend_request") %>"value="<%=rs3.getString("friend_request") %>"><%=rs3.getString("friend_request") %> 
					<%k++;
					for(int i=0;i<example_access_user.size();i++){
						Map map = (Map)example_access_user.get(i);
						String id = map.get("user_id")+"";
						if(id.equals(rs3.getString("friend_request"))){
						
							%> <span>접속</span> </li> <%
							}
						}
					} 
					
					
					
					else if((rs3.getString("friend_request").equals(idd))){%>
					<li onclick="tempMid(this)" class="frshow"  id="<%=rs3.getString("username") %>" value="<%=rs3.getString("username") %>"><%=rs3.getString("username") %>
					<%k++;
					for(int i=0;i<example_access_user.size();i++){
						Map map = (Map)example_access_user.get(i);
						String id = map.get("user_id")+"";
						if(id.equals(rs3.getString("username"))){
						
							%> <span>접속</span> </li><%
							}
						}
					
					}
					
         }%>
				</ul>


		<%  }
      catch(Exception e) {
		         System.out.println(e);
		      }
		       conn.close();    
		       pstmt.close();
		   }  %>

<!-- 현재접속자 end-->



