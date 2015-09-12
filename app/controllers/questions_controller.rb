class QuestionsController < ApplicationController
  before_action :find_question, except: [:index, :new, :create]
  before_action :authenticate_user, except: [:index, :show]

  def index
    @questions = Question.all
  end

  def show
    @comments = @question.comments
    @answers = @question.answers.includes(:comments)
    @vote = Vote.new
    @answer = Answer.new
    @comment = Comment.new
  end

  def new
    @question = Question.new
  end

  def create
    question = Question.new(question_params.merge(submitter: current_user))
    if question.save
      redirect_to root_path
    else
      flash[:error] = "Invalid input: must include both title and content."
      redirect_to new_question_path
    end
  end

  def edit
  end

  def update
    if @question.update_attributes(question_params)
      redirect_to question_path(@question)
    else
      flash[:error] = "Invalid input: must include both title and content."
      redirect_to edit_question_path(@question)
    end
  end

  def destroy
    @question.destroy
    redirect_to root_path
  end

  private

  def question_params
    params.require(:question).permit(:title, :content)
  end

  def find_question
    @question = Question.find(params[:id])
  end

  def authenticate_user
    redirect_to root_path if !current_user
  end
end
