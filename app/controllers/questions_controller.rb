class QuestionsController < ApplicationController
  def index
    @questions = Question.all
  end

  def show
    @question = Question.find_by(params[:id])
  end

  def new
    @question = Question.new
  end

  def create
    question = Question.new(question_params)#merge current user
    if question.save
      redirect_to root_path
    else
      flash[:error] = "Invalid input: must include both title and content."
      redirect_to new_question_path
    end
  end

  private

  def question_params
    params.require(:question).permit(:title, :content)
  end
end
