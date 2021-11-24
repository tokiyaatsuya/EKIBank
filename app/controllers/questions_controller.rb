class QuestionsController < ApplicationController

  def show1
    @question = Question.new
  end

  def show2
    session[:rent_budget] = question_params[:rent_budget]
    session[:buying_budget_1] = question_params[:buying_budget_1]
    session[:buying_budget_2] = question_params[:buying_budget_2]
    @question = Question.new
  end

  def show3
    session[:destination_1] = question_params[:destination_1]
    session[:transit_time_1] = question_params[:transit_time_1]
    @question = Question.new
  end

  def show4
    session[:destination_2] = question_params[:destination_2]
    session[:transit_time_2] = question_params[:transit_time_2]
    @question = Question.new
  end

  def show5
    session[:station_atmosphere] = question_params[:station_atmosphere]
    @question = Question.new
  end

  def show6
    session[:gym] = question_params[:gym]
    @question = Question.new
  end

  def show7
    session[:starbacks_coffee] = question_params[:starbacks_coffee]
    @question = Question.new
  end

  def show8
    session[:mcdonalds] = question_params[:mcdonalds]
    @question = Question.new
  end

  def show9
    session[:ohsho] = question_params[:ohsho]
    @question = Question.new
  end

  def show10
    session[:tabelog_high_score] = question_params[:tabelog_high_score]
    @question = Question.new
  end

  def show11
    session[:supermarket] = question_params[:supermarket]
    @question = Question.new
  end

  def show12
    session[:large_park] = question_params[:large_park]
    @question = Question.new
  end

  def show13
    session[:library] = question_params[:library]
    @question = Question.new
  end

  def create
    @question = Question.new(
      rent_budget: session[:rent_budget],
      buying_budget_1: session[:buying_budget_1],
      buying_budget_2: session[:buying_budget_2],
      destination_1: session[:destination_1],
      transit_time_1: session[:transit_time_1],
      destination_2: session[:destination_2],
      transit_time_2: session[:transit_time_2],
      station_atmosphere: session[:station_atmosphere],
      gym: session[:gym],
      starbacks_coffee: session[:starbacks_coffee],
      mcdonalds: session[:mcdonalds],
      ohsho: session[:ohsho],
      tabelog_high_score: session[:tabelog_high_score],
      supermarket: session[:supermarket],
      large_park: session[:large_park],
      library: session[:library],
      spa: session[:spa]
    )
    if @question.save
      session[:id] = @question.id
      redirect_to answers_show_questions_path
    else
      render '/questions/show1'
    end
  end

  private

  def question_params
    params.require(:question).permit(
      :rent_budget,
      :buying_budget_1,
      :buying_budget_2,
      :destination_1,
      :transit_time_1,
      :destination_2,
      :transit_time_2,
      :station_atmosphere,
      :gym,
      :starbacks_coffee,
      :mcdonalds,
      :ohsho,
      :tabelog_high_score,
      :supermarket,
      :large_park,
      :library,
      :spa
    )
  end
end
