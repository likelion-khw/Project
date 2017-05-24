<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- Modal Structure -->
<style>

@media only screen and (min-width : 321px) and (max-width : 992px) {
	.fileuploadform {
		width:90%;
}
}
</style>
<script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.98.2/js/materialize.min.js"></script>
<div id="modal1" class="modal modal-fixed-footer fileuploadform">
	<div class="modal-content">
		<h4>사용법</h4>
		<p>불라불라불라</p>
		<form action="image.whame" method="post" enctype="multipart/form-data" id="upload">
			<div class="file-field input-field">
				<div class="btn">
					<span>File</span> <input type="file" name="imagefile" id="imagefile">
				</div>
				<div id="startLat"></div>
				<div id="startLon"></div>
				<div id="lal"></div>
			</div>
		</form>
	</div>

	<div class="modal-footer">
		<a href="#!"
			class="modal-action modal-close btn">확인</a>
	</div>
</div>

<script type="text/javascript">
	$(document).ready(function() {
		$('#imagefile').on('change',function(e){
			$('#upload').submit();
		});
	})
/* 	function success(position){
	var lat = (position.coords.latitude).toFixed(6);
	var lon = (position.coords.longitude).toFixed(6);
	document.getElementById("lal").innerHTML += "<input type=text name=lat value=" + lat + ">"
							+"<input type=text name=lon value=" + lon + ">";
	}
	
	function error(err){
		$('div').text("조회 실패 ==>" + err.code);
	}
	
	
	$(document).ready(function(){
		//위치추적:네트워크 연결되어있어야함!
		window.onload = location();
		function location(){
			window.navigator.geolocation.getCurrentPosition(success, error);//()를 붙여 자동호출하는것 x
		}
			
	}) 
 */
	
	window.onload = function() {
	  var startPos;
	  var geoSuccess = function(position) {
	    startPos = position;
	    document.getElementById('startLat').innerHTML = startPos.coords.latitude;
	    document.getElementById('startLon').innerHTML = startPos.coords.longitude;
	    document.getElementById("lal").innerHTML += "<input type=hidden name=lat value=" + startPos.coords.latitude + ">"
		+"<input type=hidden name=lon value=" + startPos.coords.longitude + ">";
	  };
	  navigator.geolocation.getCurrentPosition(geoSuccess);
	};
</script>

 


