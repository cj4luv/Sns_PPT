<%@page contentType="text/html;charset=utf-8" %> 
 <%@ page import="java.util.Enumeration" %> 
 
<%
	session.invalidate(); //#세션을#초기화#해서#ID를#지운다.#
	response.sendRedirect("index.jsp"); //#홈페이지로#돌아간다.
	
%>