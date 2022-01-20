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
        # 間取りごとにラジオボタンの要素を取得してクリック
        driver.find_element(:xpath, '//*[@id="souba_madori-oneroom"]').click
        sleep(1)
        # 間取りボタンをクリック後に更新ボタンをクリック
        submit_btn = '//*[@id="js-graphpanel-form"]/div/div[2]/div/div[1]/a'
        driver.find_element(:xpath, submit_btn).click
        sleep(1)
        driver.find_element(:xpath, '//*[@id="souba_madori-1K/1DK"]').click
        sleep(1)
        driver.find_element(:xpath, submit_btn).click
        sleep(1)
        driver.find_element(:xpath, '//*[@id="souba_madori-1LDK/2K/2DK"]').click
        sleep(1)
        driver.find_element(:xpath, submit_btn).click
        sleep(1)
        driver.find_element(:xpath, '//*[@id="souba_madori-2LDK/3K/3DK"]').click
        sleep(1)
        driver.find_element(:xpath, submit_btn).click
        sleep(1)
        driver.find_element(:xpath, '//*[@id="souba_madori-3LDK/4K"]').click
        sleep(1)
        driver.find_element(:xpath, submit_btn).click
        sleep(1)
      end
    end
  end
end
