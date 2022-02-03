require 'selenium-webdriver'

# xpathの要素取得について "//*" とする事でtbody以降全てのnodeを対象にする
# hrefタグに特定の文字列が含まれる要素の指定 => [contains(@href, "tokyo")]
# コンソールにリンクのテキスト名を表示させる
  #elements.each do |element|
  #  puts element.text
  #end

class Scraping
  def self.click_rent_market_price
    # Seleniumの起動
    driver = Selenium::WebDriver.for :chrome
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
          # 間取りの選択はアプリ上のユーザーの選択した情報をインスタンス変数で使用できるようにする
          @madori_1 = '//*[@id="souba_madori-oneroom"]'
          @madori_2 = '//*[@id="souba_madori-1K/1DK"]'
          @madori_3 = '//*[@id="souba_madori-1LDK/2K/2DK"]'
          @madori_4 = '//*[@id="souba_madori-2LDK/3K/3DK"]'
          @madori_5 = '//*[@id="souba_madori-3LDK/4K"]'
          # 間取りごとにラジオボタンの要素を取得してクリック
          driver.find_element(:xpath, @madori_1).click
          sleep(1)
          # 間取りボタンをクリック後に更新ボタンをクリック
          submit_btn = '//*[@id="js-graphpanel-form"]/div/div[2]/div/div[1]/a'
          driver.find_element(:xpath, submit_btn).click
          sleep(1)
          driver.find_element(:xpath, @madori_2).click
          sleep(1)
          driver.find_element(:xpath, submit_btn).click
          sleep(1)
          driver.find_element(:xpath, @madori_3).click
          sleep(1)
          driver.find_element(:xpath, submit_btn).click
          sleep(1)
          driver.find_element(:xpath, @madori_4).click
          sleep(1)
          driver.find_element(:xpath, submit_btn).click
          sleep(1)
          driver.find_element(:xpath, @madori_5).click
          sleep(1)
          driver.find_element(:xpath, submit_btn).click
          sleep(1)
        end
      end
    else
      puts 'データが格納されていません'
    end
  end

  def self.search_by_transit_time
    # seleniumの起動
    driver = Selenium::WebDriver.for :chrome
    # 最初の遷移先の指定(東京クリック編)
    driver.get "https://suumo.jp/jj/chintai/kensaku/FR301FB005/?ar=030&bs=040"
    # 今回は目的地を２駅設定したいので最初に「駅を追加する」のボタン要素を取得してクリックする
    driver.find_element(:xpath, '//*[@id="js-timePanel-addStationBtn"]/a').click
    # 1駅目のフォームの要素取得と入力
    form_1 = driver.find_element(:xpath, '//*[@id="js-timePanel-ekiText_1"]')
    # フォーム入力の値はアプリ上でユーザーが入力した情報をインスタンス変数で使用できるようにする
    @q_1 = '新宿'
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
    select_1.select_by(:text, @t_3)
    # 2駅目のフォームの要素取得と入力
    form_2 = driver.find_element(:xpath, '//*[@id="js-timePanel-ekiText_2"]')
    # フォーム入力の値はユーザーが入力した情報をインスタンス変数で使用できるようにする
    @q_2 = '飛田給'
    form_2.send_keys @q_2
    # 2駅目の所要時間のセレクトタグの取得(2回目は:xpathとしないと1回目と同じセレクトタグを取得してしまい上手く動作しない)
    time_2 = driver.find_element(:xpath, '//*[@id="js-timePanel-display_2"]/div[1]/dl[2]/dd/select')
    select_2 = Selenium::WebDriver::Support::Select.new(time_2)
    @tt_1 = '10分以内'
    @tt_2 = '20分以内'
    @tt_3 = '30分以内'
    @tt_4 = '40分以内'
    @tt_5 = '50分以内'
    @tt_6 = '60分以内'
    @tt_7 = '70分以内'
    @tt_8 = '80分以内'
    @tt_9 = '90分以内'
    select_2.select_by(:text, @tt_1)
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
      # 表示された1ページ目の物件情報の中から駅情報の要素を取得してinfomationsへ格納する
      infomations_page_1 = driver.find_elements(:xpath, '/html/body/div[5]/div/div[2]/div/div[1]//*[contains(@class, "cassetteitem_detail-text")]')
      # 格納された駅情報を順番に表示する
      infomations_page_1.each do |info|
        puts "東京 #{info.text}"
      end
      # 1ページ目下部に「次へ」ボタンの要素が存在すれば取得してクリックする。もし存在せず現在のページで終わりであれば現在のページの数字を取得する
      next_btn = driver.find_elements(:xpath, '//*[@id="js-leftColumnForm"]/div[11]/div[2]//*[contains(text(), "1")or contains(text(), "次へ")]')
      next_btn.each do |post|
        # 1ページ目に「次へ」ボタンが存在した処理
        if post.attribute('text') == '次へ'
          # 「次へ」ボタンのクリック
          driver.find_element(:xpath, '//*[@id="js-leftColumnForm"]/div[11]/div[2]/p/a').click
          # 2ページ目に移動して表示された物件情報の中から駅情報の要素を取得してinfomationsへ格納する
          infomations_page_2 = driver.find_elements(:xpath, '/html/body/div[5]/div/div[2]/div/div[1]//*[contains(@class, "cassetteitem_detail-text")]')
          # 格納された駅情報を順番に表示する
          infomations_page_2.each do |info|
            puts "東京 #{info.text}"
          end
          # 2ページ目下部に「次へ」ボタンの要素が存在すれば取得してクリックする。もし存在せず現在のページで終わりであれば現在のページの数字を取得する
          next_btn = driver.find_elements(:xpath, '//*[@id="js-leftColumnForm"]/div[11]/div[2]//*[contains(text(), "2")or contains(text(), "次へ")]')
          next_btn.each do |post|
            # 2ページ目に「次へ」ボタンが存在した処理
            if post.attribute('text') == '次へ'
              driver.find_element(:xpath, '//*[@id="js-leftColumnForm"]/div[11]/div[2]/p[2]/a').click
              # 3ページ目に移動して表示された物件情報の中から駅情報の要素を取得してinfomationsへ格納する
              infomations_page_3 = driver.find_elements(:xpath, '/html/body/div[5]/div/div[2]/div/div[1]//*[contains(@class, "cassetteitem_detail-text")]')
              # 格納された駅情報を順番に表示する
              infomations_page_3.each do |info|
                puts "東京 #{info.text}"
              end
              # 3ページ目下部に「次へ」ボタンの要素が存在すれば取得してクリックする。もし存在せず現在のページで終わりであれば現在のページの数字を取得する
              next_btn = driver.find_elements(:xpath, '//*[@id="js-leftColumnForm"]/div[11]/div[2]//*[contains(text(), "3")or contains(text(), "次へ")]')
              next_btn.each do |post|
                # 3ページ目に「次へ」ボタンが存在した処理
                if post.attribute('text') == '次へ'
                  driver.find_element(:xpath, '//*[@id="js-leftColumnForm"]/div[11]/div[2]/p[2]/a').click
                  # 4ページ目に移動して表示された物件情報の中から駅情報の要素を取得してinfomationsへ格納する
                  infomations_page_4 = driver.find_elements(:xpath, '/html/body/div[5]/div/div[2]/div/div[1]//*[contains(@class, "cassetteitem_detail-text")]')
                  # 格納された駅情報を順番に表示する
                  infomations_page_4.each do |info|
                    puts "東京 #{info.text}"
                  end
                  # 4ページ目下部に「次へ」ボタンの要素が存在すれば取得してクリックする。もし存在せず現在のページで終わりであれば現在のページの数字を取得する
                  next_btn = driver.find_elements(:xpath, '//*[@id="js-leftColumnForm"]/div[11]/div[2]//*[contains(text(), "4")or contains(text(), "次へ")]')
                  next_btn.each do |post|
                    # 4ページ目に「次へ」ボタンが存在した処理
                    if post.attribute('text') == '次へ'
                      driver.find_element(:xpath, '//*[@id="js-leftColumnForm"]/div[11]/div[2]/p[2]/a').click
                      # 5ページ目に移動して表示された物件情報の中から駅情報の要素を取得してinfomationsへ格納する
                      infomations_page_5 = driver.find_elements(:xpath, '/html/body/div[5]/div/div[2]/div/div[1]//*[contains(@class, "cassetteitem_detail-text")]')
                      # 格納された駅情報を順番に表示する
                      infomations_page_5.each do |info|
                        puts "東京 #{info.text}"
                      end
                    end
                  end
                end
              end
            end
          end
        # 検索結果が5ページ未満だった場合の処理
        elsif post.attribute('text') == ['1','2','3','4']
          puts "検索結果は以上です"
        end
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
      # 表示された1ページ目の物件情報の中から駅情報の要素を取得してinfomationsへ格納する
      infomations_page_1 = driver.find_elements(:xpath, '/html/body/div[5]/div/div[2]/div/div[1]//*[contains(@class, "cassetteitem_detail-text")]')
      # 格納された駅情報を順番に表示する
      infomations_page_1.each do |info|
        puts "神奈川 #{info.text}"
      end
      # 1ページ目下部に「次へ」ボタンの要素が存在すれば取得してクリックする。もし存在せず現在のページで終わりであれば現在のページの数字を取得する
      next_btn = driver.find_elements(:xpath, '//*[@id="js-leftColumnForm"]/div[11]/div[2]//*[contains(text(), "1")or contains(text(), "次へ")]')
      next_btn.each do |post|
        # 1ページ目に「次へ」ボタンが存在した処理
        if post.attribute('text') == '次へ'
          # 「次へ」ボタンのクリック
          driver.find_element(:xpath, '//*[@id="js-leftColumnForm"]/div[11]/div[2]/p/a').click
          # 2ページ目に移動して表示された物件情報の中から駅情報の要素を取得してinfomationsへ格納する
          infomations_page_2 = driver.find_elements(:xpath, '/html/body/div[5]/div/div[2]/div/div[1]//*[contains(@class, "cassetteitem_detail-text")]')
          # 格納された駅情報を順番に表示する
          infomations_page_2.each do |info|
            puts "神奈川 #{info.text}"
          end
          # 2ページ目下部に「次へ」ボタンの要素が存在すれば取得してクリックする。もし存在せず現在のページで終わりであれば現在のページの数字を取得する
          next_btn = driver.find_elements(:xpath, '//*[@id="js-leftColumnForm"]/div[11]/div[2]//*[contains(text(), "2")or contains(text(), "次へ")]')
          next_btn.each do |post|
            # 2ページ目に「次へ」ボタンが存在した処理
            if post.attribute('text') == '次へ'
              driver.find_element(:xpath, '//*[@id="js-leftColumnForm"]/div[11]/div[2]/p[2]/a').click
              # 3ページ目に移動して表示された物件情報の中から駅情報の要素を取得してinfomationsへ格納する
              infomations_page_3 = driver.find_elements(:xpath, '/html/body/div[5]/div/div[2]/div/div[1]//*[contains(@class, "cassetteitem_detail-text")]')
              # 格納された駅情報を順番に表示する
              infomations_page_3.each do |info|
                puts "神奈川 #{info.text}"
              end
              # 3ページ目下部に「次へ」ボタンの要素が存在すれば取得してクリックする。もし存在せず現在のページで終わりであれば現在のページの数字を取得する
              next_btn = driver.find_elements(:xpath, '//*[@id="js-leftColumnForm"]/div[11]/div[2]//*[contains(text(), "3")or contains(text(), "次へ")]')
              next_btn.each do |post|
                # 3ページ目に「次へ」ボタンが存在した処理
                if post.attribute('text') == '次へ'
                  driver.find_element(:xpath, '//*[@id="js-leftColumnForm"]/div[11]/div[2]/p[2]/a').click
                  # 4ページ目に移動して表示された物件情報の中から駅情報の要素を取得してinfomationsへ格納する
                  infomations_page_4 = driver.find_elements(:xpath, '/html/body/div[5]/div/div[2]/div/div[1]//*[contains(@class, "cassetteitem_detail-text")]')
                  # 格納された駅情報を順番に表示する
                  infomations_page_4.each do |info|
                    puts "神奈川 #{info.text}"
                  end
                  # 4ページ目下部に「次へ」ボタンの要素が存在すれば取得してクリックする。もし存在せず現在のページで終わりであれば現在のページの数字を取得する
                  next_btn = driver.find_elements(:xpath, '//*[@id="js-leftColumnForm"]/div[11]/div[2]//*[contains(text(), "4")or contains(text(), "次へ")]')
                  next_btn.each do |post|
                    # 4ページ目に「次へ」ボタンが存在した処理
                    if post.attribute('text') == '次へ'
                      driver.find_element(:xpath, '//*[@id="js-leftColumnForm"]/div[11]/div[2]/p[2]/a').click
                      # 5ページ目に移動して表示された物件情報の中から駅情報の要素を取得してinfomationsへ格納する
                      infomations_page_5 = driver.find_elements(:xpath, '/html/body/div[5]/div/div[2]/div/div[1]//*[contains(@class, "cassetteitem_detail-text")]')
                      # 格納された駅情報を順番に表示する
                      infomations_page_5.each do |info|
                        puts "神奈川 #{info.text}"
                      end
                    end
                  end
                end
              end
            end
          end
        # 検索結果が5ページ未満だった場合の処理
        elsif post.attribute('text') == ['1','2','3','4']
          puts "検索結果は以上です"
        end
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
      # 表示された1ページ目の物件情報の中から駅情報の要素を取得してinfomationsへ格納する
      infomations_page_1 = driver.find_elements(:xpath, '/html/body/div[5]/div/div[2]/div/div[1]//*[contains(@class, "cassetteitem_detail-text")]')
      # 格納された駅情報を順番に表示する
      infomations_page_1.each do |info|
        puts "埼玉 #{info.text}"
      end
      # 1ページ目下部に「次へ」ボタンの要素が存在すれば取得してクリックする。もし存在せず現在のページで終わりであれば現在のページの数字を取得する
      next_btn = driver.find_elements(:xpath, '//*[@id="js-leftColumnForm"]/div[11]/div[2]//*[contains(text(), "1")or contains(text(), "次へ")]')
      next_btn.each do |post|
        # 1ページ目に「次へ」ボタンが存在した処理
        if post.attribute('text') == '次へ'
          # 「次へ」ボタンのクリック
          driver.find_element(:xpath, '//*[@id="js-leftColumnForm"]/div[11]/div[2]/p/a').click
          # 2ページ目に移動して表示された物件情報の中から駅情報の要素を取得してinfomationsへ格納する
          infomations_page_2 = driver.find_elements(:xpath, '/html/body/div[5]/div/div[2]/div/div[1]//*[contains(@class, "cassetteitem_detail-text")]')
          # 格納された駅情報を順番に表示する
          infomations_page_2.each do |info|
            puts "埼玉 #{info.text}"
          end
          # 2ページ目下部に「次へ」ボタンの要素が存在すれば取得してクリックする。もし存在せず現在のページで終わりであれば現在のページの数字を取得する
          next_btn = driver.find_elements(:xpath, '//*[@id="js-leftColumnForm"]/div[11]/div[2]//*[contains(text(), "2")or contains(text(), "次へ")]')
          next_btn.each do |post|
            # 2ページ目に「次へ」ボタンが存在した処理
            if post.attribute('text') == '次へ'
              driver.find_element(:xpath, '//*[@id="js-leftColumnForm"]/div[11]/div[2]/p[2]/a').click
              # 3ページ目に移動して表示された物件情報の中から駅情報の要素を取得してinfomationsへ格納する
              infomations_page_3 = driver.find_elements(:xpath, '/html/body/div[5]/div/div[2]/div/div[1]//*[contains(@class, "cassetteitem_detail-text")]')
              # 格納された駅情報を順番に表示する
              infomations_page_3.each do |info|
                puts "埼玉 #{info.text}"
              end
              # 3ページ目下部に「次へ」ボタンの要素が存在すれば取得してクリックする。もし存在せず現在のページで終わりであれば現在のページの数字を取得する
              next_btn = driver.find_elements(:xpath, '//*[@id="js-leftColumnForm"]/div[11]/div[2]//*[contains(text(), "3")or contains(text(), "次へ")]')
              next_btn.each do |post|
                # 3ページ目に「次へ」ボタンが存在した処理
                if post.attribute('text') == '次へ'
                  driver.find_element(:xpath, '//*[@id="js-leftColumnForm"]/div[11]/div[2]/p[2]/a').click
                  # 4ページ目に移動して表示された物件情報の中から駅情報の要素を取得してinfomationsへ格納する
                  infomations_page_4 = driver.find_elements(:xpath, '/html/body/div[5]/div/div[2]/div/div[1]//*[contains(@class, "cassetteitem_detail-text")]')
                  # 格納された駅情報を順番に表示する
                  infomations_page_4.each do |info|
                    puts "埼玉 #{info.text}"
                  end
                  # 4ページ目下部に「次へ」ボタンの要素が存在すれば取得してクリックする。もし存在せず現在のページで終わりであれば現在のページの数字を取得する
                  next_btn = driver.find_elements(:xpath, '//*[@id="js-leftColumnForm"]/div[11]/div[2]//*[contains(text(), "4")or contains(text(), "次へ")]')
                  next_btn.each do |post|
                    # 4ページ目に「次へ」ボタンが存在した処理
                    if post.attribute('text') == '次へ'
                      driver.find_element(:xpath, '//*[@id="js-leftColumnForm"]/div[11]/div[2]/p[2]/a').click
                      # 5ページ目に移動して表示された物件情報の中から駅情報の要素を取得してinfomationsへ格納する
                      infomations_page_5 = driver.find_elements(:xpath, '/html/body/div[5]/div/div[2]/div/div[1]//*[contains(@class, "cassetteitem_detail-text")]')
                      # 格納された駅情報を順番に表示する
                      infomations_page_5.each do |info|
                        puts "埼玉 #{info.text}"
                      end
                    end
                  end
                end
              end
            end
          end
        # 検索結果が5ページ未満だった場合の処理
        elsif post.attribute('text') == ['1','2','3','4']
          puts "検索結果は以上です"
        end
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
      # 表示された1ページ目の物件情報の中から駅情報の要素を取得してinfomationsへ格納する
      infomations_page_1 = driver.find_elements(:xpath, '/html/body/div[5]/div/div[2]/div/div[1]//*[contains(@class, "cassetteitem_detail-text")]')
      # 格納された駅情報を順番に表示する
      infomations_page_1.each do |info|
        puts "千葉 #{info.text}"
      end
      # 1ページ目下部に「次へ」ボタンの要素が存在すれば取得してクリックする。もし存在せず現在のページで終わりであれば現在のページの数字を取得する
      next_btn = driver.find_elements(:xpath, '//*[@id="js-leftColumnForm"]/div[11]/div[2]//*[contains(text(), "1")or contains(text(), "次へ")]')
      next_btn.each do |post|
        # 1ページ目に「次へ」ボタンが存在した処理
        if post.attribute('text') == '次へ'
          # 「次へ」ボタンのクリック
          driver.find_element(:xpath, '//*[@id="js-leftColumnForm"]/div[11]/div[2]/p/a').click
          # 2ページ目に移動して表示された物件情報の中から駅情報の要素を取得してinfomationsへ格納する
          infomations_page_2 = driver.find_elements(:xpath, '/html/body/div[5]/div/div[2]/div/div[1]//*[contains(@class, "cassetteitem_detail-text")]')
          # 格納された駅情報を順番に表示する
          infomations_page_2.each do |info|
            puts "千葉 #{info.text}"
          end
          # 2ページ目下部に「次へ」ボタンの要素が存在すれば取得してクリックする。もし存在せず現在のページで終わりであれば現在のページの数字を取得する
          next_btn = driver.find_elements(:xpath, '//*[@id="js-leftColumnForm"]/div[11]/div[2]//*[contains(text(), "2")or contains(text(), "次へ")]')
          next_btn.each do |post|
            # 2ページ目に「次へ」ボタンが存在した処理
            if post.attribute('text') == '次へ'
              driver.find_element(:xpath, '//*[@id="js-leftColumnForm"]/div[11]/div[2]/p[2]/a').click
              # 3ページ目に移動して表示された物件情報の中から駅情報の要素を取得してinfomationsへ格納する
              infomations_page_3 = driver.find_elements(:xpath, '/html/body/div[5]/div/div[2]/div/div[1]//*[contains(@class, "cassetteitem_detail-text")]')
              # 格納された駅情報を順番に表示する
              infomations_page_3.each do |info|
                puts "千葉 #{info.text}"
              end
              # 3ページ目下部に「次へ」ボタンの要素が存在すれば取得してクリックする。もし存在せず現在のページで終わりであれば現在のページの数字を取得する
              next_btn = driver.find_elements(:xpath, '//*[@id="js-leftColumnForm"]/div[11]/div[2]//*[contains(text(), "3")or contains(text(), "次へ")]')
              next_btn.each do |post|
                # 3ページ目に「次へ」ボタンが存在した処理
                if post.attribute('text') == '次へ'
                  driver.find_element(:xpath, '//*[@id="js-leftColumnForm"]/div[11]/div[2]/p[2]/a').click
                  # 4ページ目に移動して表示された物件情報の中から駅情報の要素を取得してinfomationsへ格納する
                  infomations_page_4 = driver.find_elements(:xpath, '/html/body/div[5]/div/div[2]/div/div[1]//*[contains(@class, "cassetteitem_detail-text")]')
                  # 格納された駅情報を順番に表示する
                  infomations_page_4.each do |info|
                    puts "千葉 #{info.text}"
                  end
                  # 4ページ目下部に「次へ」ボタンの要素が存在すれば取得してクリックする。もし存在せず現在のページで終わりであれば現在のページの数字を取得する
                  next_btn = driver.find_elements(:xpath, '//*[@id="js-leftColumnForm"]/div[11]/div[2]//*[contains(text(), "4")or contains(text(), "次へ")]')
                  next_btn.each do |post|
                    # 4ページ目に「次へ」ボタンが存在した処理
                    if post.attribute('text') == '次へ'
                      driver.find_element(:xpath, '//*[@id="js-leftColumnForm"]/div[11]/div[2]/p[2]/a').click
                      # 5ページ目に移動して表示された物件情報の中から駅情報の要素を取得してinfomationsへ格納する
                      infomations_page_5 = driver.find_elements(:xpath, '/html/body/div[5]/div/div[2]/div/div[1]//*[contains(@class, "cassetteitem_detail-text")]')
                      # 格納された駅情報を順番に表示する
                      infomations_page_5.each do |info|
                        puts "千葉 #{info.text}"
                      end
                    end
                  end
                end
              end
            end
          end
        # 検索結果が5ページ未満だった場合の処理
        elsif post.attribute('text') == ['1','2','3','4']
          puts "検索結果は以上です"
        end
      end
    # 該当物件が存在しない場合の処理(classの要素で判定)
    elsif element.attribute('class') == 'error_pop-txt'
      puts "千葉 #{element.text}"
    else
      puts 'ERROR!!'
    end
  end
end
