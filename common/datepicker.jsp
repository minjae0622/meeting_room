<!-- jquery date picker -->
<link rel="stylesheet" href="/module/jquery-ui.css" type="text/css">
<script type="text/javascript" src="/module/jquery-ui.js"></script>
<script type="text/javascript">
function initDatePicker(domobjid){
	var datepickerSettings = {
			changeMonth: true, 
	        changeYear: true,
			dayNames: ['일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일'],
			dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'], 
			monthNamesShort: ['1','2','3','4','5','6','7','8','9','10','11','12'],
			monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
			dateFormat:'yy-mm-dd',
			showMonthAfterYear:true,
			firstDay: 1 // Start with Monday
		};	
	$(function(){
		//$('#txtStartDT').datepicker(datepickerSettings);
		$('#' + domobjid).datepicker(datepickerSettings);
	});		
}
</script>
<!-- // jquery date picker -->
