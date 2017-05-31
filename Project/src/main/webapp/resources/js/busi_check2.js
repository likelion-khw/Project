$(document).ready(function() {
	$('#busi_check').on('click', function() {
		var busi_code1 = $('#busi_code1').val();
		var busi_code2 = $('#busi_code2').val();
		var busi_code3 = $('#busi_code3').val();
		var bizID = busi_code1 + busi_code2 + busi_code3;
		
		var business_code = $('#business_code');
		alert("검증이 완료되었습니다.");
		business_code.val(bizID);
	});
	
})