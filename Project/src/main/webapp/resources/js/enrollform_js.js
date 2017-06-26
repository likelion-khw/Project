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
         data : {
            'store_category': store_category
            },
         success: function(data){
            for(var index=0; index<data.length; index++){
               var option = $("<option value="+data[index]+">"+data[index]+"</option>");
               $('#store_category').append(option);
            }
         },  error : function(request,status,error){alert("code:"+request.status+"\n\n"+"message:"+request.responseText+"\n\n\n"+"error:"+error);
         
         }
      });
}