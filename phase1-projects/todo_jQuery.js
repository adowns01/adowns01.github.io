$(document).ready(function(){
  $("#add").click(function(){
    var new_item = $("#item").val();
    $("list ol").append('<li>' + '<form><input type="checkbox" class = "checkbox"></form><span class = "list">    ' + new_item + '</span></li>');
    $("#item").val("");
  })
  // $("#item").keypress(function(target){

  //   if ($("#item").val() != "" && target.which == 13){
  //     var new_item = $("#item").val();
  //     $("list ol").append('<li>' + '<form><input type="checkbox" class = "checkbox"></form>    ' + new_item + '</li>');
  //     $("#item").val("");
  //     }
  // })
  $("ol").on('click', '.checkbox', function(){
    $(this).closest("li").toggleClass("checked");
  })
  $("#delete_button").click(function(){
    $(".checked").remove();
  })

  $('#add_button').on('submit', function(e){
    e.preventDefault()
    var new_item = $("#item").val();
    $("list ol").append('<li>' + '<form><input type="checkbox" class = "checkbox"></form><span class = "list">    ' + new_item + '</span></li>');
    $("#item").val("");
  })

    $(function() {
    $("#sortable").sortable();
    $("#sortable").disableSelection();
  })
})



