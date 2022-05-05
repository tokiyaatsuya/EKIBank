class RentMarketPrice < ApplicationRecord
  validates :station_name, uniqueness: { scope: :floor_plan }
  enum floor_plan: { "ワンルーム": 0, "1K/1DK": 1, "1LDK/2K/2DK": 2, "2LDK/3K/3DK": 3, "3LDK/4K~": 4 }
  require 'selenium-webdriver'
  require 'webdrivers'
  # require 'twitter'
  attr_reader :destination_1, :destination_2, :transit_time_1, :transit_time_2

  # 変数の定義
  # 各一都三県が保有する沿線一覧のリンク先
  @tokyo_rail_line_list = "https://suumo.jp/chintai/soba/tokyo/ensen/"
  @kanagawa_rail_line_list = "https://suumo.jp/chintai/soba/kanagawa/ensen/"
  @chiba_rail_line_list = "https://suumo.jp/chintai/soba/chiba/ensen/"
  @saitama_rail_line_list = "https://suumo.jp/chintai/soba/saitama/ensen/"
  # xpathで要素(href)を指定する各沿線の一覧
  # 東京都
  @yamanotesen_tokyo = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[1]/td/div/ul[1]/li[1]/a'
  @keihintohokusen_tokyo = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[1]/td/div/ul[1]/li[2]/a'
  @tokaidohonsen_tokyo = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[1]/td/div/ul[1]/li[3]/a'
  @jobansen_tokyo = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[1]/td/div/ul[2]/li[1]/a'
  @nambusen_tokyo = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[1]/td/div/ul[2]/li[2]/a'
  @yokohamasen_tokyo = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[1]/td/div/ul[2]/li[3]/a'
  @yokosukasen_tokyo = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[1]/td/div/ul[3]/li[1]/a'
  @chuosen_tokyo = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[1]/td/div/ul[3]/li[2]/a'
  @omesen_tokyo = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[1]/td/div/ul[3]/li[3]/a'
  @itsukaichisen_tokyo = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[1]/td/div/ul[4]/li[1]/a'
  @musashinosen_tokyo = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[1]/td/div/ul[4]/li[2]/a'
  @hachikosen_tokyo = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[1]/td/div/ul[4]/li[3]/a'
  @saikyosen_tokyo = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[1]/td/div/ul[5]/li[1]/a'
  @takasakisen_tokyo = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[1]/td/div/ul[5]/li[2]/a'
  @utsunomiyasen_tokyo = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[1]/td/div/ul[5]/li[3]/a'
  @sobusen_tokyo = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[1]/td/div/ul[6]/li[1]/a'
  @sobukaisokusen_tokyo = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[1]/td/div/ul[6]/li[2]/a'
  @keiyosen_tokyo = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[1]/td/div/ul[6]/li[3]/a'
  @shonanshinjukulineutsunomiyayokosukasen_tokyo = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[1]/td/div/ul[7]/li[1]/a'
  @shonanshinjukulinetakasakitokaidosen_tokyo = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[1]/td/div/ul[7]/li[2]/a'
  @ginzasen_tokyo = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[2]/td/div/ul[1]/li[1]/a'
  @marunouchisen_tokyo = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[2]/td/div/ul[1]/li[2]/a'
  @hibiyasen_tokyo = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[2]/td/div/ul[1]/li[3]/a'
  @tozaisen_tokyo = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[2]/td/div/ul[2]/li[1]/a'
  @chiyodasen_tokyo = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[2]/td/div/ul[2]/li[2]/a'
  @yurakuchosen_tokyo = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[2]/td/div/ul[2]/li[3]/a'
  @hanzomonsen_tokyo = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[2]/td/div/ul[3]/li[1]/a'
  @nambokusen_tokyo = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[2]/td/div/ul[3]/li[2]/a'
  @fukutoshinsen_tokyo = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[2]/td/div/ul[3]/li[3]/a'
  @seibuyurakuchosen_tokyo = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[3]/td/div/ul[1]/li[1]/a'
  @seibushinjukusen_tokyo = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[3]/td/div/ul[1]/li[2]/a'
  @seibuikebukurosen_tokyo = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[3]/td/div/ul[1]/li[3]/a'
  @seibuhaijimasen_tokyo = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[3]/td/div/ul[2]/li[1]/a'
  @seibuyamaguchisen_tokyo = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[3]/td/div/ul[2]/li[2]/a'
  @seibukokubunjisen_tokyo = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[3]/td/div/ul[2]/li[3]/a'
  @seibutamagawasen_tokyo = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[3]/td/div/ul[3]/li[1]/a'
  @seibutamakosen_tokyo = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[3]/td/div/ul[3]/li[2]/a'
  @seibuseibuensen_tokyo = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[3]/td/div/ul[3]/li[3]/a'
  @seibutoshimasen_tokyo = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[3]/td/div/ul[4]/li/a'
  @tobutojosen_tokyo = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[4]/td/div/ul[1]/li[1]/a'
  @tobuisesakisen_tokyo = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[4]/td/div/ul[1]/li[2]/a'
  @tobukameidosen_tokyo = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[4]/td/div/ul[1]/li[3]/a'
  @tobudaishisen_tokyo = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[4]/td/div/ul[2]/li/a'
  @tokyutoyokosen_tokyo = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[5]/td/div/ul[1]/li[1]/a'
  @tokyudenentoshisen_tokyo = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[5]/td/div/ul[1]/li[2]/a'
  @tokyuikegamisen_tokyo = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[5]/td/div/ul[1]/li[3]/a'
  @tokyumegurosen_tokyo = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[5]/td/div/ul[2]/li[1]/a'
  @tokyutamagawasen_tokyo = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[5]/td/div/ul[2]/li[2]/a'
  @tokyuoimachisen_tokyo = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[5]/td/div/ul[2]/li[3]/a'
  @tokyusetagayasen_tokyo = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[5]/td/div/ul[3]/li/a'
  @toeiasakusasen_tokyo = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[6]/td/div/ul[1]/li[1]/a'
  @toeimitasen_tokyo = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[6]/td/div/ul[1]/li[2]/a'
  @toeishinjukusen_tokyo = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[6]/td/div/ul[1]/li[3]/a'
  @toeioedosen_tokyo = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[6]/td/div/ul[2]/li[1]/a'
  @todenarakawasen_tokyo = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[6]/td/div/ul[2]/li[2]/a'
  @nipporitoneriliner_tokyo = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[6]/td/div/ul[2]/li[3]/a'
  @keioinokashirasen_tokyo = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[7]/td/div/ul[1]/li[1]/a'
  @keiokeibajosen_tokyo = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[7]/td/div/ul[1]/li[2]/a'
  @keioshinsen_tokyo = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[7]/td/div/ul[1]/li[3]/a'
  @keiosen_tokyo = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[7]/td/div/ul[2]/li[1]/a'
  @keiodobutsuensen_tokyo = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[7]/td/div/ul[2]/li[2]/a'
  @keiosagamiharasen_tokyo = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[7]/td/div/ul[2]/li[3]/a'
  @keiotakaosen_tokyo = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[7]/td/div/ul[3]/li/a'
  @keiseioshiagesen_tokyo = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[8]/td/div/ul/li[1]/a'
  @keiseikanamachisen_tokyo = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[8]/td/div/ul/li[2]/a'
  @keiseihonsen_tokyo = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[8]/td/div/ul/li[3]/a'
  @keikyuhonsen_tokyo = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[9]/td/div/ul/li[1]/a'
  @keikyukukosen_tokyo = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[9]/td/div/ul/li[2]/a'
  @odakyusen_tokyo = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[10]/td/div/ul/li[1]/a'
  @odakyutamasen_tokyo = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[10]/td/div/ul/li[2]/a'
  @tamatoshimonorail_tokyo = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[11]/td/div/ul/li/a'
  @rinkaisen_tokyo = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[12]/td/div/ul/li/a'
  @hokusosen_tokyo = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[13]/td/div/ul/li/a'
  @tokyomonorail_tokyo = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[14]/td/div/ul/li/a'
  @shinkotsuyurikamome_tokyo = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[15]/td/div/ul/li/a'
  @saitamakosokutetsudo_tokyo = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[16]/td/div/ul/li/a'
  @tsukubaexpress_tokyo = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[17]/td/div/ul/li/a'
  @naritaskyaccess_tokyo = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[18]/td/div/ul/li/a'
  # 神奈川県
  @tokyuoimachisen_kanagawa = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[1]/td/div/ul[1]/li[1]/a'
  @tokyutoyokosen_kanagawa = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[1]/td/div/ul[1]/li[2]/a'
  @tokyudenentoshisen_kanagawa = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[1]/td/div/ul[1]/li[3]/a'
  @tokyukodomonokunisen_kanagawa = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[1]/td/div/ul[2]/li[1]/a'
  @tokyumegurosen_kanagawa = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[1]/td/div/ul[2]/li[2]/a'
  @yokosukasen_kanagawa = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[2]/td/div/ul[1]/li[1]/a'
  @keihintohokusen_kanagawa = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[2]/td/div/ul[1]/li[2]/a'
  @negishisen_kanagawa = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[2]/td/div/ul[1]/li[3]/a'
  @tsurumisen_kanagawa = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[2]/td/div/ul[2]/li[1]/a'
  @tokaidohonsen_kanagawa = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[2]/td/div/ul[2]/li[2]/a'
  @gotembasen_kanagawa = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[2]/td/div/ul[2]/li[3]/a'
  @nambusen_kanagawa = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[2]/td/div/ul[3]/li[1]/a'
  @yokohamasen_kanagawa = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[2]/td/div/ul[3]/li[2]/a'
  @sagamisen_kanagawa = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[2]/td/div/ul[3]/li[3]/a'
  @chuosen_kanagawa = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[2]/td/div/ul[4]/li[1]/a'
  @shonanshinjukulineutsunomiyayokosukasen_kanagawa = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[2]/td/div/ul[4]/li[2]/a'
  @shonanshinjukulinetakasakitokaidosen_kanagawa = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[2]/td/div/ul[4]/li[3]/a'
  @keiosagamiharasen_kanagawa = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[3]/td/div/ul/li/a'
  @keikyuhonsen_kanagawa = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[4]/td/div/ul[1]/li[1]/a'
  @keikyudaishisen_kanagawa = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[4]/td/div/ul[1]/li[2]/a'
  @keikyuzushisen_kanagawa = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[4]/td/div/ul[1]/li[3]/a'
  @keikyukurihamasen_kanagawa = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[4]/td/div/ul[2]/li/a'
  @odakyusen_kanagawa = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[5]/td/div/ul[1]/li[1]/a'
  @odakyuodawarasen_kanagawa = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[5]/td/div/ul[1]/li[2]/a'
  @odakyutamasen_kanagawa = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[5]/td/div/ul[1]/li[3]/a'
  @odakyuenoshimasen_kanagawa = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[5]/td/div/ul[2]/li/a'
  @sotetsuhonsen_kanagawa = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[6]/td/div/ul/li[1]/a'
  @sotetsuizuminosen_kanagawa = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[6]/td/div/ul/li[2]/a'
  @sotetsushinyokohamasen_kanagawa = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[6]/td/div/ul/li[3]/a'
  @blueline_kanagawa = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[7]/td/div/ul/li[1]/a'
  @greenline_kanagawa = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[7]/td/div/ul/li[2]/a'
  @minatomiraisen_kanagawa = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[8]/td/div/ul/li/a'
  @seasideline_kanagawa = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[9]/td/div/ul/li/a'
  @enoshimadentetsu_kanagawa = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[10]/td/div/ul/li/a'
  @shonanmonorail_kanagawa = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[11]/td/div/ul/li/a'
  @hakonetozantetsudo_kanagawa = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[12]/td/div/ul/li[1]/a'
  @hakonetozancablesen_kanagawa = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[12]/td/div/ul/li[2]/a'
  @izuhakonedaiyuzansen_kanagawa = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[13]/td/div/ul/li/a'
  # 千葉県
  @sobusen_chiba = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[1]/td/div/ul[1]/li[1]/a'
  @jobansen_chiba = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[1]/td/div/ul[1]/li[2]/a'
  @naritasen_chiba = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[1]/td/div/ul[1]/li[3]/a'
  @musashinosen_chiba = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[1]/td/div/ul[2]/li[1]/a'
  @sobukaisokusen_chiba = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[1]/td/div/ul[2]/li[2]/a'
  @sobuhonsen_chiba = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[1]/td/div/ul[2]/li[3]/a'
  @keiyosen_chiba = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[1]/td/div/ul[3]/li[1]/a'
  @kashimasen_chiba = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[1]/td/div/ul[3]/li[2]/a'
  @sotobosen_chiba = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[1]/td/div/ul[3]/li[3]/a'
  @toganesen_chiba = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[1]/td/div/ul[4]/li[1]/a'
  @uchibosen_chiba = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[1]/td/div/ul[4]/li[2]/a'
  @kururisen_chiba = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[1]/td/div/ul[4]/li[3]/a'
  @tozaisen_chiba = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[2]/td/div/ul/li/a'
  @toeishinjukusen_chiba = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[3]/td/div/ul/li/a'
  @keiseihonsen_chiba = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[4]/td/div/ul/li[1]/a'
  @keiseichibasen_chiba = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[4]/td/div/ul/li[2]/a'
  @keiseichiharasen_chiba = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[4]/td/div/ul/li[3]/a'
  @shinkeiseisen_chiba = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[5]/td/div/ul/li/a'
  @tobunodasen_chiba = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[6]/td/div/ul/li/a'
  @hokusosen_chiba = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[7]/td/div/ul/li/a'
  @tsukubaexpress_chiba = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[8]/td/div/ul/li/a'
  @chibatoshimonorail_chiba = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[9]/td/div/ul/li/a'
  @ryutetsunagareyamasen_chiba = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[10]/td/div/ul/li/a'
  @toyokosokutetsudo_chiba = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[11]/td/div/ul/li/a'
  @yukarigaokasen_chiba = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[12]/td/div/ul/li/a'
  @kominatotetsudosen_chiba = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[13]/td/div/ul/li/a'
  @choshidentetsu_chiba = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[15]/td/div/ul/li/a'
  @shibayamatetsudosen_chiba = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[16]/td/div/ul/li/a'
  @naritaskyaccess_chiba = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[17]/td/div/ul/li/a'
  # 埼玉県
  @keihintohokusen_saitama = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[1]/td/div/ul[1]/li[1]/a'
  @saikyosen_saitama = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[1]/td/div/ul[1]/li[2]/a'
  @kawagoesen_saitama = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[1]/td/div/ul[1]/li[3]/a'
  @takasakisen_saitama = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[1]/td/div/ul[2]/li[1]/a'
  @utsunomiyasen_saitama = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[1]/td/div/ul[2]/li[2]/a'
  @musashinosen_saitama = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[1]/td/div/ul[2]/li[3]/a'
  @hachikosen_saitama = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[1]/td/div/ul[3]/li[1]/a'
  @shonanshinjukulineutsunomiyayokosukasen_saitama = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[1]/td/div/ul[3]/li[2]/a'
  @shonanshinjukulinetakasakitokaidosen_saitama = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[1]/td/div/ul[3]/li[3]/a'
  @yurakuchosen_saitama = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[2]/td/div/ul/li[1]/a'
  @fukutoshinsen_saitama = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[2]/td/div/ul/li[2]/a'
  @seibushinjukusen_saitama = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[3]/td/div/ul[1]/li[1]/a'
  @seibuikebukurosen_saitama = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[3]/td/div/ul[1]/li[2]/a'
  @seibusayamasen_saitama = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[3]/td/div/ul[1]/li[3]/a'
  @seibuyamaguchisen_saitama = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[3]/td/div/ul[2]/li[1]/a'
  @seibuchichibusen_saitama = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[3]/td/div/ul[2]/li[2]/a'
  @tobutojosen_saitama = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[4]/td/div/ul[1]/li[1]/a'
  @tobuogosesen_saitama = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[4]/td/div/ul[1]/li[2]/a'
  @tobuisesakisen_saitama = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[4]/td/div/ul[1]/li[3]/a'
  @tobunikkosen_saitama = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[4]/td/div/ul[2]/li[1]/a'
  @tobunodasen_saitama = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[4]/td/div/ul[2]/li[2]/a'
  @saitamakosokutetsudo_saitama = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[5]/td/div/ul/li/a'
  @tsukubaexpress_saitama = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[6]/td/div/ul/li/a'
  @saitamashintoshikotsuinasen_saitama = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[7]/td/div/ul/li/a'
  @chichibutetsudo_saitama = '/html/body/div[4]/div/div[2]/div/div/div/div[2]/table/tbody/tr[8]/td/div/ul/li/a'
  # xpathで要素を指定する『駅名』と『金額』の要素
  @station_name_and_market_price = '//*[@id="js-graphpanel-campus"]/table/tbody//*[contains(@href, "soba")or contains(@class, "graphpanel_matrix-td_graphinfo-strong")]'
  # xpathで要素を指定する『間取り』ボタン
  @floorplan_oneroom_btn = '//*[@id="souba_madori-oneroom"]'
  @floorplan_1k_1dk_btn = '//*[@id="souba_madori-1K/1DK"]'
  @floorplan_1ldk_2k_2dk_btn = '//*[@id="souba_madori-1LDK/2K/2DK"]'
  @floorplan_2ldk_3k_3dk_btn = '//*[@id="souba_madori-2LDK/3K/3DK"]'
  @floorplan_3ldk_4k_btn = '//*[@id="souba_madori-3LDK/4K"]'
  # xpathで要素を指定する間取りの更新ボタン
  @submit_btn = '//*[@id="js-graphpanel-form"]/div/div[2]/div/div[1]/a'

  # 各沿線ごとの駅情報を取得しDBへ保存するメソッド(合計：170路線)
  # 東京都
  def self.yamanotesen_tokyo #山手線
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @tokyo_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @yamanotesen_tokyo
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.keihintohokusen_tokyo #京浜東北線
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @tokyo_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @keihintohokusen_tokyo
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.tokaidohonsen_tokyo #東海道本線
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @tokyo_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @tokaidohonsen_tokyo
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.jobansen_tokyo #常磐線
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @tokyo_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @jobansen_tokyo
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.nambusen_tokyo #南武線
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @tokyo_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @nambusen_tokyo
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.yokohamasen_tokyo #横浜線
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @tokyo_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @yokohamasen_tokyo
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.yokosukasen_tokyo #横須賀線
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @tokyo_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @yokosukasen_tokyo
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.chuosen_tokyo #中央線
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @tokyo_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @chuosen_tokyo
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.omesen_tokyo #青梅線
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @tokyo_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @omesen_tokyo
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.itsukaichisen_tokyo #五日市線
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @tokyo_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @itsukaichisen_tokyo
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.musashinosen_tokyo #武蔵野線
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @tokyo_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @musashinosen_tokyo
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.hachikosen_tokyo #八高線
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @tokyo_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @hachikosen_tokyo
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.saikyosen_tokyo #埼京線
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @tokyo_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @saikyosen_tokyo
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.takasakisen_tokyo #高崎線
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @tokyo_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @takasakisen_tokyo
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.utsunomiyasen_tokyo #宇都宮線
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @tokyo_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @utsunomiyasen_tokyo
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.sobusen_tokyo #総武線
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @tokyo_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @sobusen_tokyo
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.sobukaisokusen_tokyo #総武快速線
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @tokyo_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @sobukaisokusen_tokyo
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.keiyosen_tokyo #京葉線
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @tokyo_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @keiyosen_tokyo
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.shonanshinjukulineutsunomiyayokosukasen_tokyo #湘南新宿ライン宇都宮横須賀線
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @tokyo_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @shonanshinjukulineutsunomiyayokosukasen_tokyo
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.shonanshinjukulinetakasakitokaidosen_tokyo #湘南新宿ライン高崎東海道線
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @tokyo_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @shonanshinjukulinetakasakitokaidosen_tokyo
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.ginzasen_tokyo #銀座線
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @tokyo_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @ginzasen_tokyo
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.marunouchisen_tokyo #丸ノ内線
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @tokyo_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @marunouchisen_tokyo
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.hibiyasen_tokyo #日比谷線
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @tokyo_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @hibiyasen_tokyo
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.tozaisen_tokyo #東西線
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @tokyo_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @tozaisen_tokyo
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.chiyodasen_tokyo #千代田線
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @tokyo_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @chiyodasen_tokyo
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.yurakuchosen_tokyo #有楽町線
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @tokyo_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @yurakuchosen_tokyo
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.hanzomonsen_tokyo #半蔵門線
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @tokyo_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @hanzomonsen_tokyo
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.nambokusen_tokyo #南北線
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @tokyo_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @nambokusen_tokyo
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.fukutoshinsen_tokyo #副都心線
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @tokyo_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @fukutoshinsen_tokyo
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.seibuyurakuchosen_tokyo #西武有楽町線
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @tokyo_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @seibuyurakuchosen_tokyo
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.seibushinjukusen_tokyo #西武新宿線
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @tokyo_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @seibushinjukusen_tokyo
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.seibuikebukurosen_tokyo #西武池袋線
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @tokyo_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @seibuikebukurosen_tokyo
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.seibuhaijimasen_tokyo #西武拝島線
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @tokyo_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @seibuhaijimasen_tokyo
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.seibuyamaguchisen_tokyo #西武山口線
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @tokyo_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @seibuyamaguchisen_tokyo
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.seibukokubunjisen_tokyo #西武国分寺線
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @tokyo_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @seibukokubunjisen_tokyo
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.seibutamagawasen_tokyo #西武多摩川線
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @tokyo_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @seibutamagawasen_tokyo
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.seibutamakosen_tokyo #西武多摩湖線
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @tokyo_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @seibutamakosen_tokyo
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.seibuseibuensen_tokyo #西武西武園線
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @tokyo_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @seibuseibuensen_tokyo
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.seibutoshimasen_tokyo #西武豊島線
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @tokyo_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @seibutoshimasen_tokyo
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.tobutojosen_tokyo #東武東上線
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @tokyo_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @tobutojosen_tokyo
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.tobuisesakisen_tokyo #東武伊勢崎線
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @tokyo_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @tobuisesakisen_tokyo
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.tobukameidosen_tokyo #東武亀戸線
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @tokyo_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @tobukameidosen_tokyo
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.tobudaishisen_tokyo #東武大師線
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @tokyo_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @tobudaishisen_tokyo
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.tokyutoyokosen_tokyo #東急東横線
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @tokyo_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @tokyutoyokosen_tokyo
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.tokyudenentoshisen_tokyo #東急田園都市線
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @tokyo_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @tokyudenentoshisen_tokyo
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.tokyuikegamisen_tokyo #東急池上線
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @tokyo_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @tokyuikegamisen_tokyo
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.tokyumegurosen_tokyo #東急目黒線
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @tokyo_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @tokyumegurosen_tokyo
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.tokyutamagawasen_tokyo #東急多摩川線
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @tokyo_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @tokyutamagawasen_tokyo
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.tokyuoimachisen_tokyo #東急大井町線
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @tokyo_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @tokyuoimachisen_tokyo
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.tokyusetagayasen_tokyo #東急世田谷線
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @tokyo_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @tokyusetagayasen_tokyo
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.toeiasakusasen_tokyo #都営浅草線
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @tokyo_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @toeiasakusasen_tokyo
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.toeimitasen_tokyo #都営三田線
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @tokyo_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @toeimitasen_tokyo
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.toeishinjukusen_tokyo #都営新宿線
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @tokyo_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @toeishinjukusen_tokyo
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.toeioedosen_tokyo #都営大江戸線
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @tokyo_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @toeioedosen_tokyo
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.todenarakawasen_tokyo #都電荒川線
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @tokyo_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @todenarakawasen_tokyo
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.nipporitoneriliner_tokyo #日暮里舎人ライナー
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @tokyo_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @nipporitoneriliner_tokyo
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.keioinokashirasen_tokyo #京王井の頭線
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @tokyo_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @keioinokashirasen_tokyo
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.keiokeibajosen_tokyo #京王競馬場線
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @tokyo_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @keiokeibajosen_tokyo
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.keioshinsen_tokyo #京王新線
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @tokyo_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @keioshinsen_tokyo
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.keiosen_tokyo #京王線
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @tokyo_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @keiosen_tokyo
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.keiodobutsuensen_tokyo #京王動物園線
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @tokyo_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @keiodobutsuensen_tokyo
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.keiosagamiharasen_tokyo #京王相模原線
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @tokyo_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @keiosagamiharasen_tokyo
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.keiotakaosen_tokyo #京王高尾線
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @tokyo_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @keiotakaosen_tokyo
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.keiseioshiagesen_tokyo #京成押上線
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @tokyo_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @keiseioshiagesen_tokyo
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.keiseikanamachisen_tokyo #京成金町線
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @tokyo_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @keiseikanamachisen_tokyo
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.keiseihonsen_tokyo #京成本線
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @tokyo_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @keiseihonsen_tokyo
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.keikyuhonsen_tokyo #京急本線
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @tokyo_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @keikyuhonsen_tokyo
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.keikyukukosen_tokyo #京急空港線
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @tokyo_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @keikyukukosen_tokyo
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.odakyusen_tokyo #小田急線
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @tokyo_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @odakyusen_tokyo
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.odakyutamasen_tokyo #小田急多摩線
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @tokyo_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @odakyutamasen_tokyo
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.tamatoshimonorail_tokyo #多摩都市モノレール
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @tokyo_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @tamatoshimonorail_tokyo
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.rinkaisen_tokyo #りんかい線
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @tokyo_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @rinkaisen_tokyo
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.hokusosen_tokyo #北総線
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @tokyo_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @hokusosen_tokyo
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.tokyomonorail_tokyo #東京モノレール
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @tokyo_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @tokyomonorail_tokyo
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.shinkotsuyurikamome_tokyo #ゆりかもめ
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @tokyo_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @shinkotsuyurikamome_tokyo
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.saitamakosokutetsudo_tokyo #埼玉高速鉄道
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @tokyo_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @saitamakosokutetsudo_tokyo
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.tsukubaexpress_tokyo #つくばエクスプレス
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @tokyo_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @tsukubaexpress_tokyo
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.naritaskyaccess_tokyo #成田スカイアクセス
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @tokyo_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @naritaskyaccess_tokyo
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  # 神奈川県
  def self.tokyuoimachisen_kanagawa #東急大井町線
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @kanagawa_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @tokyuoimachisen_kanagawa
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.tokyutoyokosen_kanagawa #東急東横線
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @kanagawa_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @tokyutoyokosen_kanagawa
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.tokyudenentoshisen_kanagawa #東急田園都市線
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @kanagawa_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @tokyudenentoshisen_kanagawa
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.tokyukodomonokunisen_kanagawa #東急こどもの国線
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @kanagawa_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @tokyukodomonokunisen_kanagawa
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.tokyumegurosen_kanagawa #東急目黒線
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @kanagawa_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @tokyumegurosen_kanagawa
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.yokosukasen_kanagawa #横須賀線
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @kanagawa_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @yokosukasen_kanagawa
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.keihintohokusen_kanagawa #京浜東北線
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @kanagawa_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @keihintohokusen_kanagawa
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.negishisen_kanagawa #根岸線
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @kanagawa_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @negishisen_kanagawa
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.tsurumisen_kanagawa #鶴見線
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @kanagawa_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @tsurumisen_kanagawa
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.tokaidohonsen_kanagawa #東海道本線
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @kanagawa_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @tokaidohonsen_kanagawa
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.gotembasen_kanagawa #御殿場線
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @kanagawa_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @gotembasen_kanagawa
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.nambusen_kanagawa #南武線
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @kanagawa_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @nambusen_kanagawa
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.yokohamasen_kanagawa #横浜線
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @kanagawa_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @yokohamasen_kanagawa
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.sagamisen_kanagawa #相模線
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @kanagawa_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @sagamisen_kanagawa
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.chuosen_kanagawa #中央線
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @kanagawa_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @chuosen_kanagawa
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.shonanshinjukulineutsunomiyayokosukasen_kanagawa #湘南新宿ライン宇都宮横須賀線
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @kanagawa_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @shonanshinjukulineutsunomiyayokosukasen_kanagawa
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.shonanshinjukulinetakasakitokaidosen_kanagawa #湘南新宿ライン高崎東海道線
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @kanagawa_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @shonanshinjukulinetakasakitokaidosen_kanagawa
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.keiosagamiharasen_kanagawa #京王相模原線
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @kanagawa_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @keiosagamiharasen_kanagawa
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.keikyuhonsen_kanagawa #京急本線
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @kanagawa_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @keikyuhonsen_kanagawa
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.keikyudaishisen_kanagawa #京急大師線
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @kanagawa_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @keikyudaishisen_kanagawa
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.keikyuzushisen_kanagawa #京急逗子線
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @kanagawa_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @keikyuzushisen_kanagawa
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.keikyukurihamasen_kanagawa #京急久里浜線
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @kanagawa_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @keikyukurihamasen_kanagawa
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.odakyusen_kanagawa #小田急線
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @kanagawa_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @odakyusen_kanagawa
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.odakyuodawarasen_kanagawa #小田急小田原線
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @kanagawa_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @odakyuodawarasen_kanagawa
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.odakyutamasen_kanagawa #小田急多摩線
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @kanagawa_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @odakyutamasen_kanagawa
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.odakyuenoshimasen_kanagawa #小田急江ノ島線
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @kanagawa_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @odakyuenoshimasen_kanagawa
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.sotetsuhonsen_kanagawa #相鉄本線
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @kanagawa_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @sotetsuhonsen_kanagawa
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.sotetsuizuminosen_kanagawa #相鉄いずみ野線
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @kanagawa_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @sotetsuizuminosen_kanagawa
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.sotetsushinyokohamasen_kanagawa #相鉄新横浜線
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @kanagawa_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @sotetsushinyokohamasen_kanagawa
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.blueline_kanagawa #ブルーライン
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @kanagawa_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @blueline_kanagawa
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.greenline_kanagawa #グリーンライン
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @kanagawa_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @greenline_kanagawa
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.minatomiraisen_kanagawa #みなとみらい線
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @kanagawa_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @minatomiraisen_kanagawa
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.seasideline_kanagawa #シーサイドライン
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @kanagawa_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @seasideline_kanagawa
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.enoshimadentetsu_kanagawa #江ノ島電鉄
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @kanagawa_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @enoshimadentetsu_kanagawa
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.shonanmonorail_kanagawa #湘南モノレール
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @kanagawa_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @shonanmonorail_kanagawa
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.hakonetozantetsudo_kanagawa #箱根登山鉄道
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @kanagawa_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @hakonetozantetsudo_kanagawa
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.hakonetozancablesen_kanagawa #箱根登山鉄道ケーブル
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @kanagawa_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @hakonetozancablesen_kanagawa
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.izuhakonedaiyuzansen_kanagawa #伊豆箱根大雄山線
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @kanagawa_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @izuhakonedaiyuzansen_kanagawa
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  # 千葉県
  def self.sobusen_chiba #総武線
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @chiba_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @sobusen_chiba
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.jobansen_chiba #常磐線
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @chiba_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @jobansen_chiba
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.naritasen_chiba #成田線
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @chiba_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @naritasen_chiba
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.musashinosen_chiba #武蔵野線
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @chiba_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @musashinosen_chiba
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.sobukaisokusen_chiba #総武快速線
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @chiba_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @sobukaisokusen_chiba
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.sobuhonsen_chiba #総武本線
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @chiba_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @sobuhonsen_chiba
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.keiyosen_chiba #京葉線
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @chiba_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @keiyosen_chiba
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.kashimasen_chiba #鹿島線
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @chiba_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @kashimasen_chiba
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.sotobosen_chiba #外房線
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @chiba_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @sotobosen_chiba
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.toganesen_chiba #東金線
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @chiba_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @toganesen_chiba
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.uchibosen_chiba #内房線
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @chiba_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @uchibosen_chiba
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.kururisen_chiba #久留里線
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @chiba_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @kururisen_chiba
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.tozaisen_chiba #東西線
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @chiba_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @tozaisen_chiba
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.toeishinjukusen_chiba #都営新宿線
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @chiba_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @toeishinjukusen_chiba
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.keiseihonsen_chiba #京成本線
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @chiba_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @keiseihonsen_chiba
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.keiseichibasen_chiba #京成千葉線
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @chiba_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @keiseichibasen_chiba
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.keiseichiharasen_chiba #京成千原線
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @chiba_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @keiseichiharasen_chiba
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.shinkeiseisen_chiba #新京成線
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @chiba_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @shinkeiseisen_chiba
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.tobunodasen_chiba #東武野田線
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @chiba_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @tobunodasen_chiba
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.hokusosen_chiba #北総線
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @chiba_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @hokusosen_chiba
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.tsukubaexpress_chiba #つくばエクスプレス
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @chiba_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @tsukubaexpress_chiba
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.chibatoshimonorail_chiba #千葉都市モノレール
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @chiba_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @chibatoshimonorail_chiba
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.ryutetsunagareyamasen_chiba #流山鉄道
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @chiba_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @ryutetsunagareyamasen_chiba
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.toyokosokutetsudo_chiba #東葉高速鉄道
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @chiba_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @toyokosokutetsudo_chiba
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.yukarigaokasen_chiba #ユーカリが丘線
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @chiba_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @yukarigaokasen_chiba
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.kominatotetsudosen_chiba #小湊鉄道
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @chiba_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @kominatotetsudosen_chiba
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.choshidentetsu_chiba #銚子電鉄
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @chiba_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @choshidentetsu_chiba
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.shibayamatetsudosen_chiba #芝山鉄道
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @chiba_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @shibayamatetsudosen_chiba
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.naritaskyaccess_chiba #成田スカイアクセス
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @chiba_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @naritaskyaccess_chiba
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  # 埼玉県
  def self.keihintohokusen_saitama #京浜東北線
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @saitama_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @keihintohokusen_saitama
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.saikyosen_saitama #埼京線
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @saitama_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @saikyosen_saitama
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.kawagoesen_saitama #川越線
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @saitama_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @kawagoesen_saitama
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.takasakisen_saitama #高崎線
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @saitama_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @takasakisen_saitama
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.utsunomiyasen_saitama #宇都宮線
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @saitama_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @utsunomiyasen_saitama
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.musashinosen_saitama #武蔵野線
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @saitama_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @musashinosen_saitama
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.hachikosen_saitama #八高線
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @saitama_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @hachikosen_saitama
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.shonanshinjukulineutsunomiyayokosukasen_saitama #湘南新宿ライン宇都宮横須賀線
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @saitama_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @shonanshinjukulineutsunomiyayokosukasen_saitama
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.shonanshinjukulinetakasakitokaidosen_saitama #湘南新宿ライン高崎東海道線
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @saitama_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @shonanshinjukulinetakasakitokaidosen_saitama
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.yurakuchosen_saitama #有楽町線
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @saitama_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @yurakuchosen_saitama
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.fukutoshinsen_saitama #副都心線
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @saitama_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @fukutoshinsen_saitama
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.seibushinjukusen_saitama #西武新宿線
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @saitama_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @seibushinjukusen_saitama
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.seibuikebukurosen_saitama #西武池袋線
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @saitama_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @seibuikebukurosen_saitama
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.seibusayamasen_saitama #西武狭山線
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @saitama_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @seibusayamasen_saitama
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.seibuyamaguchisen_saitama #西武山口線
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @saitama_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @seibuyamaguchisen_saitama
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.seibuchichibusen_saitama #西武秩父線
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @saitama_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @seibuchichibusen_saitama
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.tobutojosen_saitama #東武東上線
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @saitama_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @tobutojosen_saitama
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.tobuogosesen_saitama #東武越生線
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @saitama_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @tobuogosesen_saitama
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.tobuisesakisen_saitama #東武伊勢崎線
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @saitama_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @tobuisesakisen_saitama
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.tobunikkosen_saitama #東武日光線
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @saitama_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @tobunikkosen_saitama
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.tobunodasen_saitama #東武野田線
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @saitama_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @tobunodasen_saitama
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.saitamakosokutetsudo_saitama #埼玉高速鉄道
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @saitama_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @saitamakosokutetsudo_saitama
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.tsukubaexpress_saitama #つくばエクスプレス
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @saitama_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @tsukubaexpress_saitama
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.saitamashintoshikotsuinasen_saitama #埼玉新都市交通伊奈線
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @saitama_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @saitamashintoshikotsuinasen_saitama
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end
  def self.chichibutetsudo_saitama #秩父鉄道
    # get_station_infomationメソッド内に設置した@prefectureに一都三県の要素を代入する
    @prefecture = @saitama_rail_line_list
    # get_station_infomationメソッド内に設置した@rail_line_nameにバッチで回す沿線要素を代入する
    @rail_line_name = @chichibutetsudo_saitama
    # get_station_infomationメソッドを間取りごとに呼び出す
    get_station_infomation_floorplan_oneroom
    get_station_infomation_floorplan_1k1dk
    get_station_infomation_floorplan_1ldk2k2dk
    get_station_infomation_floorplan_2ldk3k3dk
    get_station_infomation_floorplan_3ldk4k
  end

  # 駅情報を取得しDBへ保存するベースとなるメソッド(間取りごとに定義)
  def self.get_station_infomation_floorplan_oneroom
    # option設定(スクレイピングブラウザの非表示)
    options = Selenium::WebDriver::Chrome::Options.new
    options.add_argument('--headless')
    # Seleniumの起動
    driver = Selenium::WebDriver.for :chrome#, options: options
    # driverに待機時間を指示
    wait = Selenium::WebDriver::Wait.new(:timeout => 60)
    # スクレイピングに関する以下の処理が成功できるまで例外処理でリトライを行う
    begin
      # 最初の遷移先の指定
      driver.get @prefecture
      # 沿線一覧から該当する沿線の要素を取得してクリック
      driver.find_element(:xpath, @rail_line_name).click
      # 表示された各沿線の「駅名」と「家賃相場金額」の値を取得して表示する(1回目の表示の間取りはワンルーム)
      infomations = driver.find_elements(:xpath, @station_name_and_market_price)
      # 空の変数rent_market_price = ''をif文の外側に定義し、ifとelseの分岐の際にインスタンスがリセットされないようにする。故に駅名と金額が同じレコードに保存されるようにする
      rent_market_price = ''
      # infomationsをループで回すと駅名→価格→駅名→価格・・・と言う順序でデータが取得できる
      infomations.each do |info|
        # !で真偽値を反転させる。integer_string?メソッドを呼び出しパラメータにinfo.textを渡して真偽判定を行う。infoの中身は駅名からなのでelseか始まる
        if !integer_string?(info.text)
          # infoのデータの順序的に先に既に駅名が設定されたインスタンスが存在するので、info.textの中の金額の部分をmarket_priceカラムに格納する。
          rent_market_price.market_price = info.text
          # 間取り(floor_plan)の情報をenum形式でrent_market_price.floor_planへ格納する　0 = "ワンルーム"
          rent_market_price.floor_plan = 0
          # infoの中身の順番が金額が後なので、金額をmarket_priceカラムに格納後にsaveする。これで1レコードが保存される
          rent_market_price.save
        else
          # infoの中身の順番が駅名が先に来るように要素を取得しているので、elseから始まり、if文の外に定義した空の変数rent_market_priceにRentMarketPriceにインスタンスをnewする
          rent_market_price = RentMarketPrice.new
          # info.textの中の駅名の部分をstation_nameカラムに格納してif文に戻る
          rent_market_price.station_name = info.text
        end
      end
    rescue
      # 例外処理、beginの処理が成功しなければリトライを行う
      retry
    end
  end
  def self.get_station_infomation_floorplan_1k1dk
    # option設定(スクレイピングブラウザの非表示)
    options = Selenium::WebDriver::Chrome::Options.new
    options.add_argument('--headless')
    # Seleniumの起動
    driver = Selenium::WebDriver.for :chrome#, options: options
    # driverに待機時間を指示
    wait = Selenium::WebDriver::Wait.new(:timeout => 60)
    # スクレイピングに関する以下の処理が成功できるまで例外処理でリトライを行う
    begin
      # 最初の遷移先の指定
      driver.get @prefecture
      # 沿線一覧から該当する沿線の要素を取得してクリック
      driver.find_element(:xpath, @rail_line_name).click
      # 1K/1DKの間取りのボタンの要素を取得してクリック
      driver.find_element(:xpath, @floorplan_1k_1dk_btn).click
      # 間取りを選択しクリックしたら情報反映のために更新ボタンの要素を取得してクリック
      driver.find_element(:xpath, @submit_btn).click
      # 表示された各沿線の「駅名」と「家賃相場金額」の値を取得して表示する(1回目の表示の間取りはワンルーム)
      infomations = driver.find_elements(:xpath, @station_name_and_market_price)
      # 空の変数rent_market_price = ''をif文の外側に定義し、ifとelseの分岐の際にインスタンスがリセットされないようにする。故に駅名と金額が同じレコードに保存されるようにする
      rent_market_price = ''
      # infomationsをループで回すと駅名→価格→駅名→価格・・・と言う順序でデータが取得できる
      infomations.each do |info|
        # !で真偽値を反転させる。integer_string?メソッドを呼び出しパラメータにinfo.textを渡して真偽判定を行う。infoの中身は駅名からなのでelseか始まる
        if !integer_string?(info.text)
          # infoのデータの順序的に先に既に駅名が設定されたインスタンスが存在するので、info.textの中の金額の部分をmarket_priceカラムに格納する。
          rent_market_price.market_price = info.text
          # 間取り(floor_plan)の情報をenum形式でrent_market_price.floor_planへ格納する　1 = "1K/1DK"
          rent_market_price.floor_plan = 1
          # infoの中身の順番が金額が後なので、金額をmarket_priceカラムに格納後にsaveする。これで1レコードが保存される
          rent_market_price.save
        else
          # infoの中身の順番が駅名が先に来るように要素を取得しているので、elseから始まり、if文の外に定義した空の変数rent_market_priceにRentMarketPriceにインスタンスをnewする
          rent_market_price = RentMarketPrice.new
          # info.textの中の駅名の部分をstation_nameカラムに格納してif文に戻る
          rent_market_price.station_name = info.text
        end
      end
    rescue
      # 例外処理、beginの処理が成功しなければリトライを行う
      retry
    end
  end
  def self.get_station_infomation_floorplan_1ldk2k2dk
    # option設定(スクレイピングブラウザの非表示)
    options = Selenium::WebDriver::Chrome::Options.new
    options.add_argument('--headless')
    # Seleniumの起動
    driver = Selenium::WebDriver.for :chrome#, options: options
    # driverに待機時間を指示
    wait = Selenium::WebDriver::Wait.new(:timeout => 60)
    # スクレイピングに関する以下の処理が成功できるまで例外処理でリトライを行う
    begin
      # 最初の遷移先の指定
      driver.get @prefecture
      # 沿線一覧から該当する沿線の要素を取得してクリック
      driver.find_element(:xpath, @rail_line_name).click
      # 1LDK/2K/2DKの間取りのボタンの要素を取得してクリック
      driver.find_element(:xpath, @floorplan_1ldk_2k_2dk_btn).click
      # 間取りを選択しクリックしたら情報反映のために更新ボタンの要素を取得してクリック
      driver.find_element(:xpath, @submit_btn).click
      # 表示された各沿線の「駅名」と「家賃相場金額」の値を取得して表示する(1回目の表示の間取りはワンルーム)
      infomations = driver.find_elements(:xpath, @station_name_and_market_price)
      # 空の変数rent_market_price = ''をif文の外側に定義し、ifとelseの分岐の際にインスタンスがリセットされないようにする。故に駅名と金額が同じレコードに保存されるようにする
      rent_market_price = ''
      # infomationsをループで回すと駅名→価格→駅名→価格・・・と言う順序でデータが取得できる
      infomations.each do |info|
        # !で真偽値を反転させる。integer_string?メソッドを呼び出しパラメータにinfo.textを渡して真偽判定を行う。infoの中身は駅名からなのでelseか始まる
        if !integer_string?(info.text)
          # infoのデータの順序的に先に既に駅名が設定されたインスタンスが存在するので、info.textの中の金額の部分をmarket_priceカラムに格納する。
          rent_market_price.market_price = info.text
          # 間取り(floor_plan)の情報をenum形式でrent_market_price.floor_planへ格納する　2 = "1LDK/2K/2DK"
          rent_market_price.floor_plan = 2
          # infoの中身の順番が金額が後なので、金額をmarket_priceカラムに格納後にsaveする。これで1レコードが保存される
          rent_market_price.save
        else
          # infoの中身の順番が駅名が先に来るように要素を取得しているので、elseから始まり、if文の外に定義した空の変数rent_market_priceにRentMarketPriceにインスタンスをnewする
          rent_market_price = RentMarketPrice.new
          # info.textの中の駅名の部分をstation_nameカラムに格納してif文に戻る
          rent_market_price.station_name = info.text
        end
      end
    rescue
      # 例外処理、beginの処理が成功しなければリトライを行う
      retry
    end
  end
  def self.get_station_infomation_floorplan_2ldk3k3dk
    # option設定(スクレイピングブラウザの非表示)
    options = Selenium::WebDriver::Chrome::Options.new
    options.add_argument('--headless')
    # Seleniumの起動
    driver = Selenium::WebDriver.for :chrome#, options: options
    # driverに待機時間を指示
    wait = Selenium::WebDriver::Wait.new(:timeout => 60)
    # スクレイピングに関する以下の処理が成功できるまで例外処理でリトライを行う
    begin
      # 最初の遷移先の指定
      driver.get @prefecture
      # 沿線一覧から該当する沿線の要素を取得してクリック
      driver.find_element(:xpath, @rail_line_name).click
      # 2LDK/3K/3DKの間取りのボタンの要素を取得してクリック
      driver.find_element(:xpath, @floorplan_2ldk_3k_3dk_btn).click
      # 間取りを選択しクリックしたら情報反映のために更新ボタンの要素を取得してクリック
      driver.find_element(:xpath, @submit_btn).click
      # 表示された各沿線の「駅名」と「家賃相場金額」の値を取得して表示する(1回目の表示の間取りはワンルーム)
      infomations = driver.find_elements(:xpath, @station_name_and_market_price)
      # 空の変数rent_market_price = ''をif文の外側に定義し、ifとelseの分岐の際にインスタンスがリセットされないようにする。故に駅名と金額が同じレコードに保存されるようにする
      rent_market_price = ''
      # infomationsをループで回すと駅名→価格→駅名→価格・・・と言う順序でデータが取得できる
      infomations.each do |info|
        # !で真偽値を反転させる。integer_string?メソッドを呼び出しパラメータにinfo.textを渡して真偽判定を行う。infoの中身は駅名からなのでelseか始まる
        if !integer_string?(info.text)
          # infoのデータの順序的に先に既に駅名が設定されたインスタンスが存在するので、info.textの中の金額の部分をmarket_priceカラムに格納する。
          rent_market_price.market_price = info.text
          # 間取り(floor_plan)の情報をenum形式でrent_market_price.floor_planへ格納する　3 = "2LDK/3K/3DK"
          rent_market_price.floor_plan = 3
          # infoの中身の順番が金額が後なので、金額をmarket_priceカラムに格納後にsaveする。これで1レコードが保存される
          rent_market_price.save
        else
          # infoの中身の順番が駅名が先に来るように要素を取得しているので、elseから始まり、if文の外に定義した空の変数rent_market_priceにRentMarketPriceにインスタンスをnewする
          rent_market_price = RentMarketPrice.new
          # info.textの中の駅名の部分をstation_nameカラムに格納してif文に戻る
          rent_market_price.station_name = info.text
        end
      end
    rescue
      # 例外処理、beginの処理が成功しなければリトライを行う
      retry
    end
  end
  def self.get_station_infomation_floorplan_3ldk4k
    # option設定(スクレイピングブラウザの非表示)
    options = Selenium::WebDriver::Chrome::Options.new
    options.add_argument('--headless')
    # Seleniumの起動
    driver = Selenium::WebDriver.for :chrome#, options: options
    # driverに待機時間を指示
    wait = Selenium::WebDriver::Wait.new(:timeout => 60)
    # スクレイピングに関する以下の処理が成功できるまで例外処理でリトライを行う
    begin
      # 最初の遷移先の指定
      driver.get @prefecture
      # 沿線一覧から該当する沿線の要素を取得してクリック
      driver.find_element(:xpath, @rail_line_name).click
      # 3LDK/4K~の間取りのボタンの要素を取得してクリック
      driver.find_element(:xpath, @floorplan_3ldk_4k_btn).click
      # 間取りを選択しクリックしたら情報反映のために更新ボタンの要素を取得してクリック
      driver.find_element(:xpath, @submit_btn).click
      # 表示された各沿線の「駅名」と「家賃相場金額」の値を取得して表示する(1回目の表示の間取りはワンルーム)
      infomations = driver.find_elements(:xpath, @station_name_and_market_price)
      # 空の変数rent_market_price = ''をif文の外側に定義し、ifとelseの分岐の際にインスタンスがリセットされないようにする。故に駅名と金額が同じレコードに保存されるようにする
      rent_market_price = ''
      # infomationsをループで回すと駅名→価格→駅名→価格・・・と言う順序でデータが取得できる
      infomations.each do |info|
        # !で真偽値を反転させる。integer_string?メソッドを呼び出しパラメータにinfo.textを渡して真偽判定を行う。infoの中身は駅名からなのでelseか始まる
        if !integer_string?(info.text)
          # infoのデータの順序的に先に既に駅名が設定されたインスタンスが存在するので、info.textの中の金額の部分をmarket_priceカラムに格納する。
          rent_market_price.market_price = info.text
          # 間取り(floor_plan)の情報をenum形式でrent_market_price.floor_planへ格納する　4 = "3LDK/4K~"
          rent_market_price.floor_plan = 4
          # infoの中身の順番が金額が後なので、金額をmarket_priceカラムに格納後にsaveする。これで1レコードが保存される
          rent_market_price.save
        else
          # infoの中身の順番が駅名が先に来るように要素を取得しているので、elseから始まり、if文の外に定義した空の変数rent_market_priceにRentMarketPriceにインスタンスをnewする
          rent_market_price = RentMarketPrice.new
          # info.textの中の駅名の部分をstation_nameカラムに格納してif文に戻る
          rent_market_price.station_name = info.text
        end
      end
    rescue
      # 例外処理、beginの処理が成功しなければリトライを行う
      retry
    end
  end

  # get_station_infomationメソッド内でループを回すinfo.textの中身(文字列or数値(小数))を判定するためのメソッド
  def self.integer_string?(str)
    # 受け取ったパラメータ(文字列)をto_fメソッドで10進数表現と解釈して浮動小数点(Float)に変換する
    value = str.to_f
    # 変換対象の文字列が0.0であることを基準にして判定する
    if value > 0
      return false
    else
      return true
    end
  end



  # 以下、ユーザーのアプリ操作に合わせた「目的地(駅)」「所要時間」「住みたいエリア」をスクレイピングで操作するメソッド
  # 変数化
  # 駅追加ボタン
  @add_station_btn = '//*[@id="js-timePanel-addStationBtn"]/a'
  # 目的地(駅)
  # $destination_1 = '渋谷' #動作確認用
  # $destination_2 = '武蔵中原' #動作確認用
  # 所要時間
  # $transit_time_1 = '20分以内' #動作確認用
  # $transit_time_2 = '10分以内' #動作確認用
  # 「住みたいエリア」ボタン
  @tokyo_btn = '//*[@id="ta13"]'
  @kanagawa_btn = '//*[@id="ta14"]'
  @saitama_btn = '//*[@id="ta11"]'
  @chiba_btn = '//*[@id="ta12"]'
  # 検索開始ボタン
  @search_start_btn = '//*[@id="js-contents-timePanel"]/div[2]/div[7]/a'
  # 「住みたいエリア」を東京都に絞って検索するメソッド
  def self.search_destination_transit_time_tokyo
    # option設定(スクレイピングブラウザの非表示)
    options = Selenium::WebDriver::Chrome::Options.new
    options.add_argument('--headless')
    # Seleniumの起動
    driver = Selenium::WebDriver.for :chrome, options: options
    # driverに待機時間を指示
    wait = Selenium::WebDriver::Wait.new(:timeout => 10)
    # スクレイピングに関する以下の処理が成功できるまで例外処理でリトライを行う
    begin
      # 最初の遷移先の指定
      driver.get "https://suumo.jp/jj/chintai/kensaku/FR301FB005/?ar=030&bs=040"
      # 今回は目的地を２駅設定したいので最初に「駅を追加する」のボタン要素を取得してクリックする
      driver.find_element(:xpath, @add_station_btn).click
      # 1駅目のフォームの要素取得と入力
      form_1 = driver.find_element(:xpath, '//*[@id="js-timePanel-ekiText_1"]')
      # フォーム入力の値はアプリ上でユーザーが入力した情報をcontrollerから値を引っ張るためグローバル変数を設定
      form_1.send_keys $destination_1
      # 入力エラーもしくはretry時の対策として一度クリアにして、あえて再度入力させる
      form_1.clear
      form_1.send_keys $destination_1
      # 1駅目の所要時間のセレクトタグの取得
      time_1 = driver.find_element(:tag_name, 'select')
      select_1 = Selenium::WebDriver::Support::Select.new(time_1)
      # 所要時間の選択はアプリ上のユーザーの選択した情報をcontrollerから値を引っ張るためグローバル変数を設定
      select_1.select_by(:text, $transit_time_1)
      # 2駅目のフォームの要素取得と入力
      form_2 = driver.find_element(:xpath, '//*[@id="js-timePanel-ekiText_2"]')
      # フォーム入力の値はユーザーが入力した情報をcontrollerから値を引っ張るためグローバル変数を設定
      form_2.send_keys $destination_2
      # 入力エラーもしくはretry時の対策として一度クリアにして、あえて再度入力させる
      form_2.clear
      form_2.send_keys $destination_2
      # 2駅目の所要時間のセレクトタグの取得(2回目は:xpathとしないと1回目と同じセレクトタグを取得してしまい上手く動作しない)
      time_2 = driver.find_element(:xpath, '//*[@id="js-timePanel-display_2"]/div[1]/dl[2]/dd/select')
      select_2 = Selenium::WebDriver::Support::Select.new(time_2)
      # controllerから値を引っ張るためグローバル変数を設定
      select_2.select_by(:text, $transit_time_2)
      # 「住みたいエリア」の東京の要素を取得してクリック
      driver.find_element(:xpath, @tokyo_btn).click
      # submitボタンの要素取得と実行(検索開始)
      driver.find_element(:xpath, @search_start_btn).click
      # 検索結果の表示(駅情報を頭2ページ分のみ取得する)
      # 検索結果のページに該当物件の件数の要素(paginate_set-hit)もしくは該当物件が存在しない場合の要素(error_pop-txt)のいずれかにヒットする要素を取得する
      element = driver.find_element(:xpath, '/html/body//*[contains(@class, "paginate_set-hit")or contains(@class, "error_pop-txt")or contains(@class, "errorbox")]')
      wait.until {element.displayed?}
      sleep(1)
      # 要素を取得してelementに格納できたらケースごとに出力する
      # 該当物件が存在する場合の処理(classの要素で判定)
      if element.attribute('class') == 'paginate_set-hit'
        # 検索結果の駅名を格納する空配列を作成。controller側で読み込めるようにグローバル変数化する
        $candidate_station = []
        # 2回分のページ遷移が真の間は処理が繰り返されるようにする
        page = 0
        while page < 2 do
          # 表示されたページの物件情報の中から駅情報の要素を取得してinfomations_pageへ格納する
          infomations_page = driver.find_elements(:xpath, '/html/body/div[5]/div/div[2]/div/div[1]//*[contains(@class, "cassetteitem_detail-text")]')
          # 指定された要素が表示状態になるまで待機する
          #wait.until {infomations_page.displayed?}
          # 格納された駅情報を順に表示する
          infomations_page.each do |info|
            # ブラウザの駅名html要素は/と駅の間に表示されているのでindexとsliceメソッドを使って駅名のみを取り出す
            a = info.text.index("/")
            b = info.text.index("駅")
            # 稀にバス便の情報が混じっていて"駅"表記がない場合はnilが返ってくるのでその情報はスキップする
            next if b.nil?
            # 最終的に取り出した駅名要素を$candidate_stationに格納していきcontrollerで読み込めるようにする
            $candidate_station << info.text.slice(a+1..b-1)
            # 動作確認用
            # puts $candidate_station
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
        $candidate_station = element.text
        # 動作確認用
        # puts $candidate_station
      elsif element.attribute('class') == 'errorbox'
        $candidate_station = element.text
        # 動作確認用
        # puts $candidate_station
      else
        $candidate_station = "想定外のエラーが起きています！！"
        # 動作確認用
        # puts $candidate_station
      end
    rescue
      # 例外処理、beginの処理が成功しなければリトライを行う
      retry
    end
  end
  # 「住みたいエリア」を神奈川県に絞って検索するメソッド
  def self.search_destination_transit_time_kanagawa
    # option設定(スクレイピングブラウザの非表示)
    options = Selenium::WebDriver::Chrome::Options.new
    options.add_argument('--headless')
    # Seleniumの起動
    driver = Selenium::WebDriver.for :chrome, options: options
    # driverに待機時間を指示
    wait = Selenium::WebDriver::Wait.new(:timeout => 10)
    # スクレイピングに関する以下の処理が成功できるまで例外処理でリトライを行う
    begin
      # 最初の遷移先の指定
      driver.get "https://suumo.jp/jj/chintai/kensaku/FR301FB005/?ar=030&bs=040"
      # 今回は目的地を２駅設定したいので最初に「駅を追加する」のボタン要素を取得してクリックする
      driver.find_element(:xpath, @add_station_btn).click
      # 1駅目のフォームの要素取得と入力
      form_1 = driver.find_element(:xpath, '//*[@id="js-timePanel-ekiText_1"]')
      # フォーム入力の値はアプリ上でユーザーが入力した情報をcontrollerから値を引っ張るためグローバル変数を設定
      form_1.send_keys $destination_1
      # 入力エラーもしくはretry時の対策として一度クリアにして、あえて再度入力させる
      form_1.clear
      form_1.send_keys $destination_1
      # 1駅目の所要時間のセレクトタグの取得
      time_1 = driver.find_element(:tag_name, 'select')
      select_1 = Selenium::WebDriver::Support::Select.new(time_1)
      # 所要時間の選択はアプリ上のユーザーの選択した情報をcontrollerから値を引っ張るためグローバル変数を設定
      select_1.select_by(:text, $transit_time_1)
      # 2駅目のフォームの要素取得と入力
      form_2 = driver.find_element(:xpath, '//*[@id="js-timePanel-ekiText_2"]')
      # フォーム入力の値はユーザーが入力した情報をcontrollerから値を引っ張るためグローバル変数を設定
      form_2.send_keys $destination_2
      # 入力エラーもしくはretry時の対策として一度クリアにして、あえて再度入力させる
      form_2.clear
      form_2.send_keys $destination_2
      # 2駅目の所要時間のセレクトタグの取得(2回目は:xpathとしないと1回目と同じセレクトタグを取得してしまい上手く動作しない)
      time_2 = driver.find_element(:xpath, '//*[@id="js-timePanel-display_2"]/div[1]/dl[2]/dd/select')
      select_2 = Selenium::WebDriver::Support::Select.new(time_2)
      # controllerから値を引っ張るためグローバル変数を設定
      select_2.select_by(:text, $transit_time_2)
      # 「住みたいエリア」の神奈川の要素を取得してクリック
      driver.find_element(:xpath, @kanagawa_btn).click
      # submitボタンの要素取得と実行(検索開始)
      driver.find_element(:xpath, @search_start_btn).click
      # 検索結果の表示(駅情報を頭2ページ分のみ取得する)
      # 検索結果のページに該当物件の件数の要素(paginate_set-hit)もしくは該当物件が存在しない場合の要素(error_pop-txt)のいずれかにヒットする要素を取得する
      element = driver.find_element(:xpath, '/html/body//*[contains(@class, "paginate_set-hit")or contains(@class, "error_pop-txt")or contains(@class, "errorbox")]')
      wait.until {element.displayed?}
      sleep(1)
      # 要素を取得してelementに格納できたらケースごとに出力する
      # 該当物件が存在する場合の処理(classの要素で判定)
      if element.attribute('class') == 'paginate_set-hit'
        # 検索結果の駅名を格納する空配列を作成。controller側で読み込めるようにグローバル変数化する
        $candidate_station = []
        # 2回分のページ遷移が真の間は処理が繰り返されるようにする
        page = 0
        while page < 2 do
          # 表示されたページの物件情報の中から駅情報の要素を取得してinfomations_pageへ格納する
          infomations_page = driver.find_elements(:xpath, '/html/body/div[5]/div/div[2]/div/div[1]//*[contains(@class, "cassetteitem_detail-text")]')
          # 指定された要素が表示状態になるまで待機する
          #wait.until {infomations_page.displayed?}
          # 格納された駅情報を順に表示する
          infomations_page.each do |info|
            # ブラウザの駅名html要素は/と駅の間に表示されているのでindexとsliceメソッドを使って駅名のみを取り出す
            a = info.text.index("/")
            b = info.text.index("駅")
            # 稀にバス便の情報が混じっていて"駅"表記がない場合はnilが返ってくるのでその情報はスキップする
            next if b.nil?
            # 最終的に取り出した駅名要素を$candidate_stationに格納していきcontrollerで読み込めるようにする
            $candidate_station << info.text.slice(a+1..b-1)
            # 動作確認用
            # puts $candidate_station
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
        $candidate_station = element.text
        # 動作確認用
        # puts $candidate_station
      elsif element.attribute('class') == 'errorbox'
        $candidate_station = element.text
        # 動作確認用
        # puts $candidate_station
      else
        $candidate_station = "想定外のエラーが起きています！！"
        # 動作確認用
        # puts $candidate_station
      end
    rescue
      # 例外処理、beginの処理が成功しなければリトライを行う
      retry
    end
  end
  # 「住みたいエリア」を埼玉県に絞って検索するメソッド
  def self.search_destination_transit_time_saitama
    # option設定(スクレイピングブラウザの非表示)
    options = Selenium::WebDriver::Chrome::Options.new
    options.add_argument('--headless')
    # Seleniumの起動
    driver = Selenium::WebDriver.for :chrome, options: options
    # driverに待機時間を指示
    wait = Selenium::WebDriver::Wait.new(:timeout => 10)
    # スクレイピングに関する以下の処理が成功できるまで例外処理でリトライを行う
    begin
      # 最初の遷移先の指定
      driver.get "https://suumo.jp/jj/chintai/kensaku/FR301FB005/?ar=030&bs=040"
      # 今回は目的地を２駅設定したいので最初に「駅を追加する」のボタン要素を取得してクリックする
      driver.find_element(:xpath, @add_station_btn).click
      # 1駅目のフォームの要素取得と入力
      form_1 = driver.find_element(:xpath, '//*[@id="js-timePanel-ekiText_1"]')
      # フォーム入力の値はアプリ上でユーザーが入力した情報をcontrollerから値を引っ張るためグローバル変数を設定
      form_1.send_keys $destination_1
      # 入力エラーもしくはretry時の対策として一度クリアにして、あえて再度入力させる
      form_1.clear
      form_1.send_keys $destination_1
      # 1駅目の所要時間のセレクトタグの取得
      time_1 = driver.find_element(:tag_name, 'select')
      select_1 = Selenium::WebDriver::Support::Select.new(time_1)
      # 所要時間の選択はアプリ上のユーザーの選択した情報をcontrollerから値を引っ張るためグローバル変数を設定
      select_1.select_by(:text, $transit_time_1)
      # 2駅目のフォームの要素取得と入力
      form_2 = driver.find_element(:xpath, '//*[@id="js-timePanel-ekiText_2"]')
      # フォーム入力の値はユーザーが入力した情報をcontrollerから値を引っ張るためグローバル変数を設定
      form_2.send_keys $destination_2
      # 入力エラーもしくはretry時の対策として一度クリアにして、あえて再度入力させる
      form_2.clear
      form_2.send_keys $destination_2
      # 2駅目の所要時間のセレクトタグの取得(2回目は:xpathとしないと1回目と同じセレクトタグを取得してしまい上手く動作しない)
      time_2 = driver.find_element(:xpath, '//*[@id="js-timePanel-display_2"]/div[1]/dl[2]/dd/select')
      select_2 = Selenium::WebDriver::Support::Select.new(time_2)
      # controllerから値を引っ張るためグローバル変数を設定
      select_2.select_by(:text, $transit_time_2)
      # 「住みたいエリア」の埼玉の要素を取得してクリック
      driver.find_element(:xpath, @saitama_btn).click
      # submitボタンの要素取得と実行(検索開始)
      driver.find_element(:xpath, @search_start_btn).click
      # 検索結果の表示(駅情報を頭2ページ分のみ取得する)
      # 検索結果のページに該当物件の件数の要素(paginate_set-hit)もしくは該当物件が存在しない場合の要素(error_pop-txt)のいずれかにヒットする要素を取得する
      element = driver.find_element(:xpath, '/html/body//*[contains(@class, "paginate_set-hit")or contains(@class, "error_pop-txt")or contains(@class, "errorbox")]')
      wait.until {element.displayed?}
      sleep(1)
      # 要素を取得してelementに格納できたらケースごとに出力する
      # 該当物件が存在する場合の処理(classの要素で判定)
      if element.attribute('class') == 'paginate_set-hit'
        # 検索結果の駅名を格納する空配列を作成。controller側で読み込めるようにグローバル変数化する
        $candidate_station = []
        # 2回分のページ遷移が真の間は処理が繰り返されるようにする
        page = 0
        while page < 2 do
          # 表示されたページの物件情報の中から駅情報の要素を取得してinfomations_pageへ格納する
          infomations_page = driver.find_elements(:xpath, '/html/body/div[5]/div/div[2]/div/div[1]//*[contains(@class, "cassetteitem_detail-text")]')
          # 指定された要素が表示状態になるまで待機する
          #wait.until {infomations_page.displayed?}
          # 格納された駅情報を順に表示する
          infomations_page.each do |info|
            # ブラウザの駅名html要素は/と駅の間に表示されているのでindexとsliceメソッドを使って駅名のみを取り出す
            a = info.text.index("/")
            b = info.text.index("駅")
            # 稀にバス便の情報が混じっていて"駅"表記がない場合はnilが返ってくるのでその情報はスキップする
            next if b.nil?
            # 最終的に取り出した駅名要素を$candidate_stationに格納していきcontrollerで読み込めるようにする
            $candidate_station << info.text.slice(a+1..b-1)
            # 動作確認用
            # puts $candidate_station
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
        $candidate_station = element.text
        # 動作確認用
        # puts $candidate_station
      elsif element.attribute('class') == 'errorbox'
        $candidate_station = element.text
        # 動作確認用
        # puts $candidate_station
      else
        $candidate_station = "想定外のエラーが起きています！！"
        # 動作確認用
        # puts $candidate_station
      end
    rescue
      # 例外処理、beginの処理が成功しなければリトライを行う
      retry
    end
  end
  # 「住みたいエリア」を千葉県に絞って検索するメソッド
  def self.search_destination_transit_time_chiba
    # option設定(スクレイピングブラウザの非表示)
    options = Selenium::WebDriver::Chrome::Options.new
    options.add_argument('--headless')
    # Seleniumの起動
    driver = Selenium::WebDriver.for :chrome, options: options
    # driverに待機時間を指示
    wait = Selenium::WebDriver::Wait.new(:timeout => 10)
    # スクレイピングに関する以下の処理が成功できるまで例外処理でリトライを行う
    begin
      # 最初の遷移先の指定
      driver.get "https://suumo.jp/jj/chintai/kensaku/FR301FB005/?ar=030&bs=040"
      # 今回は目的地を２駅設定したいので最初に「駅を追加する」のボタン要素を取得してクリックする
      driver.find_element(:xpath, @add_station_btn).click
      # 1駅目のフォームの要素取得と入力
      form_1 = driver.find_element(:xpath, '//*[@id="js-timePanel-ekiText_1"]')
      # フォーム入力の値はアプリ上でユーザーが入力した情報をcontrollerから値を引っ張るためグローバル変数を設定
      form_1.send_keys $destination_1
      # 入力エラーもしくはretry時の対策として一度クリアにして、あえて再度入力させる
      form_1.clear
      form_1.send_keys $destination_1
      # 1駅目の所要時間のセレクトタグの取得
      time_1 = driver.find_element(:tag_name, 'select')
      select_1 = Selenium::WebDriver::Support::Select.new(time_1)
      # 所要時間の選択はアプリ上のユーザーの選択した情報をcontrollerから値を引っ張るためグローバル変数を設定
      select_1.select_by(:text, $transit_time_1)
      # 2駅目のフォームの要素取得と入力
      form_2 = driver.find_element(:xpath, '//*[@id="js-timePanel-ekiText_2"]')
      # フォーム入力の値はユーザーが入力した情報をcontrollerから値を引っ張るためグローバル変数を設定
      form_2.send_keys $destination_2
      # 入力エラーもしくはretry時の対策として一度クリアにして、あえて再度入力させる
      form_2.clear
      form_2.send_keys $destination_2
      # 2駅目の所要時間のセレクトタグの取得(2回目は:xpathとしないと1回目と同じセレクトタグを取得してしまい上手く動作しない)
      time_2 = driver.find_element(:xpath, '//*[@id="js-timePanel-display_2"]/div[1]/dl[2]/dd/select')
      select_2 = Selenium::WebDriver::Support::Select.new(time_2)
      # controllerから値を引っ張るためグローバル変数を設定
      select_2.select_by(:text, $transit_time_2)
      # 「住みたいエリア」の千葉の要素を取得してクリック
      driver.find_element(:xpath, @chiba_btn).click
      # submitボタンの要素取得と実行(検索開始)
      driver.find_element(:xpath, @search_start_btn).click
      # 検索結果の表示(駅情報を頭2ページ分のみ取得する)
      # 検索結果のページに該当物件の件数の要素(paginate_set-hit)もしくは該当物件が存在しない場合の要素(error_pop-txt)のいずれかにヒットする要素を取得する
      element = driver.find_element(:xpath, '/html/body//*[contains(@class, "paginate_set-hit")or contains(@class, "error_pop-txt")or contains(@class, "errorbox")]')
      wait.until {element.displayed?}
      sleep(1)
      # 要素を取得してelementに格納できたらケースごとに出力する
      # 該当物件が存在する場合の処理(classの要素で判定)
      if element.attribute('class') == 'paginate_set-hit'
        # 検索結果の駅名を格納する空配列を作成。controller側で読み込めるようにグローバル変数化する
        $candidate_station = []
        # 2回分のページ遷移が真の間は処理が繰り返されるようにする
        page = 0
        while page < 2 do
          # 表示されたページの物件情報の中から駅情報の要素を取得してinfomations_pageへ格納する
          infomations_page = driver.find_elements(:xpath, '/html/body/div[5]/div/div[2]/div/div[1]//*[contains(@class, "cassetteitem_detail-text")]')
          # 指定された要素が表示状態になるまで待機する
          #wait.until {infomations_page.displayed?}
          # 格納された駅情報を順に表示する
          infomations_page.each do |info|
            # ブラウザの駅名html要素は/と駅の間に表示されているのでindexとsliceメソッドを使って駅名のみを取り出す
            a = info.text.index("/")
            b = info.text.index("駅")
            # 稀にバス便の情報が混じっていて"駅"表記がない場合はnilが返ってくるのでその情報はスキップする
            next if b.nil?
            # 最終的に取り出した駅名要素を$candidate_stationに格納していきcontrollerで読み込めるようにする
            $candidate_station << info.text.slice(a+1..b-1)
            # 動作確認用
            # puts $candidate_station
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
        $candidate_station = element.text
        # 動作確認用
        # puts $candidate_station
      elsif element.attribute('class') == 'errorbox'
        $candidate_station = element.text
        # 動作確認用
        # puts $candidate_station
      else
        $candidate_station = "想定外のエラーが起きています！！"
        # 動作確認用
        # puts $candidate_station
      end
    rescue
      # 例外処理、beginの処理が成功しなければリトライを行う
      retry
    end
  end



  # Twitter API(精度が低いので今回は採用しません)
  # def self.twitter
  #   client = Twitter::REST::Client.new do |config|
  #     config.consumer_key        = ENV["API_KEY"]
  #     config.consumer_secret     = ENV["API_KEY_SECRET"]
  #     config.access_token        = ENV["ACCESS_TOKEN"]
  #     config.access_token_secret = ENV["ACCESS_TOKEN_SECRET"]
  #   end
  #   client.search("目黒駅 静か", result_type: "recent").take(10).collect do |tweet|
  #     puts tweet.text
  #   end
  # end
  # Places APIの動作時に必要な駅のgeocode(座標)を取得してdbへ保存する(スクレイピングの動作が安定しないのと、Places APIで座標が必須ではなかったので今回は採用しません)
  # def self.get_geocoding
  #   # option設定(スクレイピングブラウザの非表示)
  #   options = Selenium::WebDriver::Chrome::Options.new
  #   options.add_argument('--headless')
  #   # Seleniumの起動
  #   driver = Selenium::WebDriver.for :chrome, options: options
  #   # driverに待機時間を指示
  #   wait = Selenium::WebDriver::Wait.new(:timeout => 10)
  #   # RentMarketPriceテーブルの全レコードを取得する
  #   records = RentMarketPrice.all
  #   # 1つのレコードごとにループ処理を行って、その中でスクレイピング時に駅名の使用と、取得した座標の値の座標カラムへの追加をレコードごとに行なっていく
  #   records.each do |record|
  #     # 最初の遷移先の指定
  #     driver.get "https://www.geocoding.jp/api/"
  #     # formの要素を取得
  #     form = driver.find_element(:xpath, '//*[@id="searchbox"]')
  #     # formにループで回しているレコードの駅名を取得して入力する
  #     form.send_keys record.station_name+"駅"
  #     # 前の駅名情報が残ってしまっていると嫌なので、あえて一度クリアして再度駅名を入力する
  #     form.clear
  #     form.send_keys record.station_name+"駅"
  #     # 検索開始ボタンの要素取得とボタンのクリック
  #     driver.find_element(:xpath, '/html/body/div/center/div[3]/form/div[2]/input[1]').click
  #     sleep(1)
  #     # 検索結果が表示されたページで座標の要素を取得する(数値だけ取り出せなかったのでこの後に削ぎ落とす)
  #     elements = driver.find_elements(:id, 'folder1')
  #     elements.each do |element|
  #       # latitude(緯度) タグの中身を必要な数値だけ取り出す
  #       latitude_head = element.text.index("<lat>")
  #       latitude_end = element.text.index("</lat>")
  #       # 削ぎ落とした緯度の数値だけをループで回しているレコードの緯度カラムへ格納する
  #       record.geocode_latitude = element.text.slice(latitude_head+5..latitude_end-1)
  #       # puts latitude # 動作確認用
  #       # longitude(経度) タグの中身を必要な数値だけ取り出す
  #       longitude_head = element.text.index("<lng>")
  #       longitude_end = element.text.index("</lng>")
  #       # 削ぎ落とした緯度の数値だけをループで回しているレコードの経度カラムへ格納する
  #       record.geocode_longitude = element.text.slice(longitude_head+5..longitude_end-1)
  #       # puts longitude # 動作確認用
  #       record.save
  #     end
  #     # サイト運営者より検索は10秒に1件くらいにしてほしいと但し書きあり
  #     sleep(10)
  #   end
  # end

  # Google Places API
  # gym
  def self.google_places_gym
    # APIを扱うクラスのインスタンスを用意する
    client = GooglePlaces::Client.new(ENV['GOOGLE_API_KEY'])
    # RentMarketPriceテーブルの全レコードを取得する
    records = RentMarketPrice.all
    # レコードごとにループを回す
    records.each do |record|
      # 最初にレコードから駅名を取り出し、その駅の情報を検索して座標(緯度・経度)を取得する
      geocodes = client.spots_by_query("#{record.station_name}駅", :language => 'ja') # 式展開はダブルクォーテーション
      geocodes.each do |geocode|
        # 緯度の取得
        @lat = geocode.lat
        # 経度の取得
        @lng = geocode.lng
      end
      # 上で取得した座標を代入して検索中の駅の半径200m以内の施設を検索する
      gyms = client.spots(@lat, @lng, :radius => 200, :language => 'ja', :name => 'フィットネスジム')
      # present?で真偽判定。結果が1以上あれば"有り"、0であれば"無し"でgymカラムに保存する
      if gyms.present?
        record.gym = "有り"
      elsif !gyms.present?
        record.gym = "無し"
      end
      record.save
    end
  end
end
