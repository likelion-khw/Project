<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<style>
	.info.modal{
		height: 50%;
	}
	#history_del{
		width:400px;
		background-color: #37474f;
		color:white;
	}
	
	#store_del{
		background-color: #37474f;
		color:white;
		width:400px;
		height: 300px;
	}
	#rem_nick_over{
		background-color: #37474f;
		color:white;
		width:400px;
	}
	#rem_nick_no{
		background-color: #37474f;
		color:white;
		width:400px;
	}
	#enroll_menu_select{
		background-color: #37474f;
		color:white;
		width:400px;
		height: 300px;
	}
	.infomodal_form .modal-footer{
		background-color: #37474f;
	}
</style>
<div class="container center-align infomodal_form">
	<div id="history_del" class="info modal">
	  <div class="modal-content">
	    <h4>히스토리 삭제</h4>
	    <p>히스토리 정보를 정말 삭제하시겠습니까?</p>
	  </div>
	  <div class="modal-footer">
	    <a href="#!" class="modal-action modal-close btn red" style="float:none" id="info_his_del">예</a>
	    <a href="#!" class="modal-action modal-close btn" style="float:none">아니오</a>
	  </div>
	</div>
	
	<div id="store_del" class="info modal">
	  <div class="modal-content">
	    <h4>상가 삭제</h4>
	    <p>상가를 정말 삭제하시겠습니까?</p>
	    <p>** 주의 **</p>
	    <p>한번 삭제시 복구 할 수 없습니다.</p>
	  </div>
	  <div class="modal-footer">
	    <a href="#!" class="modal-action modal-close btn red" style="float:none" id="info_store_del">예</a>
	    <a href="#!" class="modal-action modal-close btn" style="float:none">아니오</a>
	  </div>
	</div>
	
	<div id="rem_nick_over" class="info modal">
	  <div class="modal-content">
	    <h4>중복된 닉네임 입니다.</h4>
	  </div>
	  <div class="modal-footer">
	    <a href="#!" class="modal-action modal-close btn red" style="float:none">확인</a>
	  </div>
	</div>
	
	<div id="rem_nick_no" class="info modal">
	  <div class="modal-content">
	    <h4>닉네임을 변경하세요.</h4>
	  </div>
	  <div class="modal-footer">
	    <a href="#!" class="modal-action modal-close btn red" style="float:none">확인</a>
	  </div>
	</div>
	
	<div id="enroll_menu_select" class="info modal">
	  <div class="modal-content">
	    <h4>지금 메뉴를<br>등록하겠습니까?</h4>
	   	<p>추후에도 메뉴를 추가 하실 수 있습니다.</p>
	   	<p>현재 등록을 원하시면 '예' 버튼을 눌러주세요.</p>
	  </div>
	  <div class="modal-footer">
	    <a href="#!" class="modal-action modal-close btn red" style="float:none">예</a>
	    <a href="#!" class="modal-action modal-close btn" style="float:none" id="enroll_menu_no">아니요</a>
	  </div>
	</div>
</div>

