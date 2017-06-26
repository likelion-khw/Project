<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<style>
.imageform{
	margin-top : 20px;
	margin-bottom: 20px;
	padding-top: 20px;
	padding-left:20px;
	padding-right:20px;
	padding-bottom:50px;
	width:60%;
	height: 200%;
	border-radius:20px;
}

#loading{
	margin-top : 30%;
	margin-bottom: 30%;
}

.file-field .btn, .file-field .btn-large{
	float:none;
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

			var onel = new Array();
			var twol = new Array();
			var threel = new Array();
			var four = new Array();

			var sort = new Array();

			var moveone = new Array();
			var movetwo = new Array();
			var movethree = new Array();
			var movefour = new Array();


			var canvas = document.getElementById('sample');
			var ctx = canvas.getContext('2d');

			$('#sample').on(
					'click',
					function(event) {
						var rX = img.width / $('#sample').width();
						var rY = img.height / $('#sample').height();
						var setRect = parseInt(12 * rX);

						ctx.fillStyle = "#FF0000";
						if (number == 1) {
							one = parseInt(event.offsetX * rX) + ":"
									+ parseInt(event.offsetY * rY);
							ctx.fillRect(parseInt(event.offsetX * rX - (setRect / 2) ),
									parseInt(event.offsetY * rY - (setRect / 2)), setRect,
									setRect);
							number++

							onel = {'x': parseInt((event.offsetX * rX)), 'y':parseInt((event.offsetY * rY))};
							moveone = {'x': parseInt((event.offsetX * rX- (setRect / 2) )), 'y': parseInt((event.offsetY * rY- (setRect / 2) )), 'mx':parseInt((event.offsetX * rX + (setRect / 2))), 'my':parseInt((event.offsetY * rY + (setRect / 2)))};

						} else if (number == 2) {
							two = parseInt(event.offsetX * rX) + ":"
									+ parseInt(event.offsetY * rY);
							ctx.fillRect(parseInt(event.offsetX * rX - (setRect / 2)),
									parseInt(event.offsetY * rY - (setRect / 2)), setRect,
									setRect);
							number++;

							twol = {'x': parseInt((event.offsetX * rX)), 'y':parseInt((event.offsetY * rY))};
							movetwo = {'x': parseInt((event.offsetX * rX- (setRect / 2) )), 'y': parseInt((event.offsetY * rY- (setRect / 2) )), 'mx':parseInt((event.offsetX * rX + (setRect / 2))), 'my':parseInt((event.offsetY * rY + (setRect / 2)))};
						} else if (number == 3) {
							three = parseInt(event.offsetX * rX) + ":"
									+ parseInt(event.offsetY * rY);
							ctx.fillRect(parseInt(event.offsetX * rX - (setRect / 2)),
									parseInt(event.offsetY * rY - (setRect / 2)), setRect,
									setRect);
							number++;

							threel = {'x': parseInt((event.offsetX * rX)), 'y':parseInt((event.offsetY * rY))};
							movethree = {'x': parseInt((event.offsetX * rX- (setRect / 2) )), 'y': parseInt((event.offsetY * rY- (setRect / 2) )), 'mx':parseInt((event.offsetX * rX + (setRect / 2))), 'my':parseInt((event.offsetY * rY + (setRect / 2)))};
						} else if (number == 4) {
							four = parseInt(event.offsetX * rX) + ":"
									+ parseInt(event.offsetY * rY);
							ctx.fillRect(parseInt(event.offsetX * rX - (setRect / 2)),
									parseInt(event.offsetY * rY - (setRect / 2)), setRect,
									setRect);
							number++;

							fourl = {'x': parseInt((event.offsetX * rX)), 'y':parseInt((event.offsetY * rY))};
							movefour = {'x': parseInt((event.offsetX * rX- (setRect / 2) )), 'y': parseInt((event.offsetY * rY- (setRect / 2) )), 'mx':parseInt((event.offsetX * rX + (setRect / 2))), 'my':parseInt((event.offsetY * rY + (setRect / 2)))};
							
							sortfun();
							
							ctx.beginPath();
							ctx.moveTo(onel.x,onel.y);
							ctx.lineWidth = 3;
							ctx.lineTo(twol.x,twol.y);
							ctx.lineTo(threel.x,threel.y);
							ctx.lineTo(fourl.x,fourl.y);
							ctx.closePath();
							ctx.strokeStyle = 'red';
							ctx.stroke();
							
						} else if (number == 5) {
							var x = parseInt((event.offsetX * rX));
							var y = parseInt((event.offsetY * rY));
							var is = false;
							var msg;

							if(x >= moveone.x && x <= moveone.mx)
								{
									if(y >= moveone.y && y <= moveone.my)
										{
											alert('one');
										}
								}
							if(x >= movetwo.x && x <= movetwo.mx)
							{
								if(y >= movetwo.y && y <= movetwo.my)
									{
										alert('two');
									}
							}
							if(x >= movethree.x && x <= movethree.mx)
							{
								if(y >= movethree.y && y <= movethree.my)
									{
										alert('three');
									}
							}
							if(x >= movefour.x && x <= movefour.mx)
							{
								if(y >= movefour.y && y <= movefour.my)
									{
										alert('four');
									}
							}								

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
						location.href = "enrollsuccess.whame";
					}
				})

			});

			$('#imagefile').on('change', function(e) {
				$('#upload').submit();
			});

			var sortfun = function(){
				sort = [onel, twol, threel, fourl,''];
				var temp = [(onel.x+onel.y), (twol.x+twol.y), (threel.x+threel.y), (fourl.x+fourl.y),''];
				
				for(var i=0; i<3; i++)
				{
					for(var j=i+1; j<4; j++)
					{
						if(temp[i] > temp[j])
						{
							temp[4] = temp[i];
							temp[i] = temp[j];
							temp[j] = temp[4];
							
							sort[4] = sort[i];
							sort[i] = sort[j];
							sort[j] = sort[4];
						}
					}
				}

				onel = sort[0];
				twol = sort[1];
				threel = sort[3];
				fourl = sort[2];
			}
		})

</script>
