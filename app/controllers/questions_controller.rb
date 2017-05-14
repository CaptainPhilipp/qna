class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: %i(index show)
  before_action :load_question, only: %i(show edit update destroy best_answer)
  before_action :check_question_ownership!, only: %i(edit update destroy best_answer)

  def index
    @questions = Question.all
  end

  def create
    @question = current_user.questions.new(questions_params)
    if @question.save
      redirect_to @question
    else
      render :new
    end
  end

  def show
    @question = Question.find(params[:id])
    @answer   = Answer.new
  end

  def new
    @question = current_user.questions.new
  end

  def edit; end

  def update
    if @question.update(questions_params)
      redirect_to @question
    else
      render :edit
    end
  end

  def destroy
    @question.destroy
    redirect_to questions_url
  end

  def best_answer
    @question.update best_answer_id: params[:answer_id]
  end

  private

  def load_question
    @question = Question.find(params[:id] || params[:question_id])
  end

  def check_question_ownership!
    redirect_to @question unless current_user.owner? @question
  end

  def questions_params
    params.require(:question).permit %i(title body)
  end
end
