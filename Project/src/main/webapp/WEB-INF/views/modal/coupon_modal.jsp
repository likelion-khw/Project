<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="spring.mvc.whame.store.*,java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>        
<style>
@media only screen and (min-width : 321px) and (max-width : 600px) {
}
</style>
<div class="container center-align">
<c:forEach items="${storeMap }" var="svo">
		<div id="${svo.value.store_code }modal_coupon" class="modal coupon_modalform">
		<div class="modal-content">
			<table class="centered">
					<tr>
						<th colspan="4">
							<center>
								<label>행사추가</label>
								<select class="browser-default" name="coupon_state" id="${svo.value.store_code }state" style="width:200px;">
									<option value="" disabled selected>진행상태 선택</option>
									<option value="진행중">진행중</option>
									<option value="예정">예정</option>
									<option value="종료">종료</option>
								</select>
							</center>
						</th>
					</tr>
					<tr id="${svo.value.store_code }">
						<td colspan="1"><input type="text" name="contents" id="${svo.value.store_code }contents"></td>
						<td><input type="date" class = "datepicker" name="s_date" id="${svo.value.store_code }s_date"></td>
						<td><input type="date" class = "datepicker" name="e_date" id="${svo.value.store_code }e_date"></td>
						<td colspan="1"><input type="button" class="btn blue" value="행사추가" onclick="add_coupon(${svo.value.store_code})" ></td>
					<tr>
					<tr>
					<td colspan="5">
							<center>
								<label>행사상태</label>
									<select class="browser-default coupon_state2" title="coupon_state2" style="width:30%" name="${svo.value.store_code }" onchange="stateChange(${svo.value.store_code },$(this))">
										<option value="${svo.value.store_code }진행중2" selected="selected">진행중</option>
					   					<option value="${svo.value.store_code }예정2">예정</option>
					   					<option value="${svo.value.store_code }종료2">종료</option>
						 			</select>
					 		</center>
						</td>
					</tr>
			</table>
			<table class="centered highlight">
				</thead>
					<tr>
						<th>진행상태</th>
						<th>행사내용</th>
						<th>시작일</th>
						<th>종료일</th>
						<th>변경</th>
						<th>삭제</th>
					</tr>
				</thead>
				<tbody id='${svo.value.store_code}coupon_body'>
					<c:forEach items="${couponlist }" var="clist">
						<c:forEach items="${clist.value }" var="cvo">
							<c:set value="${clist.key }" var="key" />
							<c:set value="${svo.value.store_code}" var="storee" />
 							<c:if test="${key eq storee}">
								<tr id="${svo.value.store_code }${cvo.coupon_code }"  class="${svo.value.store_code }coupon_list2 hidemenu" name="${svo.value.store_code }${cvo.state }2">
									<td><input type="text" value="${cvo.state }" id="${svo.value.store_code}${cvo.coupon_code }state"></td>
									<td><input type="text" value="${cvo.contents }" id="${svo.value.store_code}${cvo.coupon_code }contents">
										<input type="hidden" value="${cvo.coupon_code }"></td>
									<td><input type="date" value="${cvo.s_time }" class = "datepicker" id="${svo.value.store_code}${cvo.coupon_code }s_time"></td>
									<td><input type="date" value="${cvo.e_time }" class = "datepicker" id="${svo.value.store_code}${cvo.coupon_code }e_time"></td>
									<td>
										<a href="javascript:re_coupon(${svo.value.store_code},${cvo.coupon_code })" style="color:red">
										<i class="material-icons" id="${svo.value.store_code}${cvo.coupon_code }icon" >reply</i>
										</a>
									</td>
									<td>
										<a href="javascript:del_coupon(${svo.value.store_code},${cvo.coupon_code })" style="color:black">
										<i class="material-icons" id="${svo.value.store_code}${cvo.coupon_code }del">delete</i>
										</a>
									</td>
								</tr>
							</c:if>
							</c:forEach>
					</c:forEach>
					<tr class="hidemenu" name="${svo.value.store_code }null2">
						<td colspan="6">등록된 이벤트가 없습니다.</td>
					</tr>
				</tbody>
			</table>
		</div>
		<div class="modal-footer">
			<a href="javascript:close();" class="modal-action modal-close btn red" id="close" style="float:none;">변경</a>
			<a href="javascript:cl" class="modal-action modal-close btn green" style="float:none;">취소</a>
		</div>
	</div>
</c:forEach>
</div>


	
<script type="text/javascript">
function stateChange(store_code,state){
	var selectState2 = state.val();
	$('tr[class='+store_code+'coupon_list2]').addClass('hidemenu');
	$('tr[name='+store_code+'null2]').addClass('hidemenu');
	
	var check = $('tr[name='+selectState2+']').length;
	if(check == 0){
		$('tr[name='+store_code+'null2]').removeClass('hidemenu');
	}else{
		$('tr[name='+selectState2+']').removeClass('hidemenu');
	}
}

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

$(document).ready(function(){
		
	$('select[title=coupon_state2]').each(function(){
		var store_code = $(this).attr('name');
		var selectState2 = $(this).val();
		$('tr[class='+store_code+'coupon_list2]').addClass('hidemenu');
		$('tr[name='+store_code+'null2]').addClass('hidemenu');

		var check = $('tr[name='+selectState2+']').length;
		if(check == 0){
			$('tr[name='+store_code+'null2]').removeClass('hidemenu');
		}else{
			$('tr[name='+selectState2+']').removeClass('hidemenu');
		}
	})

})
</script>