/**
 * 
 */

$(function(){
	$("form").submit(function(){
		var bool=true;
		var inputs=$(this).find("td").children().filter("[name]");
		inputs.each(function(){
			if($(this).val()==""){
				alert($(this).parent().prev().text()+"를 입력하세요");
				$(this).focus();
				bool=false;
				return false;
			}
		});
		return bool;
	});
});