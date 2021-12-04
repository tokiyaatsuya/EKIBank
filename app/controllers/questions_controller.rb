class QuestionsController < ApplicationController

  def show1
    @questions = Question.find(1,2,3)
    @answers_1 = Answer.where("question_id = 1")
    @answers_2 = Answer.where("question_id = 2")
    @answers_3 = Answer.where("question_id = 3")
  end

  def show2
    @questions = Question.find(4,5)
    @answers_5 = Answer.where("question_id = 5")
  end

  def show3
    @questions = Question.find(6,7)
    @answers_7 = Answer.where("question_id = 7")
  end

  def show4
    @question = Question.find(8)
    @answers_8 = Answer.where("question_id = 8")
  end

  def show5
    @question = Question.find(9)
    @answers_9 = Answer.where("question_id = 9")
  end

  def show6
    @question = Question.find(10)
    @answers_10 = Answer.where("question_id = 10")
  end

  def show7
    @question = Question.find(11)
    @answers_11 = Answer.where("question_id = 11")
  end

  def show8
    @question = Question.find(12)
    @answers_12 = Answer.where("question_id = 12")
  end

  def show9
    @question = Question.find(13)
    @answers_13 = Answer.where("question_id = 13")
  end

  def show10
    @question = Question.find(14)
    @answers_14 = Answer.where("question_id = 14")
  end

  def show11
    @question = Question.find(15)
    @answers_15 = Answer.where("question_id = 15")
  end

  def show12
    @question = Question.find(16)
    @answers_16 = Answer.where("question_id = 16")
  end

  def show13
    @question = Question.find(17)
    @answers_17 = Answer.where("question_id = 17")
  end

  def create
  end
end
