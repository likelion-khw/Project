<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<style>
.imageform{
	margin-top : 20px;;
	padding-top: 20px;
	padding-left:20px;
	padding-right:20px;
	padding-bottom:50px;
	width:80%;
	height: 300%;
}

#loading{
	margin-top : 30%;
	margin-bottom: 30%;
}

.forms{
	margin-left : 42%;
}

@media only screen and (min-width : 321px) and (max-width : 600px) {
	.imageform{
		margin-top : 20px;	
		padding-top: 10px;
		padding-left:10px;
		padding-right:10px;
		padding-bottom:50px;
		width:90%;
	}
	.forms{
		margin-left : 33%;
	}
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
	<div class="container imageform center-align z-depth-2">
		<div class="images" id="images">
		   <canvas id="sample" style="max-width:1024px; max-height:800px; width:100%; height:100%; padding-bottom:20px;"></canvas>
		   <br>
		   <input type="button" class="btn" value="재표시" id="del">
		   <input type="button" class="btn blue" value="전송" id="send">
		<form action="image.whame" method="post" enctype="multipart/form-data" id="upload" class="forms">
			<input type="hidden" name="lat" value="${lat}">
			<input type="hidden" name="lon" value="${lon}">
			<div class="file-field input-field">
				<div class="btn red">
					<span>다른이미지</span> <input type="file" name="imagefile" id="imagefile">
				</div>
			</div>
		</form>
		</div>
		<jsp:include page="../layout/loading.jsp"/>
	</div>
</body>

<script type="text/javascript">
$(document).ready(
		function() {
			$('#images').hide();
			var one;
			var two;
			var three;
			var four;
			var number = 1;

			var canvas = document.getElementById('sample');
			var ctx = canvas.getContext('2d');

			$('#sample').on(
					'click',
					function(event) {
						var rX = img.width / $('#sample').width();
						var rY = img.height / $('#sample').height();
						var setRect = parseInt(10 * rX);

						ctx.fillStyle = "#FF0000";
						if (number == 1) {
							one = parseInt(event.offsetX * rX) + ":"
									+ parseInt(event.offsetY * rY);
							ctx.fillRect(parseInt(event.offsetX * rX),
									parseInt(event.offsetY * rY), setRect,
									setRect);
							number++
						} else if (number == 2) {
							two = parseInt(event.offsetX * rX) + ":"
									+ parseInt(event.offsetY * rY);
							ctx.fillRect(parseInt(event.offsetX * rX),
									parseInt(event.offsetY * rY), setRect,
									setRect);
							number++;
						} else if (number == 3) {
							three = parseInt(event.offsetX * rX) + ":"
									+ parseInt(event.offsetY * rY);
							ctx.fillRect(parseInt(event.offsetX * rX),
									parseInt(event.offsetY * rY), setRect,
									setRect);
							number++;
						} else if (number == 4) {
							four = parseInt(event.offsetX * rX) + ":"
									+ parseInt(event.offsetY * rY);
							ctx.fillRect(parseInt(event.offsetX * rX),
									parseInt(event.offsetY * rY), setRect,
									setRect);
							number++;
						} else if (number == 5) {
							alert("4개의 모서리를 전부 클릭하셨습니다.\n 전송 버튼을 눌러주세요");
							alert(one + "/" + two + "/" + three + "/" + four);
						}
					});

			$('#del').on('click', function() {
				number = 1;
				draw();
			})

			$('#send').on('click', function() {
				$('#images').hide();
				$('#loading').show();
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
					success : function(result) {
						location.href = "showinfo.whame";
					}
				})

			});

			$('#imagefile').on('change', function(e) {
				$('#upload').submit();
			});
		})

</script>
