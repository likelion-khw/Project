<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@	include file="../modal/qna_modal.jsp"%>

<script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.98.2/js/materialize.min.js"></script>
<style>

@media only screen and (min-width : 50%) and (max-width : 60%) {
ul {
  text-align: center;
}
.header{
	width: 80%;
	margin: auto;
}
#imaginary_container{
    margin-top:20%; /* Don't copy this */
}
.stylish-input-group .input-group-addon{
    background: white !important; 
}
.stylish-input-group .form-control{
	border-right:0; 
	box-shadow:0 0 0; 
	border-color:#ccc;
}
  }
</style>

<div class="header">
  		<div class="main_text z-depth-1 row" style="margin-left:auto; margin-right: auto;">
			<div class="col s12">
			<img src="resources/img/qna.png" class="qnaimg" style="max-width:1024px; max-height:800px; width:100%; height:100%;">
			</div>
		</div>
</div>
<div class="container">
	<div class="row">
        <div class="col-sm-6 col-sm-offset-3">
            <div id="imaginary_container"> 
                <div class="input-group stylish-input-group">
        				<input type="search" id="keyword" placeholder="궁금하시거나 필요하신 사항을 검색해주세요..." />
                    <span class="input-group-addon">
                    <span class="glyphicon glyphicon-search"></span> 
                    </span>
                </div>
            </div>
        </div>
	</div>
</div>

  <ul class="collapsible popout" data-collapsible="accordion">
    <li>
      <div class="collapsible-header" id="exam0"><i class="material-icons">info</i><span style="color:blue;float:left;">[whaME]</span>&emsp;&emsp;제공서비스는 무엇인가요?</div>
      <div class="collapsible-body" style="text-align:center;">
      <span><h3>제공서비스는 무엇인가요?</h3>
      <p>길거리의 간판들의 사진을 이용하여, 상가의 정보들을 제공하는 서비스입니다. 직접 들어가보지 않고도 음식점들의 정보를 보실 수 있습니다.</p>
      <p>상가의 메뉴, 위치, 가격, 기타 등의 정보를 제공합니다. 또한 고객님의 발자취를 한눈에 볼 수 있도록 서비스를 제공하고 있습니다.</p></span></div>
    </li>
    <li>
      <div class="collapsible-header" id="exam1"><i class="material-icons">info</i><span style="color:blue;float:left;">[whaME]</span>&emsp;&emsp;Whame 사용법</div>
      <div class="collapsible-body" style="text-align:center;">
      <span><h3>Whame 사용법</h3>
      		<p>1. 핸드폰은 되도록 가로 화면으로 촬영해주세요.</p>
			<i class="material-icons medium">stay_current_portrait</i><i class="material-icons medium" style="color:blue">forward</i><i class="material-icons medium">stay_current_landscape</i>
			<p>2. 정확한 정보제공을 위해서 사용자의 위치정보가 필요합니다.</p>
			<i class="material-icons medium">gps_fixed</i>
			<p>3. 이미지를 업로드 시키면 간판의 정확성 인식을 위한 좌표를 찍는 화면으로 이동합니다.</p></span></div>
    </li>
    <li>
      <div class="collapsible-header" id="exam2"><i class="material-icons">info</i><span style="color:blue;float:left;">[whaME]</span>&emsp;&emsp;사업자 등록시 필요사항</div>
      <div class="collapsible-body" style="text-align:center;"><span>
      <h3>사업자 등록시 필요사항</h3>
      <p>사업자고객님들께서는 음식점을 등록 하실 수 있습니다. 또한, 지속적으로 메뉴를 수정 및 삭제를 할 수 있습니다.<br>아래와 같이 따라해주시면 되겠습니다.</p>
      <p><h4>상가 등록 방법</h4>
      1. 우선 목록에 알맞게 작성해주세요. 사업자등록번호 작성후 꼭!! 조회를 누르셔야 됩니다.<br>
      2. 간판이미지 등록시 가능한 상호명이 잘 보일 수 있는 사진으로 등록해주세요.<br>
      3. 사진을 확인하시고, 상호명을 중심으로 4개의 점을 찍어서 잘보이게 해주세요, 만약 사진의 이상이 있다면, 다시 사진을 등록해주세요.</p>
      <p><h4>메뉴 등록 및 수정 방법</h4>
      1. 위에 과정을 따라하셨다면, 메뉴 할 수 있습니다. 목록에 알맞게 작성해주세요.<br>
      2. 오른쪽 메뉴에 보시면 Shop이라는 메뉴 아래 음식점 정보가 있습니다. 등록하신 상가정보,메뉴정보,행사정보를 보실 수 있으며, 수정 및 추가도 가능하십니다.<br>
      </p>
      </span></div>
    </li>
        <li>
      <div class="collapsible-header" id="exam3"><i class="material-icons">info</i><span style="color:blue;float:left;">[whaME]</span>&emsp;&emsp;카테고리 검색방법</div>
      <div class="collapsible-body" style="text-align:center;">
      <span><h3>카테고리 검색방법</h3>
      <p>Whame 메인 페이지에 Start버튼을 누르게 되면 검색 버튼을 찾아 누르시면, 카테고리별 음식점을 검색 하실 수 있습니다.</p>
      <p>.</p></span></div>
    </li>
        <li>
      <div class="collapsible-header" id="exam4"><i class="material-icons">info</i><span style="color:blue;float:left;">[whaME]</span>&emsp;&emsp;Top View</div>
      <div class="collapsible-body" style="text-align:center;">
      <span><h3>Top View</h3>
      <p>각 지역별 등록된 상가들의 갯수와 가장많이 스크랩트가 된 상가를 보여줍니다.</p>
      <p>오호호호호.</p></span></div>
    </li>
        <li>
      <div class="collapsible-header"id="exam5"><i class="material-icons">info</i><span style="color:blue;float:left;">[whaME]</span>&emsp;&emsp;New Store</div>
      <div class="collapsible-body" style="text-align:center;">
      <span><h3>New stroe</h3>
      <p>최근 등록된 상가들을 보여줍니다. </p>
      <p>.</p></span></div>
    </li>
        <li>
      <div class="collapsible-header" id="exam6"><i class="material-icons">info</i><span style="color:blue;float:left;">[whaME]</span>&emsp;&emsp;History</div>
      <div class="collapsible-body" style="text-align:center;">
      <span><h3>History</h3>
      <p>간판조회를 하게 되면, 히스토리에 자동적으로 생성됩니다. 지도에 마커로 표시가 되며 마커를 클릭하게 되면, 해당 가게에 히스토리 목록으로 이동하게 됩니다.</p>
      <p>.</p></span></div>
      </li>
  </ul>
  <div id="test" style="text-align: center;"></div><br><br>
<div class="container">
<div class="re_memberform1 center-align">
 <table>
 	<tr>
 		<td>
 			<i class="material-icons">assignment</i><span>원하시는 답변을 찾지못하셨다면, 고객센터에 문의해주세요.</span>
			<a href="#qna" class="btn" style="float:right;">문의하기</a>
		</td>
	</tr> 
</table>
</div>
</div>
    <script type="text/javascript">
    $(document).ready(function() {
        $("#keyword").keyup(function() {
            var k = $(this).val().toLowerCase();
            var count =0;
            for(var i = 0; i<$('div.collapsible-header').length; i++){	
                if($('#exam'+i+'').text().toLowerCase().indexOf(k) == -1){
                	$('#exam'+i+'').css('display','none');
	                count++
                }else{
                	$('#exam'+i+'').css('display','block');
                	$('#test').text('');
                }
                if(count == $('div.collapsible-header').length){
                	$('#exam'+i+'').css('display','none');
                	$('#test').text('해당검색 자료가 존재하지 않습니다.');
                }
            }
        })
    })
    </script>