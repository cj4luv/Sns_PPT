var welcomeMsg = "";
var server;
var ws;
var userIP = "";
var getIP;
var nickname;
var msgCon;
var uNick;
var msg;
var myIP = "";
var sendNickName;
var INTERVAL = 20;
var canvasValid = true;


window.onload = function() {

   if (window.WebSocket) {

      /*
       * var i = parseInt(Math.random() * 10000); //닉네임에 표시되는 최대 숫자값을 설정합니다.
       * nickname = "손님" + i; //닉네임에 숫자를 붙입니다.
       * document.getElementById("nick").innerHTML = nickname
       */
      conServer();

   } else {
      //alert("web소켓 접속됨");
      document.getElementById("body").style.display = "none";
   }

}

function conServer() {
   nickname = document.getElementById("nick").value;
   // document.getElementById("nick").disabled = "disabled";
   document.getElementById("sendTxt").style.display = "";
   document.getElementById("con").innerHTML = "";
   msgCon = document.getElementById("msgCon");
   server = "ws://localhost:8080/jspbook2/chat";
   ws = new WebSocket(server);

   ws.onopen = function(e) {
     // alert("웹 소켓 접속");
      // document.getElementById("welcomeSpan").innerHTML += nickname + "님 접속을
      // 환영합니다.";
      ws.send(nickname + " 님이 접속했습니다.");

   }

   ws.onmessage = function(e) {

      if (e.data.search("new connection") != -1) {
         e.data = e.data.replace("new connection", "");
      } else if (e.data.search("msg:") != -1 && e.data.search("ip:") != -1) {

         uNick = e.data.split("msg:", 2)[0];
         getIP = uNick.split("ip:")[1];
         uNick = uNick.split("ip:")[0];
         msg = e.data.split("msg:", 2)[1];

         if (nickname == uNick && getIP == userIP) {
            // msgCon.innerHTML +="<strong><font color=orange>
            // "+uNick+"</font></strong>("+userIP+")�� "+msg+"<br>";
            // msgCon.innerHTML += "<p class=\"commn\"><strong> " + uNick +
            // "(" + userIP + ")</strong> : " + msg + "</p>";
            msgCon.innerHTML += "<p class=\"commn\"><strong> " + uNick
                  + "</strong> : " + msg + "</p>";
         } else {
            // msgCon.innerHTML +="<strong>"+ uNick+"</strong>("+getIP+")��
            // "+msg+"<br>";
            msgCon.innerHTML += "<p class=\"commn\"><strong> " + uNick
                  + "</strong> : " + msg + "</p>";
         }

         if (msgCon.scrollHeight > 362) {
            msgCon.scrollTop += 100;
         }

      } else {
    	  if(e.data.substring(0,e.data.indexOf("/")) != nickname){
    		  msgCon.innerHTML += "<div class=\"message_right\"> <div class=\"message-text\">" + e.data.substring(e.data.indexOf(":")+1) + "</div></div>";
                                                         // 되는거
    	  }else {
    		  msgCon.innerHTML += "<div class=\"message_left\"> <div class=\"message-text\">"+ e.data.substring(e.data.indexOf("/")+1,e.data.indexOf("msg:")) +": " + e.data.substring(e.data.indexOf(":")+1) + "</div></div>";
    	  }
      }
   }

   ws.onclose = function(e) {
      document.getElementById("msgCon").innerHTML += "서버와의 접속이 끊겼습니다..";
      ws.send(sendNickName + "/" + nickname + " msg:" + sendText.value);
   }
}

function disconServer() {
   alert("서버와의 접속이 끊겼습니다..");
   if (server != "")
      ws.onclose();
   server = "";
   ws = new Worker(server);
}

function sendMsg() {
   var sendText = document.getElementById("sendTxt");
   if (server != "" && sendText.value.trim() != "") {
      // ws.send(nickname + "ip:" + userIP + "msg:" + sendText.value);
      // ws.send(nickname + " msg: " + sendText.value);
      ws.send(String(sendNickName) + "/" + String(nickname) + " msg:" + sendText.value);
      sendText.value = "";
      sendText.focus();
      enterFlag = true;
   } else {
      sendText.focus();
   }

}







function tempMid(e){
	alert(e.id);
	var ssss=e.id;
	//alert(document.getElementById(e.id).value);
	//alert(document.getElementById(e.id).text);
	sendNickName=String(ssss);
}

function checkKey(event) {
   if (event.keyCode == 13) {
      sendMsg();
      sendMsg1();
   }
}



	  
