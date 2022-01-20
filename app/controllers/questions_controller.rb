class QuestionsController < ApplicationController

  def show1
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

  def show2
    # questionsテーブルからid:4,5を取得
    # id:4 = 通勤通学の目的地の最寄駅は？
    # id:5 = 通勤通学時の移動時間は?
    @questions = Question.find(4,5)
    # answersテーブルからquestion_id:5に紐付く選択肢を取得、id:4は入力フォーム設置
    @answers_5 = Answer.where(question_id: Q_05)
  end

  def show3
    # questionsテーブルからid:6,7を取得
    # id:6 = 趣味等でよく行く場所の最寄駅は？
    # id:7 = 趣味等でよく行く場所への移動時間は？
    @questions = Question.find(6,7)
    # answersテーブルからquestion_id:7に紐付く選択肢を取得、id:6は入力フォーム設置
    @answers_7 = Answer.where(question_id: Q_07)
  end

  def show4
    # questionsテーブルからid:8を取得
    # id:8 = 駅前の雰囲気はどちらが好み？
    @question = Question.find(8)
    # answersテーブルからquestion_id:8に紐付く選択肢YorNを取得
    @answers_8 = Answer.where(question_id: Q_08)
  end

  def show5
    # questionsテーブルからid:9を取得
    # id:9 = 駅前にスポーツジムは必須？
    @question = Question.find(9)
    # answersテーブルからquestion_id:9に紐付く選択肢YorNを取得
    @answers_9 = Answer.where(question_id: Q_09)
  end

  def show6
    # questionsテーブルからid:10を取得
    # id:10 = 駅前にスターバックスコーヒーは必須？
    @question = Question.find(10)
    # answersテーブルからquestion_id:10に紐付く選択肢YorNを取得
    @answers_10 = Answer.where(question_id: Q_10)
  end

  def show7
    # questionsテーブルからid:11を取得
    # id:11 = 駅前にマクドナルドは必須？
    @question = Question.find(11)
    # answersテーブルからquestion_id:11に紐付く選択肢YorNを取得
    @answers_11 = Answer.where(question_id: Q_11)
  end

  def show8
    # questionsテーブルからid:12を取得
    # id:12 = 駅前に餃子の王将は必須？
    @question = Question.find(12)
    # answersテーブルからquestion_id:12に紐付く選択肢YorNを取得
    @answers_12 = Answer.where(question_id: Q_12)
  end

  def show9
    # questionsテーブルからid:13を取得
    # id:13 = 駅前に食べログの評価が3.5以上のお店は必須？
    @question = Question.find(13)
    # answersテーブルからquestion_id:13に紐付く選択肢YorNを取得
    @answers_13 = Answer.where(question_id: Q_13)
  end

  def show10
    # questionsテーブルからid:14を取得
    # id:14 = 駅前に23時まで営業しているスーパーマーケットは必須？
    @question = Question.find(14)
    # answersテーブルからquestion_id:14に紐付く選択肢YorNを取得
    @answers_14 = Answer.where(question_id: Q_14)
  end

  def show11
    # questionsテーブルからid:15を取得
    # id:15 = 駅の近くに大きな公園は必須？
    @question = Question.find(15)
    # answersテーブルからquestion_id:15に紐付く選択肢YorNを取得
    @answers_15 = Answer.where(question_id: Q_15)
  end

  def show12
    # questionsテーブルからid:16を取得
    # id:16 = 駅の近くに図書館は必須？
    @question = Question.find(16)
    # answersテーブルからquestion_id:16に紐付く選択肢YorNを取得
    @answers_16 = Answer.where(question_id: Q_16)
  end

  def show13
    # questionsテーブルからid:17を取得
    # id:17 = 駅の近くに公衆浴場やサウナは必須?
    @question = Question.find(17)
    # answersテーブルからquestion_id:17に紐付く選択肢YorNを取得
    @answers_17 = Answer.where(question_id: Q_17)
  end

  def create
  end
end
