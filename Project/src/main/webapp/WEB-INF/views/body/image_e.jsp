<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<style>
	.imageform{
		margin-top : 20px;
	}
	
	#loading{
		margin-top : 30%;
	}
</style>
<script type="text/javascript">
	var img = new Image();
   function draw() {
      var canvas = document.getElementById('sample');
      var ctx = canvas.getContext("2d");

      img.onload = function() {
         canvas.width = img.width;
         canvas.height = img.height;
         ctx.drawImage(img, 0, 0);
         $('#loading').hide();
         $('#images').show();
      };
	
      img.src = "${imgurl}";
   }
</script>
<body onload="draw();">
	<div class="container imageform center-align">
		<div class="images" id="images">
		   <canvas id="sample" style="max-width:1024px; max-height:800px; width:100%; height:100%; padding-bottom:20px;"></canvas>
		   <br>
		   <input type="button" class="btn" value="재표시" id="del">
		   <input type="button" class="btn" value="전송" id="send">
		</div>
		<jsp:include page="../layout/loading.jsp"/>
	</div>
	   
   <script type="text/javascript">
      $(document).ready(function() {
         $('#images').hide();
         var one;
         var two;
         var three;
         var four;
         var number = 1;

         var canvas = document.getElementById('sample');
         var ctx = canvas.getContext('2d');

         $('#sample').on('click', function(event) {
        	var rX = img.width / $('#sample').width();
     		var rY = img.height / $('#sample').height();
    		 
            ctx.fillStyle = "#FF0000";
            if (number == 1) {
               one = parseInt(event.offsetX * rX) +":"+ parseInt(event.offsetY * rY);
               ctx.fillRect(parseInt(event.offsetX * rX), parseInt(event.offsetY * rY), 50, 50);
               number++
            } else if (number == 2) {
               two = parseInt(event.offsetX * rX) +":"+ parseInt(event.offsetY * rY);
               ctx.fillRect(parseInt(event.offsetX * rX), parseInt(event.offsetY * rY), 50, 50);
               number++;
            } else if (number == 3) {
               three = parseInt(event.offsetX * rX) +":"+ parseInt(event.offsetY * rY);
               ctx.fillRect(parseInt(event.offsetX * rX), parseInt(event.offsetY * rY), 50, 50);
               number++;
            } else if (number == 4) {
               four = parseInt(event.offsetX * rX) +":"+ parseInt(event.offsetY * rY);
               ctx.fillRect(parseInt(event.offsetX * rX), parseInt(event.offsetY * rY), 50, 50);
               number++;
            } else if (number == 5) {
               alert("4개의 모서리를 전부 클릭하셨습니다.\n 전송 버튼을 눌러주세요");
               alert(one +"/"+ two+"/"+ three+"/"+ four);
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
                success:function(result){ 
            	   alert("Success");  
            	   location.href="enrollsuccess.whame"; 
               }              
            })

            
         });
      })
   </script>

</body>
