 <%@page contentType="text/html;charset=utf-8" %>
<jsp:include page="header.jsp" flush="false"/>

 <style type="text/css"> 
 
	 body {  padding-bottom: 40px; background-color: f5f5f5; } 

	.form-signin { 
 	max-width: 300px; padding: 19px 29px 29px; margin: 0 auto 20px; 
 	background-color: fff; border: 1px solid e5e5e5; border-radius: 5px; 
	box-shadow: 0 1px 2px rgba(0,0,0,.05); 
	} 
	.form-signin .form-signin-heading { margin-bottom: 10px; } 
	.form-signin input { font-size: 16px; height: auto; margin-bottom: 15px; padding: 7px 9px; } 
	</style> 
 	<div class="container"> 
	<form class="form-signin" action="process_register.jsp" method="post"> 
	<h2 class="form-signin-heading">블로그 가입</h2> 
	<input type="text" name=username class="input-block-level" placeholder="사용자 ID"> 
	<input type="text" name=email class="input-block-level" placeholder="사용자 이메일"> 
	<input type="password" name=passwd class="input-block-level" placeholder="사용자 암호"> 
	<button class="btn btn-large btn-primary" type="submit">가입</button> 
	</form> 
	</div> 
<jsp:include page="footer.jsp" flush="false"/>
 
 