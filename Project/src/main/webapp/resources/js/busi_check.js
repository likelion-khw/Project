$(document).ready(function() {
	$('#busi_check').on('click', function() {
		var busi_code1 = $('#busi_code1').val();
		var busi_code2 = $('#busi_code2').val();
		var busi_code3 = $('#busi_code3').val();
		var bizID = busi_code1 + busi_code2 + busi_code3;
		
		var business_code = $('#business_code');
		
		if(checkBizID(bizID))
			{
				alert("검증이 완료되었습니다.");
				business_code.val(bizID);
			}
		else{
			alert("유효하지 않은 사업자번호입니다.");
			$('#busi_code1').val("");
			$('#busi_code2').val("");
			$('#busi_code3').val("");
		}

		function checkBizID(bizID) // 사업자등록번호 체크
		{
			// bizID는 숫자만 10자리로 해서 문자열로 넘긴다.
			var checkID = new Array(1, 3, 7, 1, 3, 7, 1, 3, 5, 1);
			var tmpBizID, i, chkSum = 0, c2, remander;
			bizID = bizID.replace(/-/gi, '');

			for (i = 0; i <= 7; i++)
				chkSum += checkID[i] * bizID.charAt(i);
			c2 = "0" + (checkID[8] * bizID.charAt(8));
			c2 = c2.substring(c2.length - 2, c2.length);
			chkSum += Math.floor(c2.charAt(0)) + Math.floor(c2.charAt(1));
			remander = (10 - (chkSum % 10)) % 10;

			if (Math.floor(bizID.charAt(9)) == remander)
				return true; // OK!
			return false;
		}
	});
	
})