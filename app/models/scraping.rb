require 'selenium-webdriver'

# xpathの要素取得について "//*" とする事でtbody以降全てのnodeを対象にする
# hrefタグに特定の文字列が含まれる要素の指定 => [contains(@href, "tokyo")]
# コンソールにリンクのテキスト名を表示させる
  #elements.each do |element|
  #  puts element.text
  #end

class Scraping
  def self.click_rent_market_price_tokyo
    driver = Selenium::WebDriver.for :chrome
    driver.get "https://suumo.jp/chintai/soba/tokyo/ensen/"
    # xpathを使用したリンクの取得とクリック動作
    elements = driver.find_elements(:xpath, '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody//*[contains(@href, "tokyo")]')
    urls = elements.map {|element| element.attribute('href')}
    urls.each do |url|
      driver.get(url)
      driver.find_element(:xpath, '//*[@id="souba_madori-oneroom"]').click
      sleep(1)
      # 間取りボタンをクリック後に更新ボタンをクリック
      driver.find_element(:xpath, '//*[@id="js-graphpanel-form"]/div/div[2]/div/div[1]/a').click
      sleep(1)
      driver.find_element(:xpath, '//*[@id="souba_madori-1K/1DK"]').click
      sleep(1)
      # 間取りボタンをクリック後に更新ボタンをクリック
      driver.find_element(:xpath, '//*[@id="js-graphpanel-form"]/div/div[2]/div/div[1]/a').click
      sleep(1)
      driver.find_element(:xpath, '//*[@id="souba_madori-1LDK/2K/2DK"]').click
      sleep(1)
      # 間取りボタンをクリック後に更新ボタンをクリック
      driver.find_element(:xpath, '//*[@id="js-graphpanel-form"]/div/div[2]/div/div[1]/a').click
      sleep(1)
      driver.find_element(:xpath, '//*[@id="souba_madori-2LDK/3K/3DK"]').click
      sleep(1)
      # 間取りボタンをクリック後に更新ボタンをクリック
      driver.find_element(:xpath, '//*[@id="js-graphpanel-form"]/div/div[2]/div/div[1]/a').click
      sleep(1)
      driver.find_element(:xpath, '//*[@id="souba_madori-3LDK/4K"]').click
      sleep(1)
      # 間取りボタンをクリック後に更新ボタンをクリック
      driver.find_element(:xpath, '//*[@id="js-graphpanel-form"]/div/div[2]/div/div[1]/a').click
      sleep(1)
    end
    return 'ok'
  end

  def self.click_rent_market_price_kanagawa
    driver = Selenium::WebDriver.for :chrome
    driver.get "https://suumo.jp/chintai/soba/kanagawa/ensen/"
    # xpathを使用したリンクの取得とクリック動作
    elements = driver.find_elements(:xpath, '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody//*[contains(@href, "kanagawa")]')
    urls = elements.map {|element| element.attribute('href')}
    urls.each do |url|
      driver.get(url)
      driver.find_element(:xpath, '//*[@id="souba_madori-oneroom"]').click
      sleep(1)
      # 間取りボタンをクリック後に更新ボタンをクリック
      driver.find_element(:xpath, '//*[@id="js-graphpanel-form"]/div/div[2]/div/div[1]/a').click
      sleep(1)
      driver.find_element(:xpath, '//*[@id="souba_madori-1K/1DK"]').click
      sleep(1)
      # 間取りボタンをクリック後に更新ボタンをクリック
      driver.find_element(:xpath, '//*[@id="js-graphpanel-form"]/div/div[2]/div/div[1]/a').click
      sleep(1)
      driver.find_element(:xpath, '//*[@id="souba_madori-1LDK/2K/2DK"]').click
      sleep(1)
      # 間取りボタンをクリック後に更新ボタンをクリック
      driver.find_element(:xpath, '//*[@id="js-graphpanel-form"]/div/div[2]/div/div[1]/a').click
      sleep(1)
      driver.find_element(:xpath, '//*[@id="souba_madori-2LDK/3K/3DK"]').click
      sleep(1)
      # 間取りボタンをクリック後に更新ボタンをクリック
      driver.find_element(:xpath, '//*[@id="js-graphpanel-form"]/div/div[2]/div/div[1]/a').click
      sleep(1)
      driver.find_element(:xpath, '//*[@id="souba_madori-3LDK/4K"]').click
      sleep(1)
      # 間取りボタンをクリック後に更新ボタンをクリック
      driver.find_element(:xpath, '//*[@id="js-graphpanel-form"]/div/div[2]/div/div[1]/a').click
      sleep(1)
    end
    return 'ok'
  end

  def self.click_rent_market_price_saitama
    driver = Selenium::WebDriver.for :chrome
    driver.get "https://suumo.jp/chintai/soba/saitama/ensen/"
    # xpathを使用したリンクの取得とクリック動作
    elements = driver.find_elements(:xpath, '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody//*[contains(@href, "saitama")]')
    urls = elements.map {|element| element.attribute('href')}
    urls.each do |url|
      driver.get(url)
      driver.find_element(:xpath, '//*[@id="souba_madori-oneroom"]').click
      sleep(1)
      # 間取りボタンをクリック後に更新ボタンをクリック
      driver.find_element(:xpath, '//*[@id="js-graphpanel-form"]/div/div[2]/div/div[1]/a').click
      sleep(1)
      driver.find_element(:xpath, '//*[@id="souba_madori-1K/1DK"]').click
      sleep(1)
      # 間取りボタンをクリック後に更新ボタンをクリック
      driver.find_element(:xpath, '//*[@id="js-graphpanel-form"]/div/div[2]/div/div[1]/a').click
      sleep(1)
      driver.find_element(:xpath, '//*[@id="souba_madori-1LDK/2K/2DK"]').click
      sleep(1)
      # 間取りボタンをクリック後に更新ボタンをクリック
      driver.find_element(:xpath, '//*[@id="js-graphpanel-form"]/div/div[2]/div/div[1]/a').click
      sleep(1)
      driver.find_element(:xpath, '//*[@id="souba_madori-2LDK/3K/3DK"]').click
      sleep(1)
      # 間取りボタンをクリック後に更新ボタンをクリック
      driver.find_element(:xpath, '//*[@id="js-graphpanel-form"]/div/div[2]/div/div[1]/a').click
      sleep(1)
      driver.find_element(:xpath, '//*[@id="souba_madori-3LDK/4K"]').click
      sleep(1)
      # 間取りボタンをクリック後に更新ボタンをクリック
      driver.find_element(:xpath, '//*[@id="js-graphpanel-form"]/div/div[2]/div/div[1]/a').click
      sleep(1)
    end
    return 'ok'
  end

  def self.click_rent_market_price_chiba
    driver = Selenium::WebDriver.for :chrome
    driver.get "https://suumo.jp/chintai/soba/chiba/ensen/"
    # xpathを使用したリンクの取得とクリック動作
    elements = driver.find_elements(:xpath, '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody//*[contains(@href, "chiba")]')
    urls = elements.map {|element| element.attribute('href')}
    urls.each do |url|
      driver.get(url)
      driver.find_element(:xpath, '//*[@id="souba_madori-oneroom"]').click
      sleep(1)
      # 間取りボタンをクリック後に更新ボタンをクリック
      driver.find_element(:xpath, '//*[@id="js-graphpanel-form"]/div/div[2]/div/div[1]/a').click
      sleep(1)
      driver.find_element(:xpath, '//*[@id="souba_madori-1K/1DK"]').click
      sleep(1)
      # 間取りボタンをクリック後に更新ボタンをクリック
      driver.find_element(:xpath, '//*[@id="js-graphpanel-form"]/div/div[2]/div/div[1]/a').click
      sleep(1)
      driver.find_element(:xpath, '//*[@id="souba_madori-1LDK/2K/2DK"]').click
      sleep(1)
      # 間取りボタンをクリック後に更新ボタンをクリック
      driver.find_element(:xpath, '//*[@id="js-graphpanel-form"]/div/div[2]/div/div[1]/a').click
      sleep(1)
      driver.find_element(:xpath, '//*[@id="souba_madori-2LDK/3K/3DK"]').click
      sleep(1)
      # 間取りボタンをクリック後に更新ボタンをクリック
      driver.find_element(:xpath, '//*[@id="js-graphpanel-form"]/div/div[2]/div/div[1]/a').click
      sleep(1)
      driver.find_element(:xpath, '//*[@id="souba_madori-3LDK/4K"]').click
      sleep(1)
      # 間取りボタンをクリック後に更新ボタンをクリック
      driver.find_element(:xpath, '//*[@id="js-graphpanel-form"]/div/div[2]/div/div[1]/a').click
      sleep(1)
    end
    return 'ok'
  end
end
