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
# 東京沿線
every :saturday, at: "0:00 am" do
  runner "RentMarketPrice.yamanotesen_tokyo"
end
every :saturday, at: "0:05 am" do
  runner "RentMarketPrice.keihintohokusen_tokyo"
end
every :saturday, at: "0:10 am" do
  runner "RentMarketPrice.tokaidohonsen_tokyo"
end
every :saturday, at: "0:15 am" do
  runner "RentMarketPrice.jobansen_tokyo"
end
every :saturday, at: "0:20 am" do
  runner "RentMarketPrice.nambusen_tokyo"
end
every :saturday, at: "0:25 am" do
  runner "RentMarketPrice.yokohamasen_tokyo"
end
every :saturday, at: "0:30 am" do
  runner "RentMarketPrice.yokosukasen_tokyo"
end
every :saturday, at: "0:35 am" do
  runner "RentMarketPrice.chuosen_tokyo"
end
every :saturday, at: "0:40 am" do
  runner "RentMarketPrice.omesen_tokyo"
end
every :saturday, at: "0:45 am" do
  runner "RentMarketPrice.itsukaichisen_tokyo"
end
every :saturday, at: "0:50 am" do
  runner "RentMarketPrice.musashinosen_tokyo"
end
every :saturday, at: "0:55 am" do
  runner "RentMarketPrice.hachikosen_tokyo"
end
every :saturday, at: "1:00 am" do
  runner "RentMarketPrice.saikyosen_tokyo"
end
every :saturday, at: "1:05 am" do
  runner "RentMarketPrice.takasakisen_tokyo"
end
every :saturday, at: "1:10 am" do
  runner "RentMarketPrice.utsunomiyasen_tokyo"
end
every :saturday, at: "1:15 am" do
  runner "RentMarketPrice.sobusen_tokyo"
end
every :saturday, at: "1:20 am" do
  runner "RentMarketPrice.sobukaisokusen_tokyo"
end
every :saturday, at: "1:25 am" do
  runner "RentMarketPrice.keiyosen_tokyo"
end
every :saturday, at: "1:30 am" do
  runner "RentMarketPrice.shonanshinjukulineutsunomiyayokosukasen_tokyo"
end
every :saturday, at: "1:35 am" do
  runner "RentMarketPrice.shonanshinjukulinetakasakitokaidosen_tokyo"
end
every :saturday, at: "1:40 am" do
  runner "RentMarketPrice.ginzasen_tokyo"
end
every :saturday, at: "1:45 am" do
  runner "RentMarketPrice.marunouchisen_tokyo"
end
every :saturday, at: "1:50 am" do
  runner "RentMarketPrice.hibiyasen_tokyo"
end
every :saturday, at: "1:55 am" do
  runner "RentMarketPrice.tozaisen_tokyo"
end
every :saturday, at: "2:00 am" do
  runner "RentMarketPrice.chiyodasen_tokyo"
end
every :saturday, at: "2:05 am" do
  runner "RentMarketPrice.yurakuchosen_tokyo"
end
every :saturday, at: "2:10 am" do
  runner "RentMarketPrice.hanzomonsen_tokyo"
end
every :saturday, at: "2:15 am" do
  runner "RentMarketPrice.nambokusen_tokyo"
end
every :saturday, at: "2:20 am" do
  runner "RentMarketPrice.fukutoshinsen_tokyo"
end
every :saturday, at: "2:25 am" do
  runner "RentMarketPrice.seibuyurakuchosen_tokyo"
end
every :saturday, at: "2:30 am" do
  runner "RentMarketPrice.seibushinjukusen_tokyo"
end
every :saturday, at: "2:35 am" do
  runner "RentMarketPrice.seibuikebukurosen_tokyo"
end
every :saturday, at: "2:40 am" do
  runner "RentMarketPrice.seibuhaijimasen_tokyo"
end
every :saturday, at: "2:45 am" do
  runner "RentMarketPrice.seibuyamaguchisen_tokyo"
end
every :saturday, at: "2:50 am" do
  runner "RentMarketPrice.seibukokubunjisen_tokyo"
end
every :saturday, at: "2:55 am" do
  runner "RentMarketPrice.seibutamagawasen_tokyo"
end
every :saturday, at: "3:00 am" do
  runner "RentMarketPrice.seibutamakosen_tokyo"
end
every :saturday, at: "3:05 am" do
  runner "RentMarketPrice.seibuseibuensen_tokyo"
end
every :saturday, at: "3:10 am" do
  runner "RentMarketPrice.seibutoshimasen_tokyo"
end
every :saturday, at: "3:15 am" do
  runner "RentMarketPrice.tobutojosen_tokyo"
end
every :saturday, at: "3:20 am" do
  runner "RentMarketPrice.tobuisesakisen_tokyo"
end
every :saturday, at: "3:25 am" do
  runner "RentMarketPrice.tobukameidosen_tokyo"
end
every :saturday, at: "3:30 am" do
  runner "RentMarketPrice.tobudaishisen_tokyo"
end
every :saturday, at: "3:35 am" do
  runner "RentMarketPrice.tokyutoyokosen_tokyo"
end
every :saturday, at: "3:40 am" do
  runner "RentMarketPrice.tokyudenentoshisen_tokyo"
end
every :saturday, at: "3:45 am" do
  runner "RentMarketPrice.tokyuikegamisen_tokyo"
end
every :saturday, at: "3:50 am" do
  runner "RentMarketPrice.tokyumegurosen_tokyo"
end
every :saturday, at: "3:55 am" do
  runner "RentMarketPrice.tokyutamagawasen_tokyo"
end
every :saturday, at: "4:00 am" do
  runner "RentMarketPrice.tokyuoimachisen_tokyo"
end
every :saturday, at: "4:05 am" do
  runner "RentMarketPrice.tokyusetagayasen_tokyo"
end
every :saturday, at: "4:10 am" do
  runner "RentMarketPrice.toeiasakusasen_tokyo"
end
every :saturday, at: "4:15 am" do
  runner "RentMarketPrice.toeimitasen_tokyo"
end
every :saturday, at: "4:20 am" do
  runner "RentMarketPrice.toeishinjukusen_tokyo"
end
every :saturday, at: "4:25 am" do
  runner "RentMarketPrice.toeioedosen_tokyo"
end
every :saturday, at: "4:30 am" do
  runner "RentMarketPrice.todenarakawasen_tokyo"
end
every :saturday, at: "4:35 am" do
  runner "RentMarketPrice.nipporitoneriliner_tokyo"
end
every :saturday, at: "4:40 am" do
  runner "RentMarketPrice.keioinokashirasen_tokyo"
end
every :saturday, at: "4:45 am" do
  runner "RentMarketPrice.keiokeibajosen_tokyo"
end
every :saturday, at: "4:50 am" do
  runner "RentMarketPrice.keioshinsen_tokyo"
end
every :saturday, at: "4:55 am" do
  runner "RentMarketPrice.keiosen_tokyo"
end
every :saturday, at: "5:00 am" do
  runner "RentMarketPrice.keiodobutsuensen_tokyo"
end
every :saturday, at: "5:05 am" do
  runner "RentMarketPrice.keiosagamiharasen_tokyo"
end
every :saturday, at: "5:10 am" do
  runner "RentMarketPrice.keiotakaosen_tokyo"
end
every :saturday, at: "5:15 am" do
  runner "RentMarketPrice.keiseioshiagesen_tokyo"
end
every :saturday, at: "5:20 am" do
  runner "RentMarketPrice.keiseikanamachisen_tokyo"
end
every :saturday, at: "5:25 am" do
  runner "RentMarketPrice.keiseihonsen_tokyo"
end
every :saturday, at: "5:30 am" do
  runner "RentMarketPrice.keikyuhonsen_tokyo"
end
every :saturday, at: "5:35 am" do
  runner "RentMarketPrice.keikyukukosen_tokyo"
end
every :saturday, at: "5:40 am" do
  runner "RentMarketPrice.odakyusen_tokyo"
end
every :saturday, at: "5:45 am" do
  runner "RentMarketPrice.odakyutamasen_tokyo"
end
every :saturday, at: "5:50 am" do
  runner "RentMarketPrice.tamatoshimonorail_tokyo"
end
every :saturday, at: "5:55 am" do
  runner "RentMarketPrice.rinkaisen_tokyo"
end
every :saturday, at: "6:00 am" do
  runner "RentMarketPrice.hokusosen_tokyo"
end
every :saturday, at: "6:05 am" do
  runner "RentMarketPrice.tokyomonorail_tokyo"
end
every :saturday, at: "6:10 am" do
  runner "RentMarketPrice.shinkotsuyurikamome_tokyo"
end
every :saturday, at: "6:15 am" do
  runner "RentMarketPrice.saitamakosokutetsudo_tokyo"
end
every :saturday, at: "6:20 am" do
  runner "RentMarketPrice.tsukubaexpress_tokyo"
end
every :saturday, at: "6:25 am" do
  runner "RentMarketPrice.naritaskyaccess_tokyo"
end
# 神奈川沿線
every :saturday, at: "6:30 am" do
  runner "RentMarketPrice.tokyuoimachisen_kanagawa"
end
every :saturday, at: "6:35 am" do
  runner "RentMarketPrice.tokyutoyokosen_kanagawa"
end
every :saturday, at: "6:40 am" do
  runner "RentMarketPrice.tokyudenentoshisen_kanagawa"
end
every :saturday, at: "6:45 am" do
  runner "RentMarketPrice.tokyukodomonokunisen_kanagawa"
end
every :saturday, at: "6:50 am" do
  runner "RentMarketPrice.tokyumegurosen_kanagawa"
end
every :saturday, at: "6:55 am" do
  runner "RentMarketPrice.yokosukasen_kanagawa"
end
every :saturday, at: "7:00 am" do
  runner "RentMarketPrice.keihintohokusen_kanagawa"
end
every :saturday, at: "7:05 am" do
  runner "RentMarketPrice.negishisen_kanagawa"
end
every :saturday, at: "7:10 am" do
  runner "RentMarketPrice.tsurumisen_kanagawa"
end
every :saturday, at: "7:15 am" do
  runner "RentMarketPrice.tokaidohonsen_kanagawa"
end
every :saturday, at: "7:20 am" do
  runner "RentMarketPrice.gotembasen_kanagawa"
end
every :saturday, at: "7:25 am" do
  runner "RentMarketPrice.nambusen_kanagawa"
end
every :saturday, at: "7:30 am" do
  runner "RentMarketPrice.yokohamasen_kanagawa"
end
every :saturday, at: "7:35 am" do
  runner "RentMarketPrice.sagamisen_kanagawa"
end
every :saturday, at: "7:40 am" do
  runner "RentMarketPrice.chuosen_kanagawa"
end
every :saturday, at: "7:45 am" do
  runner "RentMarketPrice.shonanshinjukulineutsunomiyayokosukasen_kanagawa"
end
every :saturday, at: "7:50 am" do
  runner "RentMarketPrice.shonanshinjukulinetakasakitokaidosen_kanagawa"
end
every :saturday, at: "7:55 am" do
  runner "RentMarketPrice.keiosagamiharasen_kanagawa"
end
every :saturday, at: "8:00 am" do
  runner "RentMarketPrice.keikyuhonsen_kanagawa"
end
every :saturday, at: "8:05 am" do
  runner "RentMarketPrice.keikyudaishisen_kanagawa"
end
every :saturday, at: "8:10 am" do
  runner "RentMarketPrice.keikyuzushisen_kanagawa"
end
every :saturday, at: "8:15 am" do
  runner "RentMarketPrice.keikyukurihamasen_kanagawa"
end
every :saturday, at: "8:20 am" do
  runner "RentMarketPrice.odakyusen_kanagawa"
end
every :saturday, at: "8:25 am" do
  runner "RentMarketPrice.odakyuodawarasen_kanagawa"
end
every :saturday, at: "8:30 am" do
  runner "RentMarketPrice.odakyutamasen_kanagawa"
end
every :saturday, at: "8:35 am" do
  runner "RentMarketPrice.odakyuenoshimasen_kanagawa"
end
every :saturday, at: "8:40 am" do
  runner "RentMarketPrice.sotetsuhonsen_kanagawa"
end
every :saturday, at: "8:45 am" do
  runner "RentMarketPrice.sotetsuizuminosen_kanagawa"
end
every :saturday, at: "8:50 am" do
  runner "RentMarketPrice.sotetsushinyokohamasen_kanagawa"
end
every :saturday, at: "8:55 am" do
  runner "RentMarketPrice.blueline_kanagawa"
end
every :saturday, at: "9:00 am" do
  runner "RentMarketPrice.greenline_kanagawa"
end
every :saturday, at: "9:05 am" do
  runner "RentMarketPrice.minatomiraisen_kanagawa"
end
every :saturday, at: "9:10 am" do
  runner "RentMarketPrice.seasideline_kanagawa"
end
every :saturday, at: "9:15 am" do
  runner "RentMarketPrice.enoshimadentetsu_kanagawa"
end
every :saturday, at: "9:20 am" do
  runner "RentMarketPrice.shonanmonorail_kanagawa"
end
every :saturday, at: "9:25 am" do
  runner "RentMarketPrice.hakonetozantetsudo_kanagawa"
end
every :saturday, at: "9:30 am" do
  runner "RentMarketPrice.hakonetozancablesen_kanagawa"
end
every :saturday, at: "9:35 am" do
  runner "RentMarketPrice.izuhakonedaiyuzansen_kanagawa"
end
# 千葉沿線
every :saturday, at: "9:40 am" do
  runner "RentMarketPrice.sobusen_chiba"
end
every :saturday, at: "9:45 am" do
  runner "RentMarketPrice.jobansen_chiba"
end
every :saturday, at: "9:50 am" do
  runner "RentMarketPrice.naritasen_chiba"
end
every :saturday, at: "9:55 am" do
  runner "RentMarketPrice.musashinosen_chiba"
end
every :saturday, at: "10:00 am" do
  runner "RentMarketPrice.sobukaisokusen_chiba"
end
every :saturday, at: "10:05 am" do
  runner "RentMarketPrice.sobuhonsen_chiba"
end
every :saturday, at: "10:10 am" do
  runner "RentMarketPrice.keiyosen_chiba"
end
every :saturday, at: "10:15 am" do
  runner "RentMarketPrice.kashimasen_chiba"
end
every :saturday, at: "10:20 am" do
  runner "RentMarketPrice.sotobosen_chiba"
end
every :saturday, at: "10:25 am" do
  runner "RentMarketPrice.toganesen_chiba"
end
every :saturday, at: "10:30 am" do
  runner "RentMarketPrice.uchibosen_chiba"
end
every :saturday, at: "10:35 am" do
  runner "RentMarketPrice.kururisen_chiba"
end
every :saturday, at: "10:40 am" do
  runner "RentMarketPrice.tozaisen_chiba"
end
every :saturday, at: "10:45 am" do
  runner "RentMarketPrice.toeishinjukusen_chiba"
end
every :saturday, at: "10:50 am" do
  runner "RentMarketPrice.keiseihonsen_chiba"
end
every :saturday, at: "10:55 am" do
  runner "RentMarketPrice.keiseichibasen_chiba"
end
every :saturday, at: "11:00 am" do
  runner "RentMarketPrice.keiseichiharasen_chiba"
end
every :saturday, at: "11:05 am" do
  runner "RentMarketPrice.shinkeiseisen_chiba"
end
every :saturday, at: "11:10 am" do
  runner "RentMarketPrice.tobunodasen_chiba"
end
every :saturday, at: "11:15 am" do
  runner "RentMarketPrice.hokusosen_chiba"
end
every :saturday, at: "11:20 am" do
  runner "RentMarketPrice.tsukubaexpress_chiba"
end
every :saturday, at: "11:25 am" do
  runner "RentMarketPrice.chibatoshimonorail_chiba"
end
every :saturday, at: "11:30 am" do
  runner "RentMarketPrice.ryutetsunagareyamasen_chiba"
end
every :saturday, at: "11:35 am" do
  runner "RentMarketPrice.toyokosokutetsudo_chiba"
end
every :saturday, at: "11:40 am" do
  runner "RentMarketPrice.yukarigaokasen_chiba"
end
every :saturday, at: "11:45 am" do
  runner "RentMarketPrice.kominatotetsudosen_chiba"
end
every :saturday, at: "11:50 am" do
  runner "RentMarketPrice.choshidentetsu_chiba"
end
every :saturday, at: "11:55 am" do
  runner "RentMarketPrice.shibayamatetsudosen_chiba"
end
every :saturday, at: "0:00 pm" do
  runner "RentMarketPrice.naritaskyaccess_chiba"
end
# 埼玉沿線
every :saturday, at: "0:05 pm" do
  runner "RentMarketPrice.keihintohokusen_saitama"
end
every :saturday, at: "0:10 pm" do
  runner "RentMarketPrice.saikyosen_saitama"
end
every :saturday, at: "0:15 pm" do
  runner "RentMarketPrice.kawagoesen_saitama"
end
every :saturday, at: "0:20 pm" do
  runner "RentMarketPrice.takasakisen_saitama"
end
every :saturday, at: "0:25 pm" do
  runner "RentMarketPrice.utsunomiyasen_saitama"
end
every :saturday, at: "0:30 pm" do
  runner "RentMarketPrice.musashinosen_saitama"
end
every :saturday, at: "0:35 pm" do
  runner "RentMarketPrice.hachikosen_saitama"
end
every :saturday, at: "0:40 pm" do
  runner "RentMarketPrice.shonanshinjukulineutsunomiyayokosukasen_saitama"
end
every :saturday, at: "0:45 pm" do
  runner "RentMarketPrice.shonanshinjukulinetakasakitokaidosen_saitama"
end
every :saturday, at: "0:50 pm" do
  runner "RentMarketPrice.yurakuchosen_saitama"
end
every :saturday, at: "0:55 pm" do
  runner "RentMarketPrice.fukutoshinsen_saitama"
end
every :saturday, at: "1:00 pm" do
  runner "RentMarketPrice.seibushinjukusen_saitama"
end
every :saturday, at: "1:05 pm" do
  runner "RentMarketPrice.seibuikebukurosen_saitama"
end
every :saturday, at: "1:10 pm" do
  runner "RentMarketPrice.seibusayamasen_saitama"
end
every :saturday, at: "1:15 pm" do
  runner "RentMarketPrice.seibuyamaguchisen_saitama"
end
every :saturday, at: "1:20 pm" do
  runner "RentMarketPrice.seibuchichibusen_saitama"
end
every :saturday, at: "1:25 pm" do
  runner "RentMarketPrice.tobutojosen_saitama"
end
every :saturday, at: "1:30 pm" do
  runner "RentMarketPrice.tobuogosesen_saitama"
end
every :saturday, at: "1:35 pm" do
  runner "RentMarketPrice.tobuisesakisen_saitama"
end
every :saturday, at: "1:40 pm" do
  runner "RentMarketPrice.tobunikkosen_saitama"
end
every :saturday, at: "1:45 pm" do
  runner "RentMarketPrice.tobunodasen_saitama"
end
every :saturday, at: "1:50 pm" do
  runner "RentMarketPrice.saitamakosokutetsudo_saitama"
end
every :saturday, at: "1:55 pm" do
  runner "RentMarketPrice.tsukubaexpress_saitama"
end
every :saturday, at: "2:00 pm" do
  runner "RentMarketPrice.saitamashintoshikotsuinasen_saitama"
end
every :saturday, at: "2:05 pm" do
  runner "RentMarketPrice.chichibutetsudo_saitama"
end

# 実際に行うジョブの頻度や内容の指定
# every :wednesday, at: "9:00 am" do
#   runner "RentMarketPrice.get_station_infomation_tokyo_yamanotesen"
# end

# Learn more: http://github.com/javan/whenever
