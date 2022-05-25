class QuestionsController < ApplicationController
  # 質問画面Q1の表示メソッド
  def show_1
    # questionsテーブルからid:1,2,3,18を取得(18は追加項目なので飛び番号)
    # id:1 = 家賃の予算は?
    # id:2 = 購入する不動産の種別は？ 
    # id:3 = 購入する不動産の予算は？
    # id:18 = 希望する間取りは？
    @questions = Question.find(1,2,3,18)
    # answersテーブルからquestion_id:1,2,3,18に紐付く選択肢を取得(18は追加項目なので飛び番号)
    @answers_1 = Answer.where(question_id: Q_01)
    @answers_2 = Answer.where(question_id: Q_02)
    @answers_3 = Answer.where(question_id: Q_03)
    @answers_18 = Answer.where(question_id: Q_18)
  end
  # 質問画面Q2の表示メソッド
  def show_2
    # questionsテーブルからid:4,5を取得
    # id:4 = 通勤通学の目的地の最寄駅は？
    # id:5 = 通勤通学時の移動時間は?
    @questions = Question.find(4,5)
    # answersテーブルからquestion_id:5に紐付く選択肢を取得、id:4は入力フォーム設置
    @answers_5 = Answer.where(question_id: Q_05)
    session[:rent_budget] = answer_params[:rent_budget]
    session[:floor_plan] = answer_params[:floor_plan]
    # URL直打ち防止と質問画面を順番に遷移させるためにsessionの空判定とリダイレクト先を指定
    if session[:rent_budget].blank? || session[:floor_plan].blank?
      redirect_to action: :show_1
    end
  end
  # 質問画面Q3の表示メソッド
  def show_3
    # questionsテーブルからid:6,7を取得
    # id:6 = 趣味等でよく行く場所の最寄駅は？
    # id:7 = 趣味等でよく行く場所への移動時間は？
    @questions = Question.find(6,7)
    # answersテーブルからquestion_id:7に紐付く選択肢を取得、id:6は入力フォーム設置
    @answers_7 = Answer.where(question_id: Q_07)
    session[:destination_1] = answer_params[:destination_1]
    session[:transit_time_1] = answer_params[:transit_time_1]
    # URL直打ち防止と質問画面を順番に遷移させるためにsessionの空判定とリダイレクト先を指定
    if session[:destination_1].blank? || session[:transit_time_1].blank?
      redirect_to action: :show_2
    end
  end
  # 質問画面Q4の表示メソッド
  def show_4
    # questionsテーブルからid:19を取得
    # id:19 = 住みたいエリアは？
    @question = Question.find(19)
    # answersテーブルからquestion_id:8に紐付く選択肢YorNを取得
    @answers_19 = Answer.where(question_id: Q_19)
    session[:destination_2] = answer_params[:destination_2]
    session[:transit_time_2] = answer_params[:transit_time_2]
    # URL直打ち防止と質問画面を順番に遷移させるためにsessionの空判定とリダイレクト先を指定
    if session[:destination_2].blank? || session[:transit_time_2].blank?
      redirect_to action: :show_3
    end
  end
  # 質問画面Q5の表示メソッド
  def show_5
    # questionsテーブルからid:9を取得
    # id:9 = 駅前にスポーツジムは必須？
    @question = Question.find(9)
    # answersテーブルからquestion_id:9に紐付く選択肢YorNを取得
    @answers_9 = Answer.where(question_id: Q_09)
    session[:prefecture_to_live] = answer_params[:prefecture_to_live]
    # URL直打ち防止と質問画面を順番に遷移させるためにsessionの空判定とリダイレクト先を指定
    if session[:prefecture_to_live].blank?
      redirect_to action: :show_4
    end
  end
  # 質問画面Q6の表示メソッド
  def show_6
    # questionsテーブルからid:10を取得
    # id:10 = 駅前にスターバックスコーヒーは必須？
    @question = Question.find(10)
    # answersテーブルからquestion_id:10に紐付く選択肢YorNを取得
    @answers_10 = Answer.where(question_id: Q_10)
    session[:gym] = answer_params[:gym]
    # URL直打ち防止と質問画面を順番に遷移させるためにsessionの空判定とリダイレクト先を指定
    if session[:gym].blank?
      redirect_to action: :show_5
    end
  end
  # 質問画面Q7の表示メソッド
  def show_7
    # questionsテーブルからid:11を取得
    # id:11 = 駅前にマクドナルドは必須？
    @question = Question.find(11)
    # answersテーブルからquestion_id:11に紐付く選択肢YorNを取得
    @answers_11 = Answer.where(question_id: Q_11)
    session[:starbucks_coffee] = answer_params[:starbucks_coffee]
    # URL直打ち防止と質問画面を順番に遷移させるためにsessionの空判定とリダイレクト先を指定
    if session[:starbucks_coffee].blank?
      redirect_to action: :show_6
    end
  end
  # 質問画面Q8の表示メソッド
  def show_8
    # questionsテーブルからid:12を取得
    # id:12 = 駅前に餃子の王将は必須？
    @question = Question.find(12)
    # answersテーブルからquestion_id:12に紐付く選択肢YorNを取得
    @answers_12 = Answer.where(question_id: Q_12)
    session[:mcdonalds] = answer_params[:mcdonalds]
    # URL直打ち防止と質問画面を順番に遷移させるためにsessionの空判定とリダイレクト先を指定
    if session[:mcdonalds].blank?
      redirect_to action: :show_7
    end
  end
  # 質問画面Q9の表示メソッド
  def show_9
    # questionsテーブルからid:14を取得
    # id:14 = 駅前に23時まで営業しているスーパーマーケットは必須？
    @question = Question.find(14)
    # answersテーブルからquestion_id:14に紐付く選択肢YorNを取得
    @answers_14 = Answer.where(question_id: Q_14)
    session[:ohsho] = answer_params[:ohsho]
    # URL直打ち防止と質問画面を順番に遷移させるためにsessionの空判定とリダイレクト先を指定
    if session[:ohsho].blank?
      redirect_to action: :show_8
    end
  end
  # 質問画面Q10の表示メソッド
  def show_10
    # questionsテーブルからid:15を取得
    # id:15 = 駅の近くに大きな公園は必須？
    @question = Question.find(15)
    # answersテーブルからquestion_id:15に紐付く選択肢YorNを取得
    @answers_15 = Answer.where(question_id: Q_15)
    session[:supermarket] = answer_params[:supermarket]
    # URL直打ち防止と質問画面を順番に遷移させるためにsessionの空判定とリダイレクト先を指定
    if session[:supermarket].blank?
      redirect_to action: :show_9
    end
  end
  # 質問画面Q11の表示メソッド
  def show_11
    # questionsテーブルからid:16を取得
    # id:16 = 駅の近くに図書館は必須？
    @question = Question.find(16)
    # answersテーブルからquestion_id:16に紐付く選択肢YorNを取得
    @answers_16 = Answer.where(question_id: Q_16)
    session[:large_park] = answer_params[:large_park]
    # URL直打ち防止と質問画面を順番に遷移させるためにsessionの空判定とリダイレクト先を指定
    if session[:large_park].blank?
      redirect_to action: :show_10
    end
  end
  # 質問画面Q12の表示メソッド
  def show_12
    # questionsテーブルからid:17を取得
    # id:17 = 駅の近くに公衆浴場やサウナは必須?
    @question = Question.find(17)
    # answersテーブルからquestion_id:17に紐付く選択肢YorNを取得
    @answers_17 = Answer.where(question_id: Q_17)
    session[:library] = answer_params[:library]
    # URL直打ち防止と質問画面を順番に遷移させるためにsessionの空判定とリダイレクト先を指定
    if session[:library].blank?
      redirect_to action: :show_11
    end
  end
  # 各質問事項の回答をsessionで保持した状態であればanswersコントローラーのshowアクションを呼び出す
  def create_answer
    session[:spa] = answer_params[:spa]
    # URL直打ち防止と質問画面を順番に遷移させるためにsessionの空判定とリダイレクト先を指定
    if session[:spa].blank?
      redirect_to action: :show_12
    else
      redirect_to controller: :answers, action: :show
    end
  end

  private

  # formから受け取れるパラメーターの設定
  def answer_params
    params.permit(
      :rent_budget,
      :floor_plan,
      :destination_1,
      :transit_time_1,
      :destination_2,
      :transit_time_2,
      :prefecture_to_live,
      :gym,
      :starbucks_coffee,
      :mcdonalds,
      :ohsho,
      :supermarket,
      :large_park,
      :library,
      :spa
    )
  end
end
