<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

	<div id="map" style="width:100%;height:350px;"></div>
	<script type="text/javascript" src="//apis.daum.net/maps/maps3.js?apikey=bf657f021b380e68b1a07c1e4fd92c88"></script>

	<script src="resources/jquery-3.1.1.min.js"></script> 
	<script type="text/javascript">
	
	var x = ${data};
	var length = ${length};
	var position=[];

		for(var i=1; i<=length*2; i++){
			position[i] = x.slice(i-1,i);
		}
		
		var container = document.getElementById('map');
		var options = {
			center: new daum.maps.LatLng(37.49655,127.02964),
			level: 8
		};

		var map = new daum.maps.Map(container, options);
		for(var i=1; i<=length; i++){
			var marker = new daum.maps.Marker({
			    map: map,
			    position: new daum.maps.LatLng(position[(2*i)-1],position[i*2])
			});
		    // 마커에 표시할 인포윈도우를 생성합니다 
		    var infowindow = new daum.maps.InfoWindow({
		        content: "안뇽" // 인포윈도우에 표시할 내용
		    });
		    daum.maps.event.addListener(marker, 'mouseover', makeOverListener(map, marker, infowindow));
		    daum.maps.event.addListener(marker, 'mouseout', makeOutListener(infowindow));
		}
		// 인포윈도우를 표시하는 클로저를 만드는 함수입니다 
		function makeOverListener(map, marker, infowindow) {
		    return function() {
		        infowindow.open(map, marker);
		    };
		}

		// 인포윈도우를 닫는 클로저를 만드는 함수입니다 
		function makeOutListener(infowindow) {
		    return function() {
		        infowindow.close();
		    };
		}
		// 마커에 클릭이벤트를 등록합니다
		daum.maps.event.addListener(marker, 'click', function() {
		      // 마커 위에 인포윈도우를 표시합니다
		      infowindow.open(map, marker);  
		});
		
		function bnt_click() {
			alert("글쓰기 화면으로 이동하겠습니다.");
		}
	</script>


 <div class="row" style="width:50%;height:400px">
          <div class="col s12 m6" >
          
            <div class="card">
            <h4 class="light" style="text-align: center;">1일차 맛집 투어</h4>
              <div class="card-image waves-effect waves-block waves-light">
                <img class="activator" src="http://materializecss.com/images/office.jpg" style="width:100; height:100;">
              </div>
              <div class="card-content">
                <span class="card-title activator grey-text text-darken-4">통한우리집<i class="material-icons right">more_vert</i></span>

                <p><a href="#!">링크걸기</a></p>
              </div>
              <div class="card-reveal">
                <span class="card-title grey-text text-darken-4">통한 우리집<i class="material-icons right">close</i></i></span>
                <p>오늘 하루 여기 놀러가서 어쩌구 저쩌구 이러쿵 저러궁 ~~~~~~~~~~</p>
              </div>
              <div class="card-action">
                <a href="#">This is a link</a>
                <a href="#">This is a link</a>
              </div>
            </div>
                       <div class="card">
            <h4 class="light" style="text-align: center;">1일차 맛집 투어</h4>
              <div class="card-image waves-effect waves-block waves-light">
                <img class="activator" src="http://materializecss.com/images/office.jpg" style="width:100; height:100;">
              </div>
              <div class="card-content">
                <span class="card-title activator grey-text text-darken-4">통한우리집<i class="material-icons right">more_vert</i></span>

                <p><a href="#!">링크걸기</a></p>
              </div>
              <div class="card-reveal">
                <span class="card-title grey-text text-darken-4">통한 우리집<i class="material-icons right">close</i></i></span>
                <p>오늘 하루 여기 놀러가서 어쩌구 저쩌구 이러쿵 저러궁 ~~~~~~~~~~</p>
              </div>
              <div class="card-action">
                <a href="#">This is a link</a>
                <a href="#">This is a link</a>
              </div>
            </div>
          </div>
          
</div>

<input type="button" onclick="bnt_click();" id="return" value="글쓰기">