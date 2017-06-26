<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="../modal/search_cg_modal.jsp" %>
 <a href="#" data-activates="search_cg1" class="button-collapse test"><i class="material-icons">menu</i></a>
 
<script type="text/javascript">
$(document).ready(function(){
	 $('.button-collapse.search_cg').sideNav({
	      menuWidth: 400, // Default is 300
	      edge: 'bottom', // Choose the horizontal origin
	      closeOnClick: true, // Closes side-nav on <a> clicks, useful for Angular/Meteor
	      draggable: true // Choose whether you can drag to open on touch screens
	    }
	  );
    $("#testm").click(function(event){            
       $('#modal112').modal('open');
	});

  });
</script>
