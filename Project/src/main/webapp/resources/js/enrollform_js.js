function changeCategory() {

	var category = $("#categorySelect").val();
	var categoryDetail;
	
	if(category == "한식"){
		categoryDetail = 100;
	} else if(category == "양식"){
		categoryDetail = 200;
	} else if(category == "중식"){
		categoryDetail = 300;
	} else if(category == "일식"){
		categoryDetail = 400;
	}
	else if(category == "카페"){
		categoryDetail = 900;
	}

	$('#categoryDetail').empty();
	console.log(categoryDetail);
		$.ajax({
			type : "POST",
			url : "categoryDetail.whame",
			data : {'categoryDetail':categoryDetail},
			success: function(data){
				for(var index=0; index<data.length; index++){
					console.log("js수정완료");
					var option = $("<option value="+data[index]+">"+data[index]+"</option>");
					$('#categoryDetail').append(option);
				}
			}, error: function(){
				console.log("디테일 음식 전송 에러");
			}
		});
}