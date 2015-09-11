class QuestionsController < ApplicationController
  def index
    @questions = Question.all
  end

  def show
    @question = Question.find(params[:id])
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

  def edit
    @question = Question.find(params[:id])
  end

  def update
    question = Question.find(params[:id])
    if question.update_attributes(question_params)
      redirect_to question_path(question)
    else
      flash[:error] = "Invalid input: must include both title and content."
      redirect_to edit_question_path(question)
    end
  end

  def destroy
    question = Question.find(params[:id])
    question.destroy
    redirect_to root_path
  end

  private

  def question_params
    params.require(:question).permit(:title, :content)
  end
end
