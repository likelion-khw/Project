function changeRegion() {

	var region = $("#regionSelect").val();
	var regionDetail;

	if (region == "서울특별시") {
		regionDetail = "서울특별시";
	} else if (region == "부산") {
		regionDetail = "부산";
	} else if (region == "대구") {
		regionDetail = "대구";
	} else if (region == "대전") {
		regionDetail = "대전";
	} else if (region == "인천") {
		regionDetail = "인천";
	} else if (region == "광주") {
		regionDetail = "광주";
	}

	console.log(regionDetail);
	
	$("#regionDetail").empty();
		$.ajax({
			type : "POST",
			url : "regionDetail.whame",
			data : { 'regionDetail' : regionDetail },
			success : function(data){
				for(var index=1; index<data.length; index++){
					var option = $("<option value="+data[index]+">"+data[index]+"</option>");
					$('#regionDetail').append(option);
				}
			}
		});
}

function changeCategory() {

	var category = $("#categorySelect").val();
	var categoryDetail;
	
	if(category == "한식"){
		categoryDetail = 100;
	} else if(category == "양식"){
		categoryDetail = 200;
	} else if(category == "중식"){
		categoryDetail = 300;
	} else if(category == "카페"){
		categoryDetail = 900;
	}

	$('#categoryDetail').empty();
	console.log(categoryDetail);
		$.ajax({
			type : "POST",
			url : "categoryDetail.whame",
			data : 'categoryDetail='+categoryDetail,
			success: function(data){
				for(var index=1; index<data.length; index++){
					var option = $("<option value="+data[index]+">"+data[index]+"</option>");
					$('#categoryDetail').append(option);
				}
			}, error: function(){
				console.log("디테일 음식 전송 에러");
			}
		});
}
