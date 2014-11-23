// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

//hide some fields

$(function() {
  $('#project_info_has_data_center').change(function (){
  	$('#order_field_changed').val('supplier_id');
    $.get(window.location, $('form').serialize(), null, "script");
    return false;
  });
});