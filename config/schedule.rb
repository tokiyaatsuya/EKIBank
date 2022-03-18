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
every :friday, at: "6:00 am" do
  runner "RentMarketPrice.yamanotesen_tokyo"
end
every :friday, at: "6:01 am" do
  runner "RentMarketPrice.keihintohokusen_tokyo"
end
every :friday, at: "6:02 am" do
  runner "RentMarketPrice.tokaidohonsen_tokyo"
end
every :friday, at: "6:03 am" do
  runner "RentMarketPrice.jobansen_tokyo"
end
every :friday, at: "6:04 am" do
  runner "RentMarketPrice.nambusen_tokyo"
end
every :friday, at: "6:05 am" do
  runner "RentMarketPrice.yokohamasen_tokyo"
end
every :friday, at: "6:06 am" do
  runner "RentMarketPrice.yokosukasen_tokyo"
end
every :friday, at: "6:07 am" do
  runner "RentMarketPrice.chuosen_tokyo"
end
every :friday, at: "6:08 am" do
  runner "RentMarketPrice.omesen_tokyo"
end
every :friday, at: "6:09 am" do
  runner "RentMarketPrice.itsukaichisen_tokyo"
end
every :friday, at: "6:10 am" do
  runner "RentMarketPrice.musashinosen_tokyo"
end
every :friday, at: "6:11 am" do
  runner "RentMarketPrice.hachikosen_tokyo"
end
every :friday, at: "6:12 am" do
  runner "RentMarketPrice.saikyosen_tokyo"
end
every :friday, at: "6:13 am" do
  runner "RentMarketPrice.takasakisen_tokyo"
end
every :friday, at: "6:14 am" do
  runner "RentMarketPrice.utsunomiyasen_tokyo"
end
every :friday, at: "6:15 am" do
  runner "RentMarketPrice.sobusen_tokyo"
end
every :friday, at: "6:16 am" do
  runner "RentMarketPrice.sobukaisokusen_tokyo"
end
every :friday, at: "6:17 am" do
  runner "RentMarketPrice.keiyosen_tokyo"
end
every :friday, at: "6:18 am" do
  runner "RentMarketPrice.shonanshinjukulineutsunomiyayokosukasen_tokyo"
end
every :friday, at: "6:19 am" do
  runner "RentMarketPrice.shonanshinjukulinetakasakitokaidosen_tokyo"
end
every :friday, at: "6:20 am" do
  runner "RentMarketPrice.ginzasen_tokyo"
end
every :friday, at: "6:21 am" do
  runner "RentMarketPrice.marunouchisen_tokyo"
end
every :friday, at: "6:22 am" do
  runner "RentMarketPrice.hibiyasen_tokyo"
end
every :friday, at: "6:23 am" do
  runner "RentMarketPrice.tozaisen_tokyo"
end
every :friday, at: "6:24 am" do
  runner "RentMarketPrice.chiyodasen_tokyo"
end
every :friday, at: "6:25 am" do
  runner "RentMarketPrice.yurakuchosen_tokyo"
end
every :friday, at: "6:26 am" do
  runner "RentMarketPrice.hanzomonsen_tokyo"
end
every :friday, at: "6:27 am" do
  runner "RentMarketPrice.nambokusen_tokyo"
end
every :friday, at: "6:28 am" do
  runner "RentMarketPrice.fukutoshinsen_tokyo"
end
every :friday, at: "6:29 am" do
  runner "RentMarketPrice.seibuyurakuchosen_tokyo"
end
every :friday, at: "6:30 am" do
  runner "RentMarketPrice.seibushinjukusen_tokyo"
end
every :friday, at: "6:31 am" do
  runner "RentMarketPrice.seibuikebukurosen_tokyo"
end
every :friday, at: "6:32 am" do
  runner "RentMarketPrice.seibuhaijimasen_tokyo"
end
every :friday, at: "6:33 am" do
  runner "RentMarketPrice.seibuyamaguchisen_tokyo"
end
every :friday, at: "6:34 am" do
  runner "RentMarketPrice.seibukokubunjisen_tokyo"
end
every :friday, at: "6:35 am" do
  runner "RentMarketPrice.seibutamagawasen_tokyo"
end
every :friday, at: "6:36 am" do
  runner "RentMarketPrice.seibutamakosen_tokyo"
end
every :friday, at: "6:37 am" do
  runner "RentMarketPrice.seibuseibuensen_tokyo"
end
every :friday, at: "6:38 am" do
  runner "RentMarketPrice.seibutoshimasen_tokyo"
end
every :friday, at: "6:39 am" do
  runner "RentMarketPrice.tobutojosen_tokyo"
end
every :friday, at: "6:40 am" do
  runner "RentMarketPrice.tobuisesakisen_tokyo"
end
every :friday, at: "6:41 am" do
  runner "RentMarketPrice.tobukameidosen_tokyo"
end
every :friday, at: "6:42 am" do
  runner "RentMarketPrice.tobudaishisen_tokyo"
end
every :friday, at: "6:43 am" do
  runner "RentMarketPrice.tokyutoyokosen_tokyo"
end
every :friday, at: "6:44 am" do
  runner "RentMarketPrice.tokyudenentoshisen_tokyo"
end
every :friday, at: "6:45 am" do
  runner "RentMarketPrice.tokyuikegamisen_tokyo"
end
every :friday, at: "6:46 am" do
  runner "RentMarketPrice.tokyumegurosen_tokyo"
end
every :friday, at: "6:47 am" do
  runner "RentMarketPrice.tokyutamagawasen_tokyo"
end
every :friday, at: "6:48 am" do
  runner "RentMarketPrice.tokyuoimachisen_tokyo"
end
every :friday, at: "6:49 am" do
  runner "RentMarketPrice.tokyusetagayasen_tokyo"
end
every :friday, at: "6:50 am" do
  runner "RentMarketPrice.toeiasakusasen_tokyo"
end
every :friday, at: "6:51 am" do
  runner "RentMarketPrice.toeimitasen_tokyo"
end
every :friday, at: "6:52 am" do
  runner "RentMarketPrice.toeishinjukusen_tokyo"
end
every :friday, at: "6:53 am" do
  runner "RentMarketPrice.toeioedosen_tokyo"
end
every :friday, at: "6:54 am" do
  runner "RentMarketPrice.todenarakawasen_tokyo"
end
every :friday, at: "6:55 am" do
  runner "RentMarketPrice.nipporitoneriliner_tokyo"
end
every :friday, at: "6:56 am" do
  runner "RentMarketPrice.keioinokashirasen_tokyo"
end
every :friday, at: "6:57 am" do
  runner "RentMarketPrice.keiokeibajosen_tokyo"
end
every :friday, at: "6:58 am" do
  runner "RentMarketPrice.keioshinsen_tokyo"
end
every :friday, at: "6:59 am" do
  runner "RentMarketPrice.keiosen_tokyo"
end
every :friday, at: "7:00 am" do
  runner "RentMarketPrice.keiodobutsuensen_tokyo"
end
every :friday, at: "7:01 am" do
  runner "RentMarketPrice.keiosagamiharasen_tokyo"
end
every :friday, at: "7:02 am" do
  runner "RentMarketPrice.keiotakaosen_tokyo"
end
every :friday, at: "7:03 am" do
  runner "RentMarketPrice.keiseioshiagesen_tokyo"
end
every :friday, at: "7:04 am" do
  runner "RentMarketPrice.keiseikanamachisen_tokyo"
end
every :friday, at: "7:05 am" do
  runner "RentMarketPrice.keiseihonsen_tokyo"
end
every :friday, at: "7:06 am" do
  runner "RentMarketPrice.keikyuhonsen_tokyo"
end
every :friday, at: "7:07 am" do
  runner "RentMarketPrice.keikyukukosen_tokyo"
end
every :friday, at: "7:08 am" do
  runner "RentMarketPrice.odakyusen_tokyo"
end
every :friday, at: "7:09 am" do
  runner "RentMarketPrice.odakyutamasen_tokyo"
end
every :friday, at: "7:10 am" do
  runner "RentMarketPrice.tamatoshimonorail_tokyo"
end
every :friday, at: "7:11 am" do
  runner "RentMarketPrice.rinkaisen_tokyo"
end
every :friday, at: "7:12 am" do
  runner "RentMarketPrice.hokusosen_tokyo"
end
every :friday, at: "7:13 am" do
  runner "RentMarketPrice.tokyomonorail_tokyo"
end
every :friday, at: "7:14 am" do
  runner "RentMarketPrice.shinkotsuyurikamome_tokyo"
end
every :friday, at: "7:15 am" do
  runner "RentMarketPrice.saitamakosokutetsudo_tokyo"
end
every :friday, at: "7:16 am" do
  runner "RentMarketPrice.tsukubaexpress_tokyo"
end
every :friday, at: "7:17 am" do
  runner "RentMarketPrice.naritaskyaccess_tokyo"
end
# 神奈川沿線
every :friday, at: "7:18 am" do
  runner "RentMarketPrice.tokyuoimachisen_kanagawa"
end
every :friday, at: "7:19 am" do
  runner "RentMarketPrice.tokyutoyokosen_kanagawa"
end
every :friday, at: "7:20 am" do
  runner "RentMarketPrice.tokyudenentoshisen_kanagawa"
end
every :friday, at: "7:21 am" do
  runner "RentMarketPrice.tokyukodomonokunisen_kanagawa"
end
every :friday, at: "7:22 am" do
  runner "RentMarketPrice.tokyumegurosen_kanagawa"
end
every :friday, at: "7:23 am" do
  runner "RentMarketPrice.yokosukasen_kanagawa"
end
every :friday, at: "7:24 am" do
  runner "RentMarketPrice.keihintohokusen_kanagawa"
end
every :friday, at: "7:25 am" do
  runner "RentMarketPrice.negishisen_kanagawa"
end
every :friday, at: "7:26 am" do
  runner "RentMarketPrice.tsurumisen_kanagawa"
end
every :friday, at: "7:27 am" do
  runner "RentMarketPrice.tokaidohonsen_kanagawa"
end
every :friday, at: "7:28 am" do
  runner "RentMarketPrice.gotembasen_kanagawa"
end
every :friday, at: "7:29 am" do
  runner "RentMarketPrice.nambusen_kanagawa"
end
every :friday, at: "7:30 am" do
  runner "RentMarketPrice.yokohamasen_kanagawa"
end
every :friday, at: "7:31 am" do
  runner "RentMarketPrice.sagamisen_kanagawa"
end
every :friday, at: "7:32 am" do
  runner "RentMarketPrice.chuosen_kanagawa"
end
every :friday, at: "7:33 am" do
  runner "RentMarketPrice.shonanshinjukulineutsunomiyayokosukasen_kanagawa"
end
every :friday, at: "7:34 am" do
  runner "RentMarketPrice.shonanshinjukulinetakasakitokaidosen_kanagawa"
end
every :friday, at: "7:35 am" do
  runner "RentMarketPrice.keiosagamiharasen_kanagawa"
end
every :friday, at: "7:36 am" do
  runner "RentMarketPrice.keikyuhonsen_kanagawa"
end
every :friday, at: "7:37 am" do
  runner "RentMarketPrice.keikyudaishisen_kanagawa"
end
every :friday, at: "7:38 am" do
  runner "RentMarketPrice.keikyuzushisen_kanagawa"
end
every :friday, at: "7:39 am" do
  runner "RentMarketPrice.keikyukurihamasen_kanagawa"
end
every :friday, at: "7:40 am" do
  runner "RentMarketPrice.odakyusen_kanagawa"
end
every :friday, at: "7:41 am" do
  runner "RentMarketPrice.odakyuodawarasen_kanagawa"
end
every :friday, at: "7:42 am" do
  runner "RentMarketPrice.odakyutamasen_kanagawa"
end
every :friday, at: "7:43 am" do
  runner "RentMarketPrice.odakyuenoshimasen_kanagawa"
end
every :friday, at: "7:44 am" do
  runner "RentMarketPrice.sotetsuhonsen_kanagawa"
end
every :friday, at: "7:45 am" do
  runner "RentMarketPrice.sotetsuizuminosen_kanagawa"
end
every :friday, at: "7:46 am" do
  runner "RentMarketPrice.sotetsushinyokohamasen_kanagawa"
end
every :friday, at: "7:47 am" do
  runner "RentMarketPrice.blueline_kanagawa"
end
every :friday, at: "7:48 am" do
  runner "RentMarketPrice.greenline_kanagawa"
end
every :friday, at: "7:49 am" do
  runner "RentMarketPrice.minatomiraisen_kanagawa"
end
every :friday, at: "7:50 am" do
  runner "RentMarketPrice.seasideline_kanagawa"
end
every :friday, at: "7:51 am" do
  runner "RentMarketPrice.enoshimadentetsu_kanagawa"
end
every :friday, at: "7:52 am" do
  runner "RentMarketPrice.shonanmonorail_kanagawa"
end
every :friday, at: "7:53 am" do
  runner "RentMarketPrice.hakonetozantetsudo_kanagawa"
end
every :friday, at: "7:54 am" do
  runner "RentMarketPrice.hakonetozancablesen_kanagawa"
end
every :friday, at: "7:55 am" do
  runner "RentMarketPrice.izuhakonedaiyuzansen_kanagawa"
end
# 千葉沿線
every :friday, at: "7:56 am" do
  runner "RentMarketPrice.sobusen_chiba"
end
every :friday, at: "7:57 am" do
  runner "RentMarketPrice.jobansen_chiba"
end
every :friday, at: "7:58 am" do
  runner "RentMarketPrice.naritasen_chiba"
end
every :friday, at: "7:59 am" do
  runner "RentMarketPrice.musashinosen_chiba"
end
every :friday, at: "8:00 am" do
  runner "RentMarketPrice.sobukaisokusen_chiba"
end
every :friday, at: "8:01 am" do
  runner "RentMarketPrice.sobuhonsen_chiba"
end
every :friday, at: "8:02 am" do
  runner "RentMarketPrice.keiyosen_chiba"
end
every :friday, at: "8:03 am" do
  runner "RentMarketPrice.kashimasen_chiba"
end
every :friday, at: "8:04 am" do
  runner "RentMarketPrice.sotobosen_chiba"
end
every :friday, at: "8:05 am" do
  runner "RentMarketPrice.toganesen_chiba"
end
every :friday, at: "8:06 am" do
  runner "RentMarketPrice.uchibosen_chiba"
end
every :friday, at: "8:07 am" do
  runner "RentMarketPrice.kururisen_chiba"
end
every :friday, at: "8:08 am" do
  runner "RentMarketPrice.tozaisen_chiba"
end
every :friday, at: "8:09 am" do
  runner "RentMarketPrice.toeishinjukusen_chiba"
end
every :friday, at: "8:10 am" do
  runner "RentMarketPrice.keiseihonsen_chiba"
end
every :friday, at: "8:11 am" do
  runner "RentMarketPrice.keiseichibasen_chiba"
end
every :friday, at: "8:12 am" do
  runner "RentMarketPrice.keiseichiharasen_chiba"
end
every :friday, at: "8:13 am" do
  runner "RentMarketPrice.shinkeiseisen_chiba"
end
every :friday, at: "8:14 am" do
  runner "RentMarketPrice.tobunodasen_chiba"
end
every :friday, at: "8:15 am" do
  runner "RentMarketPrice.hokusosen_chiba"
end
every :friday, at: "8:16 am" do
  runner "RentMarketPrice.tsukubaexpress_chiba"
end
every :friday, at: "8:17 am" do
  runner "RentMarketPrice.chibatoshimonorail_chiba"
end
every :friday, at: "8:18 am" do
  runner "RentMarketPrice.ryutetsunagareyamasen_chiba"
end
every :friday, at: "8:19 am" do
  runner "RentMarketPrice.toyokosokutetsudo_chiba"
end
every :friday, at: "8:20 am" do
  runner "RentMarketPrice.yukarigaokasen_chiba"
end
every :friday, at: "8:21 am" do
  runner "RentMarketPrice.kominatotetsudosen_chiba"
end
every :friday, at: "8:22 am" do
  runner "RentMarketPrice.choshidentetsu_chiba"
end
every :friday, at: "8:23 am" do
  runner "RentMarketPrice.shibayamatetsudosen_chiba"
end
every :friday, at: "8:24 am" do
  runner "RentMarketPrice.naritaskyaccess_chiba"
end
# 埼玉沿線
every :friday, at: "8:25 am" do
  runner "RentMarketPrice.keihintohokusen_saitama"
end
every :friday, at: "8:26 am" do
  runner "RentMarketPrice.saikyosen_saitama"
end
every :friday, at: "8:27 am" do
  runner "RentMarketPrice.kawagoesen_saitama"
end
every :friday, at: "8:28 am" do
  runner "RentMarketPrice.takasakisen_saitama"
end
every :friday, at: "8:29 am" do
  runner "RentMarketPrice.utsunomiyasen_saitama"
end
every :friday, at: "8:30 am" do
  runner "RentMarketPrice.musashinosen_saitama"
end
every :friday, at: "8:31 am" do
  runner "RentMarketPrice.hachikosen_saitama"
end
every :friday, at: "8:32 am" do
  runner "RentMarketPrice.shonanshinjukulineutsunomiyayokosukasen_saitama"
end
every :friday, at: "8:33 am" do
  runner "RentMarketPrice.shonanshinjukulinetakasakitokaidosen_saitama"
end
every :friday, at: "8:34 am" do
  runner "RentMarketPrice.yurakuchosen_saitama"
end
every :friday, at: "8:35 am" do
  runner "RentMarketPrice.fukutoshinsen_saitama"
end
every :friday, at: "8:36 am" do
  runner "RentMarketPrice.seibushinjukusen_saitama"
end
every :friday, at: "8:37 am" do
  runner "RentMarketPrice.seibuikebukurosen_saitama"
end
every :friday, at: "8:38 am" do
  runner "RentMarketPrice.seibusayamasen_saitama"
end
every :friday, at: "8:39 am" do
  runner "RentMarketPrice.seibuyamaguchisen_saitama"
end
every :friday, at: "8:40 am" do
  runner "RentMarketPrice.seibuchichibusen_saitama"
end
every :friday, at: "8:41 am" do
  runner "RentMarketPrice.tobutojosen_saitama"
end
every :friday, at: "8:42 am" do
  runner "RentMarketPrice.tobuogosesen_saitama"
end
every :friday, at: "8:43 am" do
  runner "RentMarketPrice.tobuisesakisen_saitama"
end
every :friday, at: "8:44 am" do
  runner "RentMarketPrice.tobunikkosen_saitama"
end
every :friday, at: "8:45 am" do
  runner "RentMarketPrice.tobunodasen_saitama"
end
every :friday, at: "8:46 am" do
  runner "RentMarketPrice.saitamakosokutetsudo_saitama"
end
every :friday, at: "8:47 am" do
  runner "RentMarketPrice.tsukubaexpress_saitama"
end
every :friday, at: "8:48 am" do
  runner "RentMarketPrice.saitamashintoshikotsuinasen_saitama"
end
every :friday, at: "8:49 am" do
  runner "RentMarketPrice.chichibutetsudo_saitama"
end

# 実際に行うジョブの頻度や内容の指定
# every :wednesday, at: "9:00 am" do
#   runner "RentMarketPrice.get_station_infomation_tokyo_yamanotesen"
# end

# Learn more: http://github.com/javan/whenever
