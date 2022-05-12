//submitボタンを押すと「RESULT」から「処理中・・・」へボタンの文字が変わる
//RESULTボタンをクリック後15秒経っても処理が終わらなければリトライボタンを表示して最後クリックさせて処理が成功するまで繰り返す
$(function(){
  $('form').submit(function(e) {
    $('#btn').val('処理中・・・'), setInterval(function() {
      $('#btn').val('リトライ')
    }, 25000);
  });
});