//submitボタンを押すと「RESULT」から「処理中・・・」へボタンの文字が変わる
//RESULTボタンをクリック後25秒経っても処理が終わらなければリトライボタンを表示して最後クリックさせて処理が成功するまで繰り返す
$(function(){
  $('form').submit(function(e) {
    $('#result_btn').val('処理中・・・'), setInterval(function() {
      $('#result_btn').val('リトライ')
    }, 25000);
  });
});