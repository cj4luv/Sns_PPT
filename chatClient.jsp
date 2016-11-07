<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
    <html>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        
    <style class="cp-pen-styles">
	html, body {height: 98%; position: relative; margin: 0;}
	body {
	
	  font-size: 16px;
	  padding: 1%
	}
	.wrapper_2 {
	  width: 612px;
	  height: 100%;
	  margin: 0 auto;
	}

	.phone-containter {
	  width: 350px;
	  height: 100%;
	  margin: 0px auto;
	  
	}
	.phone {
	  height: 300px;
	  border: 1px solid;
	  border-color: #e5e6e9 #dfe0e4 #d0d1d5;
	  border-radius: 5px;
	  -moz-border-radius: 5px;
	  -webkit-border-radius: 5px;
	  -o-border-radius: 5px;
	  overflow-y: auto;
	  overflow-x: hidden;
	  background-color: #F8F8F8
	}
	

	/* Messages baloon: 메세지 풍선 */
	.message {
	  margin: 10px 0;
	  overflow: hidden;
	}
	.message-text {
	  padding: 10px 20px;
	  float: right;
	  clear: both;
	  border-radius: 25px;
	  position: relative;
	  margin-bottom: 1px;
	}
	.message_left .message-text {
	  margin-right: 70px;
	  margin-left: 20px;
	  background-color: #e5e5ea;
	  float: left;
	}
	.message_right .message-text {
	  margin-left: 70px;
	  margin-right: 20px;
	  background-color: #36a9fc;
	  color: #fff;
	  float: right;
	}

	.message-text:last-child:before,
	.message-text:last-child:after {
	  content: '';
	  position: absolute;
	  bottom: 0;
	  width: 35px;
	  height: 25px;
	  z-index: -1;
	}

	.message_right .message-text:before,
	.message_right .message-text:after {
	  border-radius: 0 0 0 50%;
	}
	.message_right .message-text:before {
	  height: 20px;
	  right: -23px;
	  background-color: #36a9fc;
	}
	.message_right .message-text:after {
	  right: -35px;
	  bottom: -3px;
	  background-color: #fff;
	}


	.message_left .message-text:before,
	.message_left .message-text:after {
	  border-radius: 0 0 50% 0;
	}
	.message_left .message-text:before {
	  height: 20px;
	  left: -23px;
	  background-color: #e5e5ea;
	}
	.message_left .message-text:after {
	  left: -35px;
	  bottom: -3px;
	  background-color: #fff;
	}

	.send-container {
	  background-color: #f6f6f6;
	  border: 1px solid;
	  margin-top: -1px;
	  padding: 10px;
	  
	   border-color: #e5e6e9 #dfe0e4 #d0d1d5;
  border-radius: 8px;
  -moz-border-radius: 8px;
  -webkit-border-radius: 8px;
  -o-border-radius: 8px;
	}
	.send-input {
	  border-radius: 5px;
	  border: 1px solid #dbdbdb;
	  background-color: #fff;
	  padding: 5px 5px;
	  font-size: 1em;
	  width: 78%;
	}
	.send-btn {
	  text-decoration: none;
	  color: #939297;
	  font-weight: bold;
	 background-color: #FfFfFf;
	  font-size: 1em;
	  padding: 8px;
 	  margin-left: 8px;
  	  border: 1px solid;
  	  
  	  
  	  border-color: #e5e6e9 #dfe0e4 #d0d1d5;
  border-radius: 10px;
  -moz-border-radius: 10px;
  -webkit-border-radius: 10px;
  -o-border-radius: 10px;
  
	}
  </style>
  
    </head>

    <body>
        <script type="text/javascript" src="js/script.js"></script>
        <% String id=( String) session.getAttribute( "loginid"); //#로그인한#id를#체크# %>
            <!-- 채팅 -->
            <div >
                <div id="wrapper" class="phone-containter">
                    <div id="chrome">
                        <p>Chatting Channels</p>
                    </div>
                    
                    <!--새로운 인원이 발생했을 때 나오는 영역입니다.-->
                    <div id="newbie">
                        <span id="welcomeSpan"></span>
                    </div>
                    
                    
                        <div id="msgCon" class="phone">
                        </div>
					
                 
                    
                    <!--닉네임과 채팅을 입력하는 영역, 버튼의 영역입니다.-->
                    <div id="inputer">
                        <label class="inputer">
                            <input type="hidden" id="nick" value="<%=id%>" /> 
                        </label>
                        
                        <!-- 메세지 작성 -->
                        <div class="send-container">
                            
	                            <input type="text" name="text" id="sendTxt" onkeyup="checkKey(event)" maxlength="255" class="send-input"/>
	                            <input type="submit" id="con" onclick="sendMsg();" class = "send-btn" value="Send"/>
                        	
                        </div>
                    </div>
                </div>
    </div>
          
    </body>

    </html>