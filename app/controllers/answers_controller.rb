class AnswersController < ApplicationController
  def show
    # answersのviewへ渡すようにquestions_controllerで作成したセッションパラメーターをインスタンス変数に格納する
    @rent_budget = session[:rent_budget]
    @floor_plan = session[:floor_plan]
    @prefecture_to_live = session[:prefecture_to_live]
    @station_atmosphere = session[:station_atmosphere]
    @gym = session[:gym]
    @starbucks_coffee = session[:starbucks_coffee]
    @mcdonalds = session[:mcdonalds]
    @ohsho = session[:ohsho]
    @tabelog = session[:tabelog]
    @supermarket = session[:supermarket]
    @large_park = session[:large_park]
    @library = session[:library]
    @spa = session[:spa]
    # show_4の住みたいエリアの入力から条件分岐でスクレイピングのメソッドを始動する
    # 格納した値をmodelへ渡す為にグローバル変数を設定
    $destination_1 = session[:destination_1]
    $transit_time_1 = session[:transit_time_1]
    $destination_2 = session[:destination_2]
    $transit_time_2 = session[:transit_time_2]
    # show_4の回答が終わりshow_5へ遷移したタイミングでスクレイピングのメソッドを呼び出す
    # session[:prefecture_to_live]に格納されている都県の値によって呼び出すメソッドを変える
    if session[:prefecture_to_live] == '東京都' #東京都のバリュー
      RentMarketPrice.search_destination_transit_time_tokyo
    elsif session[:prefecture_to_live] == '神奈川県' #神奈川県のバリュー
      RentMarketPrice.search_destination_transit_time_kanagawa
    elsif session[:prefecture_to_live] == '埼玉県' #埼玉県のバリュー
      RentMarketPrice.search_destination_transit_time_saitama
    elsif session[:prefecture_to_live] == '千葉県' #千葉県のバリュー
      RentMarketPrice.search_destination_transit_time_chiba
    end
  end
end
