<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.net.URLEncoder"%>
<%@page contentType="text/html;charset=utf-8" import="java.sql.*"%>
<jsp:include page="header.jsp" flush="false" />

<!DOCTYPE html>
<html lang="ko">
<head>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"
></script>
 

<!-- Add mousewheel plugin (this is optional) -->
<script type="text/javascript"
	src="js/jquery.mousewheel.pack.js?v=3.1.3"
>
</script>

<!-- Add fancyBox main JS and CSS files -->
<script type="text/javascript" src="js/jquery.fancybox.pack.js?v=2.1.5"></script>
<link rel="stylesheet" type="text/css"
	href="css/jquery.fancybox.css?v=2.1.5" media="screen"
/>

<!-- Add Button helper (this is optional) -->
<link rel="stylesheet" type="text/css"
	href="css/jquery.fancybox-buttons.css?v=1.0.5"
/>
<script type="text/javascript"
	src="js/jquery.fancybox-buttons.js?v=1.0.5"
></script>

<!-- Add Thumbnail helper (this is optional) -->
<link rel="stylesheet" type="text/css"
	href="css/jquery.fancybox-thumbs.css?v=1.0.7"
/>
<script type="text/javascript"
	src="js/jquery.fancybox-thumbs.js?v=1.0.7"
></script>

<script type="text/javascript">
	var aaa = null;
	var name = null;

	/*window.onload = function() {
	 var ex = document.getElementById('ex');
	 };   */

	function on() {

		location.href = './Edit_ppt.jsp?aa=' + escape(encodeURIComponent(aaa))
				+ '?name=' + name;

	}


	$(document)
			.ready(
					function() {
						$('img').click(
								function() {
									var index = $("img").index(this);
									aaa = $("img:eq(" + index + ")")
											.attr("src");
									name = aaa.substring(
											aaa.indexOf("upload/") + 7, aaa
													.indexOf("/img/"));
									aaa = aaa.substring(
											aaa.indexOf("/img/") + 5,
											aaa.length - 5);
									//alert(aaa);
									aaa = aaa + ".ppt";

								}); // 에디트 추가

						$('.fancybox-thumbs')
								.fancybox(
										{

											prevEffect : 'fade',
											nextEffect : 'fade',

											closeBtn : true,
											arrows : true,
											nextClick : true,
											padding : 5,

											beforeShow : function() {
												if (this.title) {
													// New line
													this.title += '<br />';

													// Add tweet button
													this.title += '<button id="ex" class="btn btn-primary btn-lg raised" type="submit" onclick="on()">Edit</button>';

												}
											},

											afterShow : function() {
												$(".fancybox-title").wrapInner(
														'<div />').show();

											},

											helpers : {

												title : {
													type : 'inside'
												},
												thumbs : {

													width : 50,
													height : 50,

													source : function(item) {
														//$.fancybox.next();
														$.fancybox.jumpto($(
																this).data(
																'index'));

														return item.href
																.replace(
																		'1.jpg',
																		'1.jpg');

													}
												}
											}
										});

					});
</script>


<style type="text/css">


#jb-container {
	width: 100%;
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

#jb-sidebar-left {
	width: 200px;
	padding: 20px;
	margin-right: 20px;
	margin-bottom: 20px;
	float: left;
	border: 1px solid;
  	border-color: #e5e6e9 #dfe0e4 #d0d1d5;
  	 border-radius: 10px;
   -moz-border-radius: 10px;
   -webkit-border-radius: 10px;
   -o-border-radius: 10px;
	background-color: #F8F8F8;
	visibility:hidden
}

#jb-content {
	width: 50%;
	
	margin-bottom: 20px;
	float: left;
	
	background-color: #F8F8F8;
	
}

.container {
	width: 500px;
}

#container1 {
	width: 250px;
}

.centered-form {
	margin-top: 120px;
	margin-bottom: 120px;
}

.centered-form .panel {
	background: rgba(255, 255, 255, 0.8);
	box-shadow: rgba(0, 0, 0, 0.3) 20px 20px 20px;
}

.col-sm-6 {
	width: 100%;
	
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

#jb-footer {
	clear: both;
	padding: 20px;
	border: 1px solid #bcbcbc;
}

.form-signin {
	max-width: 300px;
	padding: 19px 29px 29px;
	margin: 0 auto 20px;
	background-color: #ffffff;
	border: 1px solid e5e5e5;
	border-radius: 5px;
	jabox-shadow: 0 1px 2px rgba(0, 0, 0, .05);
}

.form-signin .form-signin-heading {
	margin-bottom: 10px;
}

.form-signin input {
	font-size: 16px;
	height: auto;
	margin-bottom: 15px;
	padding: 7px 9px;
}

._Smxv {
	
	width: 110%;
	border: 1px solid;
	border-color: #e5e6e9 #dfe0e4 #d0d1d5;
	background-color: #ffffff;
	-webkit-border-radius: 10px;
	padding-left: inherit;
	padding-right: inherit;
	margin-bottom: 40px;
	box-shadow: rgba(0, 0, 0, 0.3) 20px 20px 20px;
	
	
}
.downBtn {
	margin-bottom: 20px;
}

.topLine {
	border-top: 2px solid;
	border-color: #e5e6e9;
	padding-top: 10px;
}
.underLine {
	border-bottom: 2px solid;
	border-color: #e5e6e9;
	
	padding-bottom: 10px;
	
}
.imgBorder {
	border: 1px solid;
 	border-color: #e5e6e9 #dfe0e4 #d0d1d5;
 	 border-radius: 10px;
   -moz-border-radius: 10px;
   -webkit-border-radius: 10px;
   -o-border-radius: 10px;
	margin-top: 10px;
	margin-bottom: 20px;
	margin-left: 20px;
}

.panel-default>.panel-heading {
  color: #FFF;
  background-color: #7BD4ED;
  border-color: #ddd;
}

.ph-button {

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
  font-size: 16px;
}

.ph-button:hover {
background-color: #64D6BC;
 border-color: #64D6BC;
}

.btn-blue {
  border-color: #7BD4ED;
  background-color: #7BD4ED;
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

.btn {
  display: inline-block;
  padding: 6px 12px;
  margin-bottom: 0;
  font-size: 14px;
  font-weight: normal;
  line-height: 1.42857143;
  text-align: center;
  white-space: nowrap;
  vertical-align: middle;
  cursor: pointer;
  -webkit-user-select: none;
     -moz-user-select: none;
      -ms-user-select: none;
          user-select: none;
  background-image: none;
  border: 1px solid transparent;
  border-radius: 4px;
  padding: 10px 16px;
}
  
.btn-lg {
  font-size: 18px;
  line-height: 1.33;
  border-radius: 6px;
}

.btn-primary {
  color: #fff;
  background-color: #428bca;
  border-color: #357ebd;
}

.btn-primary:hover,
.btn-primary:focus,
.btn-primary:active,
.btn-primary.active,
.open .dropdown-toggle.btn-primary {
  color: #fff;
  background-color: #3276b1;
  border-color: #285e8e;
}

/***********************
  RAISED BUTTONS
************************/
.btn-primary.raised {
    box-shadow: 0 3px 0 0 #007299;
}
.btn-primary.raised:active, .btn-primary.raised.active {
    background: #33a6cc;
    box-shadow: none;
    margin-bottom: -3px;
    margin-top: 3px;
}

/***********************
  CUSTON BTN VALUES
************************/

.btn {
    padding: 10px 14px;
    border: 0 none;
    font-weight: 700;
    letter-spacing: 1px;
    text-transform: uppercase;
}
.btn:focus, .btn:active:focus, .btn.active:focus {
    outline: 0 none;
}

.btn-primary {
    background: #0099cc;
    color: #ffffff;
}
.btn-primary:hover, .btn-primary:focus, .btn-primary:active, .btn-primary.active, .open > .dropdown-toggle.btn-primary {
    background: #33a6cc;
}
.btn-primary:active, .btn-primary.active {
    background: #007299;
    box-shadow: none;
}

</style>
</head>
<body>


	<%
		String id = (String) session.getAttribute("loginid"); //#로그인한#id를#체크#

		if (id != null) { //#로그인상태#
			// 데이터베이스 연결관련 변수 선언
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs1 = null;
			ResultSet rs2 = null;
			ResultSet rs3 = null;

			int total = 0;
			// 데이터베이스 연결관련정보를 문자열로 선언
			String jdbc_driver = "com.mysql.jdbc.Driver";
			 String jdbc_url = "jdbc:mysql://127.0.0.1/jspdb";
	         
	         try{
	            // JDBC 드라이버 로드
	            Class.forName(jdbc_driver);

	            

	            // 데이터베이스 연결정보를 이용해 Connection 인스턴스 확보
	            conn = DriverManager.getConnection(jdbc_url,"jspbook","1234");
				String sql1 = "select count(boardno) from board";
				//String sql2 = "select boardno, title,usernameboard, content, date, uploadfilename, slidelength from jspdb.board order by boardno DESC";
				//String sql2 = "select distinct(boardno), title,usernameboard, content, date, uploadfilename, slidelength from jspdb.board join friend_info where friend_state='2' and  (username = usernameboard or friend_request = usernameboard) and  (username = '"+id+"' or friend_request = '"+id+"') or usernameboard='"+id+"' order by boardno DESC";
				String sql2 = "select boardno, title,usernameboard, content, date, uploadfilename, slidelength from board where usernameboard in (select group_concat(if(username='"
						+ id
						+ "', friend_request, username)) from friend_info where (username = '"
						+ id
						+ "' or friend_request = '"
						+ id
						+ "') and friend_state = 2) or usernameboard = '"
						+ id + "' order by boardno DESC";
				String sql3 = "SELECT username,friend_request,friend_state FROM jspdb.friend_info where friend_state=2";
				pstmt = conn.prepareStatement(sql1);
				rs1 = pstmt.executeQuery();
				pstmt = conn.prepareStatement(sql2);
				rs2 = pstmt.executeQuery();
				pstmt = conn.prepareStatement(sql3);
				rs3 = pstmt.executeQuery();

				rs1.next(); //rs 1은 게시글 갯수 뽑기
				total = rs1.getInt(1);

				// username 값을 입력한 경우 sql 문장을 수행.
	%>

	<div class="row row-offcanvas row-offcanvas-right" id="jb-container">

		<div id="jb-sidebar-left">
			<h2>Sidebar</h2>
			<ul>
				<li>Lorem</li>
				<li>Ipsum</li>
				<li>Dolor</li>
			</ul>
		</div>

		<div class="col-xs-12 col-sm-9" id="jb-content">
			<div class="row">
				<div class="col-6 col-sm-6 col-lg-4">
					<%
						while (rs2.next()) { //while문 시작

									long date = rs2.getLong("date");
									SimpleDateFormat Current = new SimpleDateFormat(
											"yyyy/MM/dd/hh:mm");
									String today = Current.format(date);
					%>
					<div class="container">
						<div class='post _Smxv'>
							<h2 class="underLine"><%=rs2.getString("title")%></h2>
							<p class="underLine"><%=rs2.getString("content")%></p>

							<%
								String src = rs2.getString("uploadfilename");
											System.out.println(src);
											int a = rs2.getInt("slidelength");

											for (int i = 0; i < a; i++) { // for문 시작
							%>
							<a class="fancybox-thumbs" data-fancybox-group="thumb<%=src%>"
								title="<%=rs2.getString("title")%>" id="test"
								href="upload/<%=rs2.getString("usernameboard")%>/img/<%=rs2.getString("uploadfilename")
									.substring(
											0,
											rs2.getString("uploadfilename")
													.indexOf("."))
									+ (i + 1)%>.jpg"
							> <%
 	} //for문 끝  펜시 박스 영역
 %> <!-- 게시물에 노출된 표지 --> <img
								src="upload/<%=rs2.getString("usernameboard")%>/img/<%=rs2.getString("uploadfilename").substring(0,
								rs2.getString("uploadfilename").indexOf("."))%>1.jpg"
								width=90% height=90% class="imgBorder"
								onerror="javascript:this.src='upload/img/index.jpg'"
							>
							</a>
							
							<p class="topLine">
								작성자 :
								<%=rs2.getString("usernameboard")%></p>
							<p>
								작성시간 :
								<%=today%></p>
							<p>
								첨부파일 :
								<%=rs2.getString("uploadfilename")%></p>
							<form action="process_down.jsp" class="downBtn">
								<input type=hidden name="fileName"
									value="<%=rs2.getString("uploadfilename")%>"
								> <input type=hidden name="userName"
									value="<%=rs2.getString("usernameboard")%>"
								> <input class="btn btn-primary btn-lg raised" type="submit" value="Download">
							</form>
							
						</div>
						
					</div>
					
					<%
						} //while문 끝
					%>

				</div>
				<!--/span-->
			</div>
			<!--/row-->
		</div>
		<!--/span-->
		<div class="col-xs-6 col-sm-3 sidebar-offcanvas" role="navigation"
			id="jb-sidebar-right"
		><p>Friends List</p>
			<div class="well sidebar-nav" id="fflist">

				<jsp:include page="access_user.jsp" flush="false" />

			</div>
			<jsp:include page="chatClient.jsp" flush="false" />
			<!--/.well -->
		</div>

		<!--/span-->
		<%
			} catch (Exception e) {
					System.out.println(e);
				}
				conn.close();
				pstmt.close();
		%>

	</div>
	<!--/row-->

	<%
		} else {
	%>
	<div class="container" id="container1">
		<div class="row centered-form">
			<div class="panel panel-default">
				<div class="panel-heading">
					<h3 class="panel-title text-center"><font size="3" face="Helvetica"><b>PPTSNS</font></h3>
				</div>
				<div class="panel-body">
							<form role="form" name="member_join" action="process_register.jsp" method="post">
						<div class="form-group">
							<input type="text" name="username" id="username" class="form-control input-sm"
					onkeyup="userCheck()" placeholder="사용자 ID"
							>
						</div>

						<div class="form-group">
							<input type="text" name="email" id="email" class="form-control input-sm"
							onkeyup="mailCheck()"	placeholder="사용자 이메일"
							>
						</div>
						<div class="row">
							<div class="col-xs-6 col-sm-6 col-md-6">
								<div class="form-group">
									<input type="password" name="passwd" id="password"
							onkeyup="pwdCheck()" class="form-control input-sm" placeholder="비밀번호 입력해주세요"
									>
								</div>
							</div>
							<div class="col-xs-6 col-sm-6 col-md-6">
								<div class="form-group">
									<input type="password" name="check_password" id="check_password"
							onkeyup="pwdCheck()" class="form-control input-sm" placeholder="비밀 번호 확인"
									>
								</div>
							</div>
						</div>
						<input class="ph-button btn-blue  btn-block" type="submit" id="sign" value="Sign Up"
							onclick="location.href='register.jsp'">
					</form>
				</div>
			</div>
		</div>
	</div>
	<%
		}
	%>
</body>


<script>
function userCheck(){
	var id = document.member_join.username.value;
	var count=0;
	
	for (i=0;i<id.length ;i++ )
	{
	 ch=id.charAt(i)
	  if (!(ch>='0' && ch<='9') && !(ch>='a' && ch<='z'))
	  {
		  document.member_join.username.style.border="2px solid red";
		  count++;	
	  }
	}
	//아이디에 공백 사용하지 않기
	if (id.indexOf(" ")>=0)
	{
		document.member_join.username.style.border="2px solid red";
		  count++;	
	}
	//아이디 길이 체크 (6~12자)
	if (id.length<6 || id.length>12)
	{
		document.member_join.username.style.border="2px solid red";
		  count++;	
	}
		
	if(count==0){
		document.member_join.username.style.border="2px solid blue";
	}
	
	count=0;
}

function mailCheck(){
	var email = document.member_join.email.value;
	var reg_email=/^[-A-Za-z0-9_]+[-A-Za-z0-9_.]*[@]{1}[-A-Za-z0-9_]+[-A-Za-z0-9_.]*[.]{1}[A-Za-z]{2,5}$/;
	// 인자 email_address를 정규식 format 으로 검색
	if (email.search(reg_email) == -1){
	   
		document.member_join.email.style.border="2px solid red";
	}else{
		document.member_join.email.style.border="2px solid blue";
	}
	
}


function pwdCheck(){
	var password = document.member_join.password.value;
	var check_password = document.member_join.check_password.value;
	
    if(password!=check_password) {
    	document.member_join.password.style.border="2px solid red";
	 }

    else if (password.length<6 || password.length>12)
	{
    	document.member_join.password.style.border="2px solid red";

	}else{
		document.member_join.password.style.border="2px solid blue";
		document.member_join.check_password.style.border="2px solid blue";
	}

}
</script>
</html>




