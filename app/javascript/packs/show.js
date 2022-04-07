//動作確認用　文字を赤くする
$(function(){
  $("#test").css("color","red")
});
//submitボタンを押すと「RESULT」から「処理中・・・」へボタンの文字が変わる
window.addEventListener('DOMContentLoaded', function(){
  $(document).on('click', "#btn", function(){
    $(this).text('処理中・・・');
  });
});