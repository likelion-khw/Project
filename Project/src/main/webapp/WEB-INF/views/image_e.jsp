<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<title>Insert title here</title>
<style type="text/css">
</style>
<script type="text/javascript">
   function draw() {
      var img = new Image();
      var canvas = document.getElementById('sample');
      var ctx = canvas.getContext("2d");

      img.onload = function() {
         canvas.width = img.width;
         canvas.height = img.height;
         ctx.drawImage(img, 0, 0);
      };
	
      img.src = "${imgurl}";
   }
</script>
</head>
<body onload="draw();">

   <canvas id="sample" width=100 height=100></canvas>
   <br>
   <input type="button" value="재표시" id="del">
   <input type="button" value="전송" id="send">

   <script type="text/javascript">
      $(document).ready(function() {

         var one;
         var two;
         var three;
         var four;
         var number = 1;

         var canvas = document.getElementById('sample');
         var ctx = canvas.getContext('2d');

         $('#sample').on('click', function() {
            ctx.fillStyle = "#FF0000";
            if (number == 1) {
               one = event.offsetX +":"+ event.offsetY;
               ctx.fillRect(event.offsetX, event.offsetY, 7, 7);
               number++
            } else if (number == 2) {
               two = event.offsetX +":"+ event.offsetY;
               ctx.fillRect(event.offsetX, event.offsetY, 7, 7);
               number++;
            } else if (number == 3) {
               three = event.offsetX +":"+ event.offsetY;
               ctx.fillRect(event.offsetX, event.offsetY, 7, 7);
               number++;
            } else if (number == 4) {
               four = event.offsetX +":"+ event.offsetY;
               ctx.fillRect(event.offsetX, event.offsetY, 7, 7);
               number++;
            } else if (number == 5) {
               alert("4개의 모서리를 전부 클릭하셨습니다.\n 전송 버튼을 눌러주세요");
            }
         });

         $('#del').on('click', function() {
            number = 1;
            draw();
         })

         $('#send').on('click', function() {
            $.ajax({
               url : 'result.whame',
               type : 'post',
               data : {
                  'one' : one,
                  'two' : two,
                  'three' : three,
                  'four' : four,
                  'imgurl' : "${imgurl}"
               },
                success:function(){ 
            	   alert("Success");  
            	   location.href="enrollsuccess.whame"; 
               },
               error : function(request,status,error){alert("code:"+request.status+"\n\n"+"message:"+request.responseText+"\n\n"+"error:"+error);}, 
               complete : function(){alert("실행완료!")}
            })

			
            
         });
      })
   </script>

</body>
</html>