<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="spring.mvc.whame.store.*,java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>        
<style>
.modal {
		width:90%;
		height: 100%;
	}
@media only screen and (min-width : 321px) and (max-width : 500px) {
	.modal {
		width:100%;
	}
	
	.modal .type{
		width:80px;
	}
	
	.modal .price{
		width:60px;
	}
}
</style>
<div class="container center-align">
<c:forEach items="${storeMap }" var="slist">
	<c:forEach items="${slist.value }" var="svo">
		<div id="${svo.store_code }modal_coupon" class="modal">
		<div class="modal-content">
			<table class="centered highlight">
			<thead>
					<tr id="${svo.store_code }">
						<td>
							<select class="browser-default" name="coupon_state" id="${svo.store_code }state">
								<option value="" disabled selected>진행상태 선택</option>
								<option value="진행중">진행중</option>
								<option value="예정">예정</option>
								<option value="종료">종료</option>
							</select>
						</td>
						<td><input type="text" name="contents" id="${svo.store_code }contents"></td>
						<td><input type="date" class = "datepicker" name="s_date" id="${svo.store_code }s_date"></td>
						<td><input type="date" class = "datepicker" name="e_date" id="${svo.store_code }e_date"></td>
						<td colspan="2"><input type="button" class="btn blue" value="행사추가" onclick="add_coupon(${svo.store_code})" ></td>
					<tr>
					<tr>
						<th>진행상태</th>
						<th>행사내용</th>
						<th>시작일</th>
						<th>종료일</th>
						<th>변경</th>
						<th>삭제</th>
					</tr>
				</thead>
				<tbody id='${svo.store_code}coupon_body'>
					<c:forEach items="${couponlist }" var="clist">
						<c:set value="${clist.key }" var="key" />
						<c:set value="${svo.store_code}" var="storee" />
						<c:if test="${key eq storee}">
							<c:forEach items="${clist.value }" var="cvo">
								<tr id="${svo.store_code }${cvo.coupon_code }">
									<td><input type="text" value="${cvo.state }" id="${svo.store_code}${cvo.coupon_code }state"></td>
									<td><input type="text" value="${cvo.contents }" id="${svo.store_code}${cvo.coupon_code }contents">
										<input type="hidden" value="${cvo.coupon_code }"></td>
									<td><input type="date" value="${cvo.s_time }" class = "datepicker" id="${svo.store_code}${cvo.coupon_code }s_time"></td>
									<td><input type="date" value="${cvo.e_time }" class = "datepicker" id="${svo.store_code}${cvo.coupon_code }e_time"></td>
									<td>
										<a href="javascript:re_coupon(${svo.store_code},${cvo.coupon_code })" style="color:red">
										<i class="material-icons" id="${svo.store_code}${cvo.coupon_code }icon" >reply</i>
										</a>
									</td>
									<td>
										<a href="javascript:del_coupon(${svo.store_code},${cvo.coupon_code })" style="color:black">
										<i class="material-icons" id="${svo.store_code}${cvo.coupon_code }del">delete</i>
										</a>
									</td>
								</tr>
							</c:forEach>
						</c:if> 
					</c:forEach>
				</tbody>
			</table>
		</div>
		<div class="modal-footer">
			<a href="javascript:close();" class="modal-action modal-close btn green" id="close" style="float:none;">확인</a>
		</div>
	</div>
</c:forEach>
</c:forEach>
</div>


	
<script type="text/javascript">

function add_coupon(store_code){
	var contents = $('#'+store_code+"contents").val();
	var s_time = $('#'+store_code+"s_date").val();
	var e_time = $('#'+store_code+"e_date").val();
	var state = $('#'+store_code+"state").val();
	
	var a = "<input type='text' id='"+store_code;
	var a2 = "state' value='"+state+"'>"
	var b = "<input type='text' id='"+store_code;
	var b2 = "contents' value='"+contents+"'>"
	var c = "<input type='date' id='"+store_code;
	var c2 = "s_time' class='datepicker' value='"+s_time+"'>";
	var d = "<input type='date' id='"+store_code;
	var d2 = "e_time' class='datepicker' value='"+e_time+"'>";
	/* var re1 = "<a href='javascript:re_coupon('"+store_code+"','";
	var re2 = "')' style='color:red'><i class='material-icons' id='"+store_code;
	var re3 = "icon' >reply</i></a>";		
	var del1 = "<a href='javascript:del_coupon("+store_code+","; */
	var del2 = ")' style='color:black'><i class='material-icons' id='"+store_code;
	var del3 = "del' >delete</i></a>";	
	
	console.log(contents+":::"+s_time+"::::"+e_time+"::::"+state+":::"+store_code);
	if(contents != null && s_time != null && e_time != null){
		$.ajax({
			url : 'addcoupon.whame',
			type: 'post',
			data : {
					'store_code' : store_code,
					'contents' : contents,
					's_time' : s_time,
					'e_time' : e_time
				},
			success : function(result){
					alert('추가완료!'+result);
					$('#'+store_code+'coupon_body:first').append("<tr id='"+store_code+""+result+"'><td>"+a+result+a2+"</td>"
							+"<td>"+b+result+b2+"<input type='hidden' value='"+result+"' id='"+store_code+result+"coupon_code'></td>"
							+"<td>"+c+result+c2+"</td><td>"+d+result+d2+"</td>"
							 +"<td><a href='javascript:re_coupon("+store_code+","+result+")' style='color:red'><i class='material-icons' id='"+store_code+result+"icon' >reply</i></a></td>"
							 +"<td><a href='javascript:del_coupon("+store_code+","+result+del2+result+del3+"</td></tr>"); 
				}
		});
	}else{
		alert("모든 정보 입력 후 추가 가능")
	}
}
function re_coupon(store_code,coupon_code){
	var icon =  $('#'+store_code+coupon_code+"icon");
	var contents = $('#'+store_code+coupon_code+"contents").val();
	var s_time = $('#'+store_code+coupon_code+"s_time").val();
	var e_time = $('#'+store_code+coupon_code+"e_time").val();
	var state = $('#'+store_code+coupon_code+"state").val();
	 console.log(icon.attr("class")+":::"+contents+":::"+s_time+":::"+e_time+":::"+state);
	$.ajax({
		url : 'recoupon.whame',
		type: 'post',
		data : {
				'store_code' : store_code,
				'coupon_code' : coupon_code,
				'contents' : contents,
				's_time' : s_time,
				'e_time' : e_time,
				'state' :state
			},
		success : function(){
					icon.html('done');
					icon.parent().attr('style','color:green');
			}
	});  
}

function del_coupon(store_code,coupon_code){
	var parent =  $('#'+store_code+coupon_code);
	 
	$.ajax({
		url : 'delcoupon.whame',
		type: 'post',
		data : {
				'store_code' : store_code,
				'coupon_code' : coupon_code,
				
			},
		success : function(){
				parent.empty();
			}
	});  
}


$('.datepicker').pickadate({
	format: 'yyyy-mm-dd',
	labelMonthNext: '이전 달',
	labelMonthPrev: '다음 달',
	monthsFull: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
	monthsShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
	weekdaysFull: ['일', '월', '화', '수', '목', '금', '토'],
	weekdaysShort: ['일', '월', '화', '수', '목', '금', '토'],
	weekdaysLetter: ['일', '월', '화', '수', '목', '금', '토'],
	min: new Date(),
	today: 'Today',
	clear: 'Clear',
	close: 'Close'
	});
/* $(function(){
		$('.datepicker').pickadate({
		min: new Date(2017,06,02),
	    selectMonths: true, // Creates a dropdown to control month
	    selectYears: 15 // Creates a dropdown of 15 years to control year
	  });
	}); */

</script>
