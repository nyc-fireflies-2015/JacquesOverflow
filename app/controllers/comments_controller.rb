class CommentsController < ApplicationController
  before_action :authenticate_user

  def create
    if params[:answer_id]
      answer = Answer.find_by(id: params[:answer_id])
      @question = answer.question
      comment = answer.comments.build(comment_params.merge(commentator: current_user))
    elsif params[:question_id]
      @question = Question.find_by(id: params[:question_id])
      comment = question.comments.build(comment_params.merge(commentator: current_user))
    end
    flash[:error] = "Comment must be 1500 chars or less." unless comment.save
    redirect_to question_path(@question)
  end

  def destroy
    Comment.find(params[:id]).destroy
    redirect_to question_path(@question)
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def authenticate_user
    redirect_to root_path if !current_user
  end
end
