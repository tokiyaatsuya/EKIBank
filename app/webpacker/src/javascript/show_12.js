// 最後の質問に回答して、formのsubmitが実行されるタイミングでLoading画面を差し込む
$(function(){
  // hideメソッドでloading画面の初期表示をしない
  $('#loading').hide();
  // submitボタンが実行されたタイミングで動作を起こしloading画面を表示する
  $('form').submit(function(e) {
    // loading画面の表示インターバルを60秒として、60秒後は　loading画面を非表示にし、RESULTボタンの表示をリトライと変更する
    $('#loading').show(), setInterval(function() {
      $('#loading').hide();
      $('#result_btn').val('リトライ');
    }, 60000);
  });
});