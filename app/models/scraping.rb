require 'selenium-webdriver'

class Scraping
  def self.click_rent_market_price
    # option設定(スクレイピングブラウザの非表示)
    options = Selenium::WebDriver::Chrome::Options.new
    options.add_argument('--headless')
    # Seleniumの起動
    driver = Selenium::WebDriver.for :chrome#, options: options
    # 最初の遷移先の指定
    driver.get "https://suumo.jp/chintai/soba/"
    # 一都三県の家賃相場を調べる為に空の配列を用意
    prefectures = []
    # 関東エリアの中で東京、神奈川、埼玉、千葉のリンク(href)要素を持つものを繰り返し処理で全て取得してリンクを空の配列に格納する
    driver.find_elements(:xpath, '//*[@id="js-areamenuKantoPanel"]/div/div[2]/ul//*[contains(@href, "tokyo")or contains(@href, "kanagawa")or contains(@href, "saitama")or contains(@href, "chiba")]').each do |post|
      prefectures << post.attribute('href')
    end
    # prefecturesに値が格納されているかをif文判定
    if prefectures.present?
      # 格納された一都三県の家賃相場を探すページを順に遷移する
      prefectures.each do |prefecture|
        driver.get(prefecture)
        # 今回は「沿線・駅」の家賃相場を知りたいので、そのhref要素を取得してクリックさせる
        driver.find_element(:xpath, '/html/body/div[4]/div/div[2]/div[1]/ul/li[1]/a').click
        # 先のクリックにより一都三県のそれぞれが保持する沿線のリンクが表示されるので、その全てのhref要素を取得してelementsに格納する
        elements = driver.find_elements(:xpath, '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody//*[contains(@href, "tokyo")or contains(@href, "kanagawa")or contains(@href, "saitama")or contains(@href, "chiba")]')
        # 格納されたelementsをmapメソッドで各沿線のhref要素のみを取り出す繰り返し処理を行いurlsに格納する
        urls = elements.map {|element| element.attribute('href')}
        # 格納された各沿線のhrefに対して順番に遷移を繰り返す
        urls.each do |url|
          driver.get(url)
          # 表示された各沿線の「駅名」と「家賃相場金額」の値を取得して表示する(1回目の表示の間取りはワンルーム)
          infomations = driver.find_elements(:xpath, '//*[@id="js-graphpanel-campus"]/table/tbody//*[contains(@href, "soba")or contains(@class, "graphpanel_matrix-td_graphinfo-strong")]')
          infomations.each do |info|
            puts info.text
          end
          # 次の間取りのボタンの要素を取得してクリック
          driver.find_element(:xpath, '//*[@id="souba_madori-1K/1DK"]').click
          # 次の間取りを選択しクリックしたら情報反映のために更新ボタンの要素を取得してクリック
          driver.find_element(:xpath, '//*[@id="js-graphpanel-form"]/div/div[2]/div/div[1]/a').click
          # 表示された各沿線の「駅名」と「家賃相場金額」の値を取得して表示する(1回目の表示の間取りは1K/1DK)
          infomations = driver.find_elements(:xpath, '//*[@id="js-graphpanel-campus"]/table/tbody//*[contains(@href, "soba")or contains(@class, "graphpanel_matrix-td_graphinfo-strong")]')
          infomations.each do |info|
            puts info.text
          end
          # 次の間取りのボタンの要素を取得してクリック
          driver.find_element(:xpath, '//*[@id="souba_madori-1LDK/2K/2DK"]').click
          # 次の間取りを選択しクリックしたら情報反映のために更新ボタンの要素を取得してクリック
          driver.find_element(:xpath, '//*[@id="js-graphpanel-form"]/div/div[2]/div/div[1]/a').click
          # 表示された各沿線の「駅名」と「家賃相場金額」の値を取得して表示する(1回目の表示の間取りは1LDK/2K/2DK)
          infomations = driver.find_elements(:xpath, '//*[@id="js-graphpanel-campus"]/table/tbody//*[contains(@href, "soba")or contains(@class, "graphpanel_matrix-td_graphinfo-strong")]')
          infomations.each do |info|
            puts info.text
          end
          # 次の間取りのボタンの要素を取得してクリック
          driver.find_element(:xpath, '//*[@id="souba_madori-2LDK/3K/3DK"]').click
          # 次の間取りを選択しクリックしたら情報反映のために更新ボタンの要素を取得してクリック
          driver.find_element(:xpath, '//*[@id="js-graphpanel-form"]/div/div[2]/div/div[1]/a').click
          # 表示された各沿線の「駅名」と「家賃相場金額」の値を取得して表示する(1回目の表示の間取りは2LDK/3K/3DK)
          infomations = driver.find_elements(:xpath, '//*[@id="js-graphpanel-campus"]/table/tbody//*[contains(@href, "soba")or contains(@class, "graphpanel_matrix-td_graphinfo-strong")]')
          infomations.each do |info|
            puts info.text
          end
          driver.find_element(:xpath, '//*[@id="souba_madori-3LDK/4K"]').click
          # 次の間取りを選択しクリックしたら情報反映のために更新ボタンの要素を取得してクリック
          driver.find_element(:xpath, '//*[@id="js-graphpanel-form"]/div/div[2]/div/div[1]/a').click
          # 表示された各沿線の「駅名」と「家賃相場金額」の値を取得して表示する(1回目の表示の間取りは3LDK/4K~)
          infomations = driver.find_elements(:xpath, '//*[@id="js-graphpanel-campus"]/table/tbody//*[contains(@href, "soba")or contains(@class, "graphpanel_matrix-td_graphinfo-strong")]')
          infomations.each do |info|
            puts info.text
          end
        end
      end
    else
      puts 'データが格納されていません'
    end
  end

  def self.search_by_transit_time
    # option設定(スクレイピングブラウザの非表示)
    options = Selenium::WebDriver::Chrome::Options.new
    options.add_argument('--headless')
    # Seleniumの起動
    driver = Selenium::WebDriver.for :chrome#, options: options
    # 最初の遷移先の指定(東京クリック編)
    driver.get "https://suumo.jp/jj/chintai/kensaku/FR301FB005/?ar=030&bs=040"
    # 今回は目的地を２駅設定したいので最初に「駅を追加する」のボタン要素を取得してクリックする
    driver.find_element(:xpath, '//*[@id="js-timePanel-addStationBtn"]/a').click
    # 1駅目のフォームの要素取得と入力
    form_1 = driver.find_element(:xpath, '//*[@id="js-timePanel-ekiText_1"]')
    # フォーム入力の値はアプリ上でユーザーが入力した情報をインスタンス変数で使用できるようにする
    @q_1 = '東京'
    form_1.send_keys @q_1
    # 1駅目の所要時間のセレクトタグの取得
    time_1 = driver.find_element(:tag_name, 'select')
    select_1 = Selenium::WebDriver::Support::Select.new(time_1)
    # 所要時間の選択はアプリ上のユーザーの選択した情報をインスタンス変数で使用できるようにする
    @t_1 = '10分以内'
    @t_2 = '20分以内'
    @t_3 = '30分以内'
    @t_4 = '40分以内'
    @t_5 = '50分以内'
    @t_6 = '60分以内'
    @t_7 = '70分以内'
    @t_8 = '80分以内'
    @t_9 = '90分以内'
    select_1.select_by(:text, @t_5)
    # 2駅目のフォームの要素取得と入力
    form_2 = driver.find_element(:xpath, '//*[@id="js-timePanel-ekiText_2"]')
    # フォーム入力の値はユーザーが入力した情報をインスタンス変数で使用できるようにする
    @q_2 = '浦和美園'
    form_2.send_keys @q_2
    # 2駅目の所要時間のセレクトタグの取得(2回目は:xpathとしないと1回目と同じセレクトタグを取得してしまい上手く動作しない)
    time_2 = driver.find_element(:xpath, '//*[@id="js-timePanel-display_2"]/div[1]/dl[2]/dd/select')
    select_2 = Selenium::WebDriver::Support::Select.new(time_2)
    select_2.select_by(:text, @t_1)
    # 「住みたいエリア」を順に東京をクリック
    driver.find_element(:xpath, '//*[@id="ta13"]').click
    # submitボタンの要素取得と実行(検索開始)
    driver.find_element(:xpath, '//*[@id="js-contents-timePanel"]/div[2]/div[7]/a').click
    sleep(0.5)
    # 検索結果の表示(とりあえず件数)
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
        sleep(1)
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

    # 最初の画面へ戻り神奈川の検索結果を取得しに行く
    driver.get "https://suumo.jp/jj/chintai/kensaku/FR301FB005/?ar=030&bs=040"
    # 「住みたいエリア」を順に神奈川をクリック
    driver.find_element(:xpath, '//*[@id="ta14"]').click
    # submitボタンの要素取得と実行(検索開始)
    driver.find_element(:xpath, '//*[@id="js-contents-timePanel"]/div[2]/div[7]/a').click
    sleep(0.5)
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
          puts "神奈川 #{info.text}"
        end
        sleep(1)
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
      puts "神奈川 #{element.text}"
    else
      puts 'ERROR!!'
    end

    # 最初の画面へ戻り埼玉の検索結果を取得しに行く
    driver.get "https://suumo.jp/jj/chintai/kensaku/FR301FB005/?ar=030&bs=040"
    # 「住みたいエリア」を順に埼玉をクリック
    driver.find_element(:xpath, '//*[@id="ta11"]').click
    # submitボタンの要素取得と実行(検索開始)
    driver.find_element(:xpath, '//*[@id="js-contents-timePanel"]/div[2]/div[7]/a').click
    sleep(0.5)
    # 検索結果の表示
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
          puts "埼玉 #{info.text}"
        end
        sleep(1)
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
      puts "埼玉 #{element.text}"
    else
      puts 'ERROR!!'
    end

    # 最初の画面へ戻り千葉の検索結果を取得しに行く
    driver.get "https://suumo.jp/jj/chintai/kensaku/FR301FB005/?ar=030&bs=040"
    # 「住みたいエリア」を順に千葉をクリック
    driver.find_element(:xpath, '//*[@id="ta12"]').click
    # submitボタンの要素取得と実行(検索開始)
    driver.find_element(:xpath, '//*[@id="js-contents-timePanel"]/div[2]/div[7]/a').click
    sleep(0.5)
    # 検索結果の表示
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
          puts "千葉 #{info.text}"
        end
        sleep(1)
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
      puts "千葉 #{element.text}"
    else
      puts 'ERROR!!'
    end
  end
end
