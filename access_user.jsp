<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<% request.setCharacterEncoding("utf-8"); %>

<%@ page import="java.util.Enumeration" %> 

<html>
<head>
<title>샘플프로그램[www.dbtool.co.kr]</title>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">   
<style type="text/css">

-->
</style> 
</head>
<body>


<DIV id="access_list" class="dbtool_scroll">친구 목록 불러오는중</DIV>


	<script language="JavaScript">

		var xmlHttp;
		var xmlHttp1;
		var xmlhttp2;
		setInterval("test()", 3000);
	//	setInterval("test1()", 3000);
		function test() {
			
			createXMLHttpRequest();
			
			var url = "ajax_user.jsp";
		
			xmlHttp.onreadystatechange = loader;
				
			xmlHttp.open("GET", url, true);
			
			xmlHttp.send(null);
			
			//3초 마다 서버와 통신함 		원래 위치
			return false;
			test(); 
		}
		/*
		function test1() {
			
			createXMLHttpRequest1();
			
			var url1 = "friend_request.jsp";
		
			xmlHttp1.onreadystatechange = loader1;
				
			xmlHttp1.open("GET", url1, true);
			
			xmlHttp1.send(null);
			
			//3초 마다 서버와 통신함 		원래 위치
			return false;
			test1(); 
		}
		
		function test2() {
			
			createXMLHttpRequest2();
			
			var url2 = "friend_reqList.jsp";
		
			xmlHttp2.onreadystatechange = loader2;
				
			xmlHttp2.open("GET", url2, true);
			
			xmlHttp2.send(null);
			
			//3초 마다 서버와 통신함 		원래 위치
			return false;
			test2(); 
		}
		
*/
		function createXMLHttpRequest() {
		
			if(window.ActiveXObject) {

				xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
				
			} else if(window.XMLHttpRequest) {
				
				xmlHttp = new XMLHttpRequest();

			}

		}
		/*
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

		}*/
		function loader() {
			
			if(xmlHttp.readyState == 4) {

				if(xmlHttp.status == 200) {
					
					temp = xmlHttp.responseText;
					
					document.getElementById("access_list").innerHTML = temp;
					
				}else {
					
					//alert("Error loading "+url+", "+xmlhttp.status+"("+xmlhttp.statusText+")");
				}

			}

		}
/*
		function loader1() {
			
			if(xmlHttp1.readyState == 4) {

				if(xmlHttp1.status == 200) {
					
					temp1 = xmlHttp1.responseText;
					
					document.getElementById("reqCount").innerHTML = temp1;
					
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
		*/
	</script>


<script language="javascript"> 
/*
function include_exit(msg) { 
	var xmlhttp = getXmlHttpRequest();
	var url = 'user_exit.jsp?msg='+msg;
	
	if(url){
		xmlhttp.open("GET", url, true);
		xmlhttp.onreadystatechange = function() {
			if(xmlhttp.readyState == 4) {
				if(xmlhttp.status == 200) {
					var respTxt = xmlhttp.responseText;
				} else {
					//alert("Error loading "+url+", "+xmlhttp.status+"("+xmlhttp.statusText+")");
				}
			}
		}
		xmlhttp.send(null);
	}
	return false;
} 
function Exit() { 
    if (self.screenTop > 9000) { 
		// 브라우저종료
		include_exit('브라우저종료');
    } else { 
        if(document.readyState == "complete") { 
            // 새로고침 
			include_exit('새로고침');
        } else if(document.readyState == "loading") { 
            // 다른사이트이동 
			include_exit('페이지이동');
        } 
    } 
} */
</script> 

<script language="javascript" event="onunload" for="window"> 
    Exit(); 
</script> 

</body>
</html>
