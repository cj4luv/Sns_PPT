<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*"%>
<%@ page import="java.util.Enumeration" %> 

<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="shortcut icon" href="../../assets/ico/favicon.png">

    <title>Fixed Top Navbar Example for Bootstrap</title>

    <!-- Bootstrap core CSS -->
    <link href="css/bootstrap.css" rel="stylesheet"> 
    <link href="css/bootstrap.min.css" rel="stylesheet"> 
    
    <script src="http://code.jquery.com/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>

     <script language="JavaScript">
     function check_login(form){
      if(form.username.value==""){
         alert('아이디를 입력하세요.');
         form.username.focus();
      }else if(form.passwd.value==""){
         alert('이름을 입력하세요.');
         form.passwd.focus();
      }else{
         form.submit();
      }
      return false;
   }
  
  </script>
  <style>
  .navbar-default {
    background-color: #7BD4ED;
  	border-color: #7BD4ED; 
  }
  
  .navbar-default .navbar-brand {
  color: #FFF;
}

.btn-primary1 {

  border-style: solid;
  border-width: 0px 0px 3px;
  box-shadow: 0 -1px 0 rgba(255, 255, 255, 0.1) inset;
  color: #FFFFFF;
  border-radius: 6px;
  cursor: pointer;
  display: inline-block;
  font-style: normal;
  overflow: hidden;
  text-align: center;
  text-decoration: none;
  text-overflow: ellipsis;
  transition: all 200ms ease-in-out 0s;
  white-space: nowrap;
  font-family: "Gotham Rounded A","Gotham Rounded B",Helvetica,Arial,sans-serif;
  font-weight: 700;
  padding: 8px 8px 6px;
  font-size: 14px;
}

.btn-green {
  border-color: #3AC162;
  background-color: #5FCF80;
}

.btn-primary1:hover {
background-color: #3FAC88;
 border-color: #3FAC88;
}
  
  </style>
  
  </head>

  <body>
  
  
 <nav class="navbar navbar-default" role="navigation">
  <!-- Brand and toggle get grouped for better mobile display -->
  <div class="navbar-header">
    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-ex1-collapse">
      <span class="sr-only">Toggle navigation</span>
      <span class="icon-bar"></span>
      <span class="icon-bar"></span>
      <span class="icon-bar"></span>
    </button>
    <a class="navbar-brand" href="index.jsp"><font size="5" face=Helvetica><b>PPTSNS</font></a>
  </div>

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
   


        <%     

 
      
        
       
   String id = (String)session.getAttribute("loginid"); //#로그인한#id를#체크#
   if (id != null) { //#로그인상태#
      %>  
        <!-- Collect the nav links, forms, and other content for toggling -->

  <div class="collapse navbar-collapse navbar-ex1-collapse">
 <!--  <form class="navbar-form navbar-left" role="search" method="post" action="access_user.jsp">
        <button type="submit" class="btn btn-large btn-primary">현재사용자</button>
           </form>   -->  
    <form class="navbar-form navbar-left" role="search" method="post" action="search.jsp">
      <div class="form-group">
        <input type="text" class="form-control" placeholder="Friends Name Search" name=searchname>
        <button type="submit" class="btn-primary1 btn-green">Search</button>
        </div>
           </form>
            <form class="navbar-form navbar-right" method="post" action="process_responseFriend.jsp">

              <div class="btn-group">

            <button type="button" data-toggle="dropdown" class="btn btn-default dropdown-toggle"><span class="glyphicon glyphicon-user">&nbsp;</span><span class="badge pull-right" id="reqCount"></span> </button>
           <ul class="dropdown-menu" id="messageDrop">
           
           </ul>
            </div>

			<input type="button" value="Write" class="btn-primary1 btn-green" onclick="location.href='write.jsp'";>	
          	<input type="button" value="<%= id+" :"%> logout" class="btn-primary1 btn-green" onclick="location.href='process_logout.jsp'";>	
         	
         </form>
         

   </div>
 
        <% } else { %> 
        
          <div class="collapse navbar-collapse navbar-ex1-collapse">

          <form class="navbar-form navbar-right" action="process_login.jsp" method="post" role="search" onsubmit="return check_login(this)">
              <div class="form-group">

         <input type="text" name=username class="form-control" placeholder="사용자 ID"> 
        <input type="password" name=passwd class="form-control" placeholder="사용자 암호">
       <button class="btn-primary1 btn-green" type="submit">Login</button> 
         </div>
       <% }   %> 
    </form>
  </div><!-- /.navbar-collapse -->
</nav>

    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
     <%
   conn.close();    
    pstmt.close();

%>

  </body>

<script>
var xmlHttp1;
var xmlhttp2;
setInterval("test1()", 3000);


function test1() {
   
   createXMLHttpRequest1();
   
   var url1 = "friend_request.jsp";

   xmlHttp1.onreadystatechange = loader1;
      
   xmlHttp1.open("GET", url1, true);
   
   xmlHttp1.send(null);
   
   //3초 마다 서버와 통신함       원래 위치
   return false;
   test1(); 
}

function test2() {
   
   createXMLHttpRequest2();
   
   var url2 = "friend_reqList.jsp";

   xmlHttp2.onreadystatechange = loader2;
      
   xmlHttp2.open("GET", url2, true);
   
   xmlHttp2.send(null);
   
   //3초 마다 서버와 통신함       원래 위치
   return false;
   test2(); 
}
function createXMLHttpRequest1() {
   
   if(window.ActiveXObject) {

      xmlHttp1 = new ActiveXObject("Microsoft.XMLHTTP");
      
   } else if(window.XMLHttpRequest) {
      
      xmlHttp1 = new XMLHttpRequest();

   }

}

function createXMLHttpRequest2() {
   
   if(window.ActiveXObject) {

      xmlHttp2 = new ActiveXObject("Microsoft.XMLHTTP");
      
   } else if(window.XMLHttpRequest) {
      
      xmlHttp2 = new XMLHttpRequest();

   }

}

function loader1() {
   
   if(xmlHttp1.readyState == 4) {

      if(xmlHttp1.status == 200) {
         
         temp1 = xmlHttp1.responseText;
         
         if(temp1.trim()>0){
             document.getElementById("reqCount").innerHTML = temp1;
              }
         
         test2();
         
      }else {   
         
         //alert("Error loading "+url+", "+xmlhttp.status+"("+xmlhttp.statusText+")");
      }

   }

}


function loader2() {
   
   if(xmlHttp2.readyState == 4) {

      if(xmlHttp2.status == 200) {
         
         temp2 = xmlHttp2.responseText;
         
         
         
         document.getElementById("messageDrop").innerHTML = temp2;
         
         

      }else {   
         
         //alert("Error loading "+url+", "+xmlhttp.status+"("+xmlhttp.statusText+")");
      }

   }

}

</script>
   </html>
