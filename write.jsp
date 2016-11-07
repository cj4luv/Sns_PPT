<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="header.jsp" flush="false"/>
<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>

<html>

<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

 <title>파일 업로드를 심플하게 해보아요 :-)</title>

</head>

<body>
 <style type="text/css"> 
 
	 body { padding-bottom: 40px; background-color: f5f5f5; } 

	.form-signin { 
 	max-width: 300px; padding: 19px 29px 29px; margin: 0 auto 20px; 
 	background-color: fff; border: 1px solid e5e5e5; border-radius: 5px; 
	box-shadow: 0 1px 2px rgba(0,0,0,.05); 
	} 
	.form-signin .form-signin-heading { margin-bottom: 10px; } 
	.form-signin input { font-size: 16px; height: auto; margin-bottom: 15px; padding: 7px 9px; } 
	</style> 
          <!-- enctype="multipart/form-data" 파일이나 대용량 데이터 보낼때 데이터 전송 방식 -->
          
	<div class="container">           
	<form name="fileForm" method="post" enctype="multipart/form-data" action="process_write.jsp"> 
	<h2 class="form-write-heading">새 글 작성</h2> 


	<input type="text" name="title" id="title" class="form-control" placeholder="새 글 제목"> 
 	<textarea rows=10 name="content" class="form-control"> </textarea>	
 파일명 : <input type="file" id="uploadfilename" name="uploadfilename" accept=".ppt"><br>
	<button class="btn btn-danger btn-lg" type="submit" id="writbtn">글 작성</button> 	
	<input type="button" class="btn btn-default btn-lg" onclick="location.href='index.jsp'" value="취소"> <br>
</form>
</div>
</body>
<script>
  $(document).ready(function() {
 
	  $("#writbtn").click(function() {
		// alert( document.getElementById('title').value);
		  if(document.getElementById('title').value	== ""){
			  alert("제목을 입력해주세요"); 
			  return false;
		  }
		  if(document.getElementById('uploadfilename').value == ""){
			  alert("파일을 첨부해주세요"); 
			  return false;
		  }
		  
	  });
  });
	  
		  </script>    	
</html>
<jsp:include page="footer.jsp" flush="false"/>