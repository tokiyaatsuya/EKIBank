# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Rails.rootを使用するための設定
require File.expand_path(File.dirname(__FILE__) + '/environment')
# cronを実行する環境変数の作成
rails_env = ENV['RAILS_ENV'] || :development
# cronを実行する環境変数のセット
set :environment, rails_env
# ログファイルの出力先の指定
set :output, "#{Rails.root}/log/cron.log"
# 実際に行うジョブの頻度や内容の指定
# crontab型の設定「分」「時」「日」「月」「曜日」
# 東京沿線
every '0 0 1 * *' do
  runner "RentMarketPrice.yamanotesen_tokyo"
end
every '5 0 1 * *' do
  runner "RentMarketPrice.keihintohokusen_tokyo"
end
every '10 0 1 * *' do
  runner "RentMarketPrice.tokaidohonsen_tokyo"
end
every '15 0 1 * *' do
  runner "RentMarketPrice.jobansen_tokyo"
end
every '20 0 1 * *' do
  runner "RentMarketPrice.nambusen_tokyo"
end
every '25 0 1 * *' do
  runner "RentMarketPrice.yokohamasen_tokyo"
end
every '30 0 1 * *' do
  runner "RentMarketPrice.yokosukasen_tokyo"
end
every '35 0 1 * *' do
  runner "RentMarketPrice.chuosen_tokyo"
end
every '40 0 1 * *' do
  runner "RentMarketPrice.omesen_tokyo"
end
every '45 0 1 * *' do
  runner "RentMarketPrice.itsukaichisen_tokyo"
end
every '50 0 1 * *' do
  runner "RentMarketPrice.musashinosen_tokyo"
end
every '55 0 1 * *' do
  runner "RentMarketPrice.hachikosen_tokyo"
end
every '0 1 1 * *' do
  runner "RentMarketPrice.saikyosen_tokyo"
end
every '5 1 1 * *' do
  runner "RentMarketPrice.takasakisen_tokyo"
end
every '10 1 1 * *' do
  runner "RentMarketPrice.utsunomiyasen_tokyo"
end
every '15 1 1 * *' do
  runner "RentMarketPrice.sobusen_tokyo"
end
every '20 1 1 * *' do
  runner "RentMarketPrice.sobukaisokusen_tokyo"
end
every '25 1 1 * *' do
  runner "RentMarketPrice.keiyosen_tokyo"
end
every '30 1 1 * *' do
  runner "RentMarketPrice.shonanshinjukulineutsunomiyayokosukasen_tokyo"
end
every '35 1 1 * *' do
  runner "RentMarketPrice.shonanshinjukulinetakasakitokaidosen_tokyo"
end
every '40 1 1 * *' do
  runner "RentMarketPrice.ginzasen_tokyo"
end
every '45 1 1 * *' do
  runner "RentMarketPrice.marunouchisen_tokyo"
end
every '50 1 1 * *' do
  runner "RentMarketPrice.hibiyasen_tokyo"
end
every '55 1 1 * *' do
  runner "RentMarketPrice.tozaisen_tokyo"
end
every '0 2 1 * *' do
  runner "RentMarketPrice.chiyodasen_tokyo"
end
every '5 2 1 * *' do
  runner "RentMarketPrice.yurakuchosen_tokyo"
end
every '10 2 1 * *' do
  runner "RentMarketPrice.hanzomonsen_tokyo"
end
every '15 2 1 * *' do
  runner "RentMarketPrice.nambokusen_tokyo"
end
every '20 2 1 * *' do
  runner "RentMarketPrice.fukutoshinsen_tokyo"
end
every '25 2 1 * *' do
  runner "RentMarketPrice.seibuyurakuchosen_tokyo"
end
every '30 2 1 * *' do
  runner "RentMarketPrice.seibushinjukusen_tokyo"
end
every '35 2 1 * *' do
  runner "RentMarketPrice.seibuikebukurosen_tokyo"
end
every '40 2 1 * *' do
  runner "RentMarketPrice.seibuhaijimasen_tokyo"
end
every '45 2 1 * *' do
  runner "RentMarketPrice.seibuyamaguchisen_tokyo"
end
every '50 2 1 * *' do
  runner "RentMarketPrice.seibukokubunjisen_tokyo"
end
every '55 2 1 * *' do
  runner "RentMarketPrice.seibutamagawasen_tokyo"
end
every '0 3 1 * *' do
  runner "RentMarketPrice.seibutamakosen_tokyo"
end
every '5 3 1 * *' do
  runner "RentMarketPrice.seibuseibuensen_tokyo"
end
every '10 3 1 * *' do
  runner "RentMarketPrice.seibutoshimasen_tokyo"
end
every '15 3 1 * *' do
  runner "RentMarketPrice.tobutojosen_tokyo"
end
every '20 3 1 * *' do
  runner "RentMarketPrice.tobuisesakisen_tokyo"
end
every '25 3 1 * *' do
  runner "RentMarketPrice.tobukameidosen_tokyo"
end
every '30 3 1 * *' do
  runner "RentMarketPrice.tobudaishisen_tokyo"
end
every '35 3 1 * *' do
  runner "RentMarketPrice.tokyutoyokosen_tokyo"
end
every '40 3 1 * *' do
  runner "RentMarketPrice.tokyudenentoshisen_tokyo"
end
every '45 3 1 * *' do
  runner "RentMarketPrice.tokyuikegamisen_tokyo"
end
every '50 3 1 * *' do
  runner "RentMarketPrice.tokyumegurosen_tokyo"
end
every '55 3 1 * *' do
  runner "RentMarketPrice.tokyutamagawasen_tokyo"
end
every '0 4 1 * *' do
  runner "RentMarketPrice.tokyuoimachisen_tokyo"
end
every '5 4 1 * *' do
  runner "RentMarketPrice.tokyusetagayasen_tokyo"
end
every '10 4 1 * *' do
  runner "RentMarketPrice.toeiasakusasen_tokyo"
end
every '15 4 1 * *' do
  runner "RentMarketPrice.toeimitasen_tokyo"
end
every '20 4 1 * *' do
  runner "RentMarketPrice.toeishinjukusen_tokyo"
end
every '25 4 1 * *' do
  runner "RentMarketPrice.toeioedosen_tokyo"
end
every '30 4 1 * *' do
  runner "RentMarketPrice.todenarakawasen_tokyo"
end
every '35 4 1 * *' do
  runner "RentMarketPrice.nipporitoneriliner_tokyo"
end
every '40 4 1 * *' do
  runner "RentMarketPrice.keioinokashirasen_tokyo"
end
every '45 4 1 * *' do
  runner "RentMarketPrice.keiokeibajosen_tokyo"
end
every '50 4 1 * *' do
  runner "RentMarketPrice.keioshinsen_tokyo"
end
every '55 4 1 * *' do
  runner "RentMarketPrice.keiosen_tokyo"
end
every '0 5 1 * *' do
  runner "RentMarketPrice.keiodobutsuensen_tokyo"
end
every '5 5 1 * *' do
  runner "RentMarketPrice.keiosagamiharasen_tokyo"
end
every '10 5 1 * *' do
  runner "RentMarketPrice.keiotakaosen_tokyo"
end
every '15 5 1 * *' do
  runner "RentMarketPrice.keiseioshiagesen_tokyo"
end
every '20 5 1 * *' do
  runner "RentMarketPrice.keiseikanamachisen_tokyo"
end
every '25 5 1 * *' do
  runner "RentMarketPrice.keiseihonsen_tokyo"
end
every '30 5 1 * *' do
  runner "RentMarketPrice.keikyuhonsen_tokyo"
end
every '35 5 1 * *' do
  runner "RentMarketPrice.keikyukukosen_tokyo"
end
every '40 5 1 * *' do
  runner "RentMarketPrice.odakyusen_tokyo"
end
every '45 5 1 * *' do
  runner "RentMarketPrice.odakyutamasen_tokyo"
end
every '50 5 1 * *' do
  runner "RentMarketPrice.tamatoshimonorail_tokyo"
end
every '55 5 1 * *' do
  runner "RentMarketPrice.rinkaisen_tokyo"
end
every '0 6 1 * *' do
  runner "RentMarketPrice.hokusosen_tokyo"
end
every '5 6 1 * *' do
  runner "RentMarketPrice.tokyomonorail_tokyo"
end
every '10 6 1 * *' do
  runner "RentMarketPrice.shinkotsuyurikamome_tokyo"
end
every '15 6 1 * *' do
  runner "RentMarketPrice.saitamakosokutetsudo_tokyo"
end
every '20 6 1 * *' do
  runner "RentMarketPrice.tsukubaexpress_tokyo"
end
every '25 6 1 * *' do
  runner "RentMarketPrice.naritaskyaccess_tokyo"
end
# 神奈川沿線
every '30 6 1 * *' do
  runner "RentMarketPrice.tokyuoimachisen_kanagawa"
end
every '35 6 1 * *' do
  runner "RentMarketPrice.tokyutoyokosen_kanagawa"
end
every '40 6 1 * *' do
  runner "RentMarketPrice.tokyudenentoshisen_kanagawa"
end
every '45 6 1 * *' do
  runner "RentMarketPrice.tokyukodomonokunisen_kanagawa"
end
every '50 6 1 * *' do
  runner "RentMarketPrice.tokyumegurosen_kanagawa"
end
every '55 6 1 * *' do
  runner "RentMarketPrice.yokosukasen_kanagawa"
end
every '0 7 1 * *' do
  runner "RentMarketPrice.keihintohokusen_kanagawa"
end
every '5 7 1 * *' do
  runner "RentMarketPrice.negishisen_kanagawa"
end
every '10 7 1 * *' do
  runner "RentMarketPrice.tsurumisen_kanagawa"
end
every '15 7 1 * *' do
  runner "RentMarketPrice.tokaidohonsen_kanagawa"
end
every '20 7 1 * *' do
  runner "RentMarketPrice.gotembasen_kanagawa"
end
every '25 7 1 * *' do
  runner "RentMarketPrice.nambusen_kanagawa"
end
every '30 7 1 * *' do
  runner "RentMarketPrice.yokohamasen_kanagawa"
end
every '35 7 1 * *' do
  runner "RentMarketPrice.sagamisen_kanagawa"
end
every '40 7 1 * *' do
  runner "RentMarketPrice.chuosen_kanagawa"
end
every '45 7 1 * *' do
  runner "RentMarketPrice.shonanshinjukulineutsunomiyayokosukasen_kanagawa"
end
every '50 7 1 * *' do
  runner "RentMarketPrice.shonanshinjukulinetakasakitokaidosen_kanagawa"
end
every '55 7 1 * *' do
  runner "RentMarketPrice.keiosagamiharasen_kanagawa"
end
every '0 8 1 * *' do
  runner "RentMarketPrice.keikyuhonsen_kanagawa"
end
every '5 8 1 * *' do
  runner "RentMarketPrice.keikyudaishisen_kanagawa"
end
every '10 8 1 * *' do
  runner "RentMarketPrice.keikyuzushisen_kanagawa"
end
every '15 8 1 * *' do
  runner "RentMarketPrice.keikyukurihamasen_kanagawa"
end
every '20 8 1 * *' do
  runner "RentMarketPrice.odakyusen_kanagawa"
end
every '25 8 1 * *' do
  runner "RentMarketPrice.odakyuodawarasen_kanagawa"
end
every '30 8 1 * *' do
  runner "RentMarketPrice.odakyutamasen_kanagawa"
end
every '35 8 1 * *' do
  runner "RentMarketPrice.odakyuenoshimasen_kanagawa"
end
every '40 8 1 * *' do
  runner "RentMarketPrice.sotetsuhonsen_kanagawa"
end
every '45 8 1 * *' do
  runner "RentMarketPrice.sotetsuizuminosen_kanagawa"
end
every '50 8 1 * *' do
  runner "RentMarketPrice.sotetsushinyokohamasen_kanagawa"
end
every '55 8 1 * *' do
  runner "RentMarketPrice.blueline_kanagawa"
end
every '0 9 1 * *' do
  runner "RentMarketPrice.greenline_kanagawa"
end
every '5 9 1 * *' do
  runner "RentMarketPrice.minatomiraisen_kanagawa"
end
every '10 9 1 * *' do
  runner "RentMarketPrice.seasideline_kanagawa"
end
every '15 9 1 * *' do
  runner "RentMarketPrice.enoshimadentetsu_kanagawa"
end
every '20 9 1 * *' do
  runner "RentMarketPrice.shonanmonorail_kanagawa"
end
every '25 9 1 * *' do
  runner "RentMarketPrice.hakonetozantetsudo_kanagawa"
end
every '30 9 1 * *' do
  runner "RentMarketPrice.hakonetozancablesen_kanagawa"
end
every '35 9 1 * *' do
  runner "RentMarketPrice.izuhakonedaiyuzansen_kanagawa"
end
# 千葉沿線
every '40 9 1 * *' do
  runner "RentMarketPrice.sobusen_chiba"
end
every '45 9 1 * *' do
  runner "RentMarketPrice.jobansen_chiba"
end
every '50 9 1 * *' do
  runner "RentMarketPrice.naritasen_chiba"
end
every '55 9 1 * *' do
  runner "RentMarketPrice.musashinosen_chiba"
end
every '0 10 1 * *' do
  runner "RentMarketPrice.sobukaisokusen_chiba"
end
every '5 10 1 * *' do
  runner "RentMarketPrice.sobuhonsen_chiba"
end
every '10 10 1 * *' do
  runner "RentMarketPrice.keiyosen_chiba"
end
every '15 10 1 * *' do
  runner "RentMarketPrice.kashimasen_chiba"
end
every '20 10 1 * *' do
  runner "RentMarketPrice.sotobosen_chiba"
end
every '25 10 1 * *' do
  runner "RentMarketPrice.toganesen_chiba"
end
every '30 10 1 * *' do
  runner "RentMarketPrice.uchibosen_chiba"
end
every '35 10 1 * *' do
  runner "RentMarketPrice.kururisen_chiba"
end
every '40 10 1 * *' do
  runner "RentMarketPrice.tozaisen_chiba"
end
every '45 10 1 * *' do
  runner "RentMarketPrice.toeishinjukusen_chiba"
end
every '50 10 1 * *' do
  runner "RentMarketPrice.keiseihonsen_chiba"
end
every '55 10 1 * *' do
  runner "RentMarketPrice.keiseichibasen_chiba"
end
every '0 11 1 * *' do
  runner "RentMarketPrice.keiseichiharasen_chiba"
end
every '5 11 1 * *' do
  runner "RentMarketPrice.shinkeiseisen_chiba"
end
every '10 11 1 * *' do
  runner "RentMarketPrice.tobunodasen_chiba"
end
every '15 11 1 * *' do
  runner "RentMarketPrice.hokusosen_chiba"
end
every '20 11 1 * *' do
  runner "RentMarketPrice.tsukubaexpress_chiba"
end
every '25 11 1 * *' do
  runner "RentMarketPrice.chibatoshimonorail_chiba"
end
every '30 11 1 * *' do
  runner "RentMarketPrice.ryutetsunagareyamasen_chiba"
end
every '35 11 1 * *' do
  runner "RentMarketPrice.toyokosokutetsudo_chiba"
end
every '40 11 1 * *' do
  runner "RentMarketPrice.yukarigaokasen_chiba"
end
every '45 11 1 * *' do
  runner "RentMarketPrice.kominatotetsudosen_chiba"
end
every '50 11 1 * *' do
  runner "RentMarketPrice.choshidentetsu_chiba"
end
every '55 11 1 * *' do
  runner "RentMarketPrice.shibayamatetsudosen_chiba"
end
every '0 12 1 * *' do
  runner "RentMarketPrice.naritaskyaccess_chiba"
end
# 埼玉沿線
every '5 12 1 * *' do
  runner "RentMarketPrice.keihintohokusen_saitama"
end
every '10 12 1 * *' do
  runner "RentMarketPrice.saikyosen_saitama"
end
every '15 12 1 * *' do
  runner "RentMarketPrice.kawagoesen_saitama"
end
every '20 12 1 * *' do
  runner "RentMarketPrice.takasakisen_saitama"
end
every '25 12 1 * *' do
  runner "RentMarketPrice.utsunomiyasen_saitama"
end
every '30 12 1 * *' do
  runner "RentMarketPrice.musashinosen_saitama"
end
every '35 12 1 * *' do
  runner "RentMarketPrice.hachikosen_saitama"
end
every '40 12 1 * *' do
  runner "RentMarketPrice.shonanshinjukulineutsunomiyayokosukasen_saitama"
end
every '45 12 1 * *' do
  runner "RentMarketPrice.shonanshinjukulinetakasakitokaidosen_saitama"
end
every '50 12 1 * *' do
  runner "RentMarketPrice.yurakuchosen_saitama"
end
every '55 12 1 * *' do
  runner "RentMarketPrice.fukutoshinsen_saitama"
end
every '0 13 1 * *' do
  runner "RentMarketPrice.seibushinjukusen_saitama"
end
every '5 13 1 * *' do
  runner "RentMarketPrice.seibuikebukurosen_saitama"
end
every '10 13 1 * *' do
  runner "RentMarketPrice.seibusayamasen_saitama"
end
every '15 13 1 * *' do
  runner "RentMarketPrice.seibuyamaguchisen_saitama"
end
every '20 13 1 * *' do
  runner "RentMarketPrice.seibuchichibusen_saitama"
end
every '25 13 1 * *' do
  runner "RentMarketPrice.tobutojosen_saitama"
end
every '30 13 1 * *' do
  runner "RentMarketPrice.tobuogosesen_saitama"
end
every '35 13 1 * *' do
  runner "RentMarketPrice.tobuisesakisen_saitama"
end
every '40 13 1 * *' do
  runner "RentMarketPrice.tobunikkosen_saitama"
end
every '45 13 1 * *' do
  runner "RentMarketPrice.tobunodasen_saitama"
end
every '50 13 1 * *' do
  runner "RentMarketPrice.saitamakosokutetsudo_saitama"
end
every '55 13 1 * *' do
  runner "RentMarketPrice.tsukubaexpress_saitama"
end
every '0 14 1 * *' do
  runner "RentMarketPrice.saitamashintoshikotsuinasen_saitama"
end
every '5 14 1 * *' do
  runner "RentMarketPrice.chichibutetsudo_saitama"
end

# 実際に行うジョブの頻度や内容の指定
# every :wednesday, at: "9:00 am" do
#   runner "RentMarketPrice.get_station_infomation_tokyo_yamanotesen"
# end

# Learn more: http://github.com/javan/whenever
