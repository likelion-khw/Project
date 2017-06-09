$(function() { $("#postcodify_search_button").postcodifyPopUp(); }); 
$('#e_submit').on('click',function(){
		var a = $('#business_code');
		var b = $('#en_address');
		var c = $('#categorySelect');
		var d = $('#categoryDetail');
		var e = $("#store_name");
		var f = $('#operating_time');
		var g = $('#imagefile');
		
		if(a.val() == ""){
			alert("사업자 번호를 인증하세요.");
		}else if(b.val() == ""){
			alert("주소를 입력해주세요.");
		}else if(c.val() == ""){
			alert("음식점 카테고리를 선택하세요.");
		}else if(d.val() == ""){
			alert("메뉴 카테고리를 선택하세요.");
		}else if(e.val() == ""){
			alert("상호명을 입력하세요.");
		}else if(f.val() == ""){
			alert("영업시간을 입력하세요");
		}else if(g.val() == ""){
			alert("간판 이미지를 올려주세요.");
		}else{
			$('form[id=enroll_form]').submit();
		}
	});

function changeCategory() {

	var category = $("#categorySelect").val();
	var store_category;
	
	if(category == "한식"){
		store_category = 100;
	} else if(category == "중식"){
		store_category = 200;
	} else if(category == "일식"){
		store_category = 300;
	} else if(category == "양식"){
		store_category = 400;
	} else if(category == "패스트푸드"){
		store_category = 500;
	} else if(category == "디저트"){
		store_category = 600;
	}
	
	$('#store_category').empty();

	console.log(store_category);
		$.ajax({
			type : "POST",
			url : "categoryDetail.whame",
			data : {'store_category':store_category},
			success: function(data){
				console.log("--------"+data);
				/*for(var index=0; index<data.length; index++){
					var option = $("<option value="+data[index]+">"+data[index]+"</option>");
					$('#store_category').append(option);
				}*/
			},  error : function(request,status,error){alert("code:"+request.status+"\n\n"+"message:"+request.responseText+"\n\n"+"error:"+error);
			
			}
		});
}