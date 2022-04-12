class ScrapinSearchTransitTime
  require 'selenium-webdriver'
  require 'webdrivers'

  # 変数化
  # 駅追加ボタン
  @add_station_btn = '//*[@id="js-timePanel-addStationBtn"]/a'
  # 目的地(駅)
  @user_answer_station_1 = '渋谷' #動作確認用
  @user_answer_station_2 = '武蔵中原' #動作確認用
  @destination_1 = @user_answer_station_1
  @destination_2 = @user_answer_station_2
  # 所要時間
  @user_answer_time_1 = '30分以内' #動作確認用
  @user_answer_timi_2 = '10分以内' #動作確認用
  @transit_time_1 = @user_answer_time_1
  @transit_time_2 = @user_answer_timi_2
  # 「住みたいエリア」ボタン
  @tokyo_btn = '//*[@id="ta13"]'
  @kanagawa_btn = '//*[@id="ta14"]'
  @saitama_btn = '//*[@id="ta11"]'
  @chiba_btn = '//*[@id="ta12"]'
  # 検索開始ボタン
  @search_start_btn = '//*[@id="js-contents-timePanel"]/div[2]/div[7]/a'

  def self._exec_tokyo
    # option設定(スクレイピングブラウザの非表示)
    options = Selenium::WebDriver::Chrome::Options.new
    options.add_argument('--headless')
    # Seleniumの起動
    driver = Selenium::WebDriver.for :chrome#, options: options
    # 最初の遷移先の指定
    driver.get "https://suumo.jp/jj/chintai/kensaku/FR301FB005/?ar=030&bs=040"
    # 今回は目的地を２駅設定したいので最初に「駅を追加する」のボタン要素を取得してクリックする
    driver.find_element(:xpath, @add_station_btn).click
    # 1駅目のフォームの要素取得と入力
    form_1 = driver.find_element(:xpath, '//*[@id="js-timePanel-ekiText_1"]')
    # フォーム入力の値はアプリ上でユーザーが入力した情報をインスタンス変数で使用できるようにする
    form_1.send_keys @destination_1
    # 1駅目の所要時間のセレクトタグの取得
    time_1 = driver.find_element(:tag_name, 'select')
    select_1 = Selenium::WebDriver::Support::Select.new(time_1)
    # 所要時間の選択はアプリ上のユーザーの選択した情報をインスタンス変数で使用できるようにする
    select_1.select_by(:text, @transit_time_1)
    # 2駅目のフォームの要素取得と入力
    form_2 = driver.find_element(:xpath, '//*[@id="js-timePanel-ekiText_2"]')
    # フォーム入力の値はユーザーが入力した情報をインスタンス変数で使用できるようにする
    form_2.send_keys @destination_2
    # 2駅目の所要時間のセレクトタグの取得(2回目は:xpathとしないと1回目と同じセレクトタグを取得してしまい上手く動作しない)
    time_2 = driver.find_element(:xpath, '//*[@id="js-timePanel-display_2"]/div[1]/dl[2]/dd/select')
    select_2 = Selenium::WebDriver::Support::Select.new(time_2)
    select_2.select_by(:text, transit_time_2)
    # 「住みたいエリア」の東京の要素を取得してクリック
    driver.find_element(:xpath, @tokyo_btn).click
    # submitボタンの要素取得と実行(検索開始)
    driver.find_element(:xpath, @search_start_btn).click
    # 検索結果の表示(駅情報を頭5ページ分のみ取得する)
    # 検索結果のページに該当物件の件数の要素(paginate_set-hit)もしくは該当物件が存在しない場合の要素(error_pop-txt)のいずれかにヒットする要素を取得する
    element = driver.find_element(:xpath, '//*[@id="js-leftColumnForm"]//*[contains(@class, "paginate_set-hit")or contains(@class, "error_pop-txt")]')
    # 要素を取得してelementに格納できたらケースごとに出力する
    # 該当物件が存在する場合の処理(classの要素で判定)
    if element.attribute('class') == 'paginate_set-hit'
      # 5回分のページ遷移が真の間は処理が繰り返されるようにする
      page = 0
      while page < 5 do
        # 表示されたページの物件情報の中から駅情報の要素を取得してinfomations_pageへ格納する
        infomations_page = driver.find_elements(:xpath, '/html/body/div[5]/div/div[2]/div/div[1]//*[contains(@class, "cassetteitem_detail-text")]')
        # 格納された駅情報を順に表示する
        infomations_page.each do |info|
          puts "東京 #{info.text}"
        end
        # 表示されたページに対して「次へ」ボタンの要素が1つ以上存在すれば、要素を取得してクリックする
        if driver.find_elements(:xpath, '//*[@id="js-leftColumnForm"]/div[11]/div[2]//*[contains(text(), "次へ")]').size > 0
          driver.find_element(:xpath, '//*[@id="js-leftColumnForm"]/div[11]/div[2]//*[contains(text(), "次へ")]').click
        # 「次へ」ボタンの要素が存在しない場合はbreakしてループを抜ける
        else
          break
        end
        page += 1
      end
    # 該当物件が存在しない場合の処理(classの要素で判定)
    elsif element.attribute('class') == 'error_pop-txt'
      puts "東京 #{element.text}"
    else
      puts 'ERROR!!'
    end
  end
end



#  # 最初の画面へ戻り神奈川の検索結果を取得しに行く
#  driver.get "https://suumo.jp/jj/chintai/kensaku/FR301FB005/?ar=030&bs=040"
#  # 「住みたいエリア」を順に神奈川をクリック
#  driver.find_element(:xpath, '//*[@id="ta14"]').click
#  # submitボタンの要素取得と実行(検索開始)
#  driver.find_element(:xpath, '//*[@id="js-contents-timePanel"]/div[2]/div[7]/a').click
#  # 検索結果の表示(駅情報を頭5ページ分のみ取得する)
#  # 検索結果のページに該当物件の件数の要素(paginate_set-hit)もしくは該当物件が存在しない場合の要素(error_pop-txt)のいずれかにヒットする要素を取得する
#  element = driver.find_element(:xpath, '//*[@id="js-leftColumnForm"]//*[contains(@class, "paginate_set-hit")or contains(@class, "error_pop-txt")]')
#  # 要素を取得してelementに格納できたらケースごとに出力する
#  # 該当物件が存在する場合の処理(classの要素で判定)
#  if element.attribute('class') == 'paginate_set-hit'
#    # 5回分のページ遷移が真の間は処理が繰り返されるようにする
#    page = 0
#    while page < 5 do
#      # 表示されたページの物件情報の中から駅情報の要素を取得してinfomations_pageへ格納する
#      infomations_page = driver.find_elements(:xpath, '/html/body/div[5]/div/div[2]/div/div[1]//*[contains(@class, "cassetteitem_detail-text")]')
#      # 格納された駅情報を順に表示する
#      infomations_page.each do |info|
#        puts "神奈川 #{info.text}"
#      end
#      # 表示されたページに対して「次へ」ボタンの要素が1つ以上存在すれば、要素を取得してクリックする
#      if driver.find_elements(:xpath, '//*[@id="js-leftColumnForm"]/div[11]/div[2]//*[contains(text(), "次へ")]').size > 0
#        driver.find_element(:xpath, '//*[@id="js-leftColumnForm"]/div[11]/div[2]//*[contains(text(), "次へ")]').click
#      # 「次へ」ボタンの要素が存在しない場合はbreakしてループを抜ける
#      else
#        break
#      end
#      page += 1
#    end
#  # 該当物件が存在しない場合の処理(classの要素で判定)
#  elsif element.attribute('class') == 'error_pop-txt'
#    puts "神奈川 #{element.text}"
#  else
#    puts 'ERROR!!'
#  end
#  # 最初の画面へ戻り埼玉の検索結果を取得しに行く
#  driver.get "https://suumo.jp/jj/chintai/kensaku/FR301FB005/?ar=030&bs=040"
#  # 「住みたいエリア」を順に埼玉をクリック
#  driver.find_element(:xpath, '//*[@id="ta11"]').click
#  # submitボタンの要素取得と実行(検索開始)
#  driver.find_element(:xpath, '//*[@id="js-contents-timePanel"]/div[2]/div[7]/a').click
#  # 検索結果の表示(駅情報を頭5ページ分のみ取得する)
#  # 検索結果のページに該当物件の件数の要素(paginate_set-hit)もしくは該当物件が存在しない場合の要素(error_pop-txt)のいずれかにヒットする要素を取得する
#  element = driver.find_element(:xpath, '//*[@id="js-leftColumnForm"]//*[contains(@class, "paginate_set-hit")or contains(@class, "error_pop-txt")]')
#  # 要素を取得してelementに格納できたらケースごとに出力する
#  # 該当物件が存在する場合の処理(classの要素で判定)
#  if element.attribute('class') == 'paginate_set-hit'
#    # 5回分のページ遷移が真の間は処理が繰り返されるようにする
#    page = 0
#    while page < 5 do
#      # 表示されたページの物件情報の中から駅情報の要素を取得してinfomations_pageへ格納する
#      infomations_page = driver.find_elements(:xpath, '/html/body/div[5]/div/div[2]/div/div[1]//*[contains(@class, "cassetteitem_detail-text")]')
#      # 格納された駅情報を順に表示する
#      infomations_page.each do |info|
#        puts "埼玉 #{info.text}"
#      end
#      # 表示されたページに対して「次へ」ボタンの要素が1つ以上存在すれば、要素を取得してクリックする
#      if driver.find_elements(:xpath, '//*[@id="js-leftColumnForm"]/div[11]/div[2]//*[contains(text(), "次へ")]').size > 0
#        driver.find_element(:xpath, '//*[@id="js-leftColumnForm"]/div[11]/div[2]//*[contains(text(), "次へ")]').click
#      # 「次へ」ボタンの要素が存在しない場合はbreakしてループを抜ける
#      else
#        break
#      end
#      page += 1
#    end
#  # 該当物件が存在しない場合の処理(classの要素で判定)
#  elsif element.attribute('class') == 'error_pop-txt'
#    puts "埼玉 #{element.text}"
#  else
#    puts 'ERROR!!'
#  end
#  # 最初の画面へ戻り千葉の検索結果を取得しに行く
#  driver.get "https://suumo.jp/jj/chintai/kensaku/FR301FB005/?ar=030&bs=040"
#  # 「住みたいエリア」を順に千葉をクリック
#  driver.find_element(:xpath, '//*[@id="ta12"]').click
#  # submitボタンの要素取得と実行(検索開始)
#  driver.find_element(:xpath, '//*[@id="js-contents-timePanel"]/div[2]/div[7]/a').click
#  # 検索結果の表示(駅情報を頭5ページ分のみ取得する)
#  # 検索結果のページに該当物件の件数の要素(paginate_set-hit)もしくは該当物件が存在しない場合の要素(error_pop-txt)のいずれかにヒットする要素を取得する
#  element = driver.find_element(:xpath, '//*[@id="js-leftColumnForm"]//*[contains(@class, "paginate_set-hit")or contains(@class, "error_pop-txt")]')
#  # 要素を取得してelementに格納できたらケースごとに出力する
#  # 該当物件が存在する場合の処理(classの要素で判定)
#  if element.attribute('class') == 'paginate_set-hit'
#    # 5回分のページ遷移が真の間は処理が繰り返されるようにする
#    page = 0
#    while page < 5 do
#      # 表示されたページの物件情報の中から駅情報の要素を取得してinfomations_pageへ格納する
#      infomations_page = driver.find_elements(:xpath, '/html/body/div[5]/div/div[2]/div/div[1]//*[contains(@class, "cassetteitem_detail-text")]')
#      # 格納された駅情報を順に表示する
#      infomations_page.each do |info|
#        puts "千葉 #{info.text}"
#      end
#      # 表示されたページに対して「次へ」ボタンの要素が1つ以上存在すれば、要素を取得してクリックする
#      if driver.find_elements(:xpath, '//*[@id="js-leftColumnForm"]/div[11]/div[2]//*[contains(text(), "次へ")]').size > 0
#        driver.find_element(:xpath, '//*[@id="js-leftColumnForm"]/div[11]/div[2]//*[contains(text(), "次へ")]').click
#      # 「次へ」ボタンの要素が存在しない場合はbreakしてループを抜ける
#      else
#        break
#      end
#      page += 1
#    end
#  # 該当物件が存在しない場合の処理(classの要素で判定)
#  elsif element.attribute('class') == 'error_pop-txt'
#    puts "千葉 #{element.text}"
#  else
#    puts 'ERROR!!'
#  end
