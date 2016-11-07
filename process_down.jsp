<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8" import="java.io.*"%>
 <%
  OutputStream outStream = null;
  FileInputStream fileStream = null;
  try {
   //주소와 파일이름 가져오기
  String fileName = request.getParameter("fileName");
  String userName = request.getParameter("userName");
    String filePath = "C:\\apache-tomcat-7.0.72\\webapps\\jspbook2\\upload\\"+userName+"\\";
   //또는 아래 사용
  //String filePath = request.getRealPath("/")+"uploadFile/";
   //System.out.println(filePath);
   
   
   //응답 헤더의 Content-Type을 세팅한다.
   response.setContentType("application/x-msdownload");
   //위 세팅으로 안될 경우에 사용.
   //response.setContentType("application/octet-stream");
   
   //Content-Disposition 세팅하기위해 file 이름을 변환한다.
   String convName1 =
    java.net.URLEncoder.encode(fileName,"UTF-8");
   
   //Content-Disposition 헤더에 파일 이름 세팅.
   response.setHeader("Content-Disposition", "attachment;filename=" + convName1 + ";");
   //위 세팅으로 안될 경우에 사용.
   //response.setHeader("Content-Disposition","attachment;fileName=\""+Convfilename+"\";");
   
   
   // 폴더에 있는 파일 가져오기 위해 다른 방법으로 변환
  String convName2 = fileName;
   File file = new File(filePath+convName2);
   
   byte[] byteStream = new byte[(int)file.length()];
   fileStream = new FileInputStream(file);
   int i=0;
   int j=0;
   while( (i=fileStream.read()) != -1 ){
    byteStream[j] = (byte)i;
    j++;
   }
   out.clear(); //out--> jsp자체 객체
  out=pageContext.pushBody(); //out--> jsp자체 객체 
   outStream = response.getOutputStream();
   outStream.write(byteStream);
  }catch(Exception e) {
   System.out.println(e);
  }finally {
   if(fileStream != null) fileStream.close();
   if(outStream != null) outStream.close();
  }
 %>