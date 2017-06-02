function rcodeSelect() {

	var gu = $("#rcode1").val();

	var seoul = [ "중구", "종로구", "서대문구", "마포구", "은평구", "동대문구", '중랑구', '도봉구',
			'성동구', '강동구', '강남구', '성북구', '서초구', '송파구', '노원구', '용산구', '강북구',
			'광진구', '영등포구', '관악구', '구로구', '금천구', '동작구', '강서구', '양천구' ];
	var busan = [ '중구', '동구', '서구', '사하구', '영도구', '동래구', '남구', '금정구', '연제구',
			'해운대구', '수영구', '부산진구', '북구', '사상구', '강서구', '기장군' ];
	var daegu = [ '중구', '동구', '북구', '서구', '달서구', '남구', '수성구', '달성군' ];
	var daejeon = [ '동구', '중구', '서구', '유성구', '대덕구' ];
	var incheon = [ '중구', '동구', '남구', '부평구', '서구', '남동구', '연수구', '계양구', '응진군',
			'강화군' ];
	var gwangju = [ '북구', '동구', '서구', '남구', '광산구' ];

	var rcodelist;
	
	
	if (gu == "서울특별시") {
		rcodelist = seoul;
	} else if (gu == "부산") {
		rcodelist = busan;
	} else if (gu == "대구") {
		rcodelist = daegu;
	} else if (gu == "대전") {
		rcodelist = daejeon;
	} else if (gu == "인천") {
		rcodelist = incheon;
	} else if (gu == "광주") {
		rcodelist = gwangju;
	}

	$('#rcode2').empty();

	for (var count = 0; count < rcodelist.length; count++) {
		var option = $("<option value=" + rcodelist[count] + ">"
				+ rcodelist[count] + "</option>");
		$('#rcode2').append(option);
	}
	

}