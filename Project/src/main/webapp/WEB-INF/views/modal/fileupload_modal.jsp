<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- Modal Structure -->
<style>
.modal.modal-fixed-footer.fileuploadform{
	height: 85%;
}
.fileup_run{
	width:100%;
}
.fm_read{
	margin-top:1%;
}
@media only screen and (min-width : 321px) and (max-width : 992px) {
	.fileuploadform {
		width:90%;
		height: 100%;
	}
	.fileup_run{
	margin-top: 20%;
	height: 350px;
	}
	i.medium{
		font-size: 2rem;
	}
	.fm_read{
		margin-top:1%;
		margin-bottom:5%;
	}
}

@media only screen and (min-width : 1300px) and (max-width : 1920px) {
	.fm_read{
	margin-top:15%;
}
}
</style>
<div id="modal1" class="modal modal-fixed-footer fileuploadform center-align">
	<div class="modal-content row">
		<h4>사용법</h4>
		<div class="fm_read col s12 m6">
		<p>1. 핸드폰은 되도록 가로 화면으로 촬영해주세요.</p>
			<i class="material-icons medium">stay_current_portrait</i><i class="material-icons medium" style="color:blue">forward</i><i class="material-icons medium">stay_current_landscape</i>
		<p>2. 정확한 정보제공을 위해서 사용자의 위치정보가 필요합니다.</p>
			<i class="material-icons medium">gps_fixed</i>
		<p>3. 아래 버튼 누르고 이미지를 업로드 시키면 간판의 정확성 인식을 위한 좌표를 찍는 화면으로 이동합니다.</p>
		<form action="image.whame" method="post" enctype="multipart/form-data" id="upload">
			<div class="file-field input-field">
				<div class="btn red" style="float:none;">
					<span><i class="material-icons">camera_enhance</i></span> <input type="file" name="imagefile" id="imagefile">
				</div>
				<div id="lal"></div>
				<div id="company_ul"></div>
			</div>
		</form>
		</div>
		<div class="col s12 m6">
			<사용과정>
			<img src="resources/img/main_run.gif" class="fileup_run">
		</div>	
	</div>
	<div class="modal-footer">
		<a href="#!"
			class="modal-action modal-close btn">취소</a>
	</div>
</div>

<script type="text/javascript">
	$(document).ready(function() {
		$('#imagefile').on('change',function(e){
			$('#upload').submit();
		});

		var lat;
		var lng;
		/* var lat = 37.516284;
		var lng = 127.020021; */
		if (navigator.geolocation) 
		{
			navigator.geolocation.getCurrentPosition(showPosition,showError);
		}
		else
		{
			$('#container').append('<div class="error">위치정보를 사용 할 수 없는 환경입니다.</div>');
		}

		function showPosition(position) {
			$.when( 
				lat = position.coords.latitude,
				lng = position.coords.longitude
			).then(function(){
				document.getElementById("lal").innerHTML += "<input type=hidden name=lat value=" + lat+ ">"
				+"<input type=hidden name=lon value=" + lng + ">";
				$('#company_ul').append('<div class="error">'+ no_text +'</div>');
			});
		}

		function showError(error)
		{
			var no_text;
			lat = 37.520498;
			lng = 127.022959;
			document.getElementById("lal").innerHTML += "<input type=hidden name=lat value=" + lat+ ">"
			+"<input type=hidden name=lon value=" + lng + ">";
			switch (error.code)
			{
				case error.PERMISSION_DENIED:
					no_text = '위치정보 획득권한을 거부 당했습니다.<br />위치정보를 활용 할 수 있도록 허용 해주세요.';
				break;
				case error.POSITION_UNAVAILABLE:
					no_text = '위치정보를 사용 할 수 없습니다.<br />페이지를 다시 로드 해주세요.';
				break;
				case error.TIMEOUT:
					no_text = '위치정보 요청시간이 지났습니다.<br />페이지를 다시 로드 해주세요.';
				break;
				default:
					no_text = '알 수없는 오류가 발생했습니다.<br />페이지를 다시 로드 해주세요.';
				break;
			};
			$('#company_ul').append('<div class="error">'+ no_text +'</div>');
		}
	})
</script>


