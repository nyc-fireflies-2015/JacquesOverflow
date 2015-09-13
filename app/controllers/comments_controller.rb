class CommentsController < ApplicationController
  before_action :authenticate_user

  def create
    if params[:answer_id]
      answer = Answer.find_by(id: params[:answer_id])
      @question = answer.question
      @comment = answer.comments.build(comment_params.merge(commentator: current_user))
      if @comment.save && request.xhr?
        render @comment
      else
        redirect_to question_path(@question), flash: {error: "Comment must be 1500 chars or less." }
      end
    elsif params[:question_id]
      @question = Question.find_by(id: params[:question_id])
      @comment = @question.comments.build(comment_params.merge(commentator: current_user))
      if @comment.save && request.xhr?
        render @comment
      else
        redirect_to question_path(@question), flash: {error: "Comment must be 1500 chars or less." }
      end
    end

    # if comment.save && request.xhr?
    #   :render partial:'questions/question_comments', object: comment, layout: false
    #   # redirect_to question_path(@question)
    # else
    #   redirect_to question_path(@question), flash: {error: "Comment must be 1500 chars or less." }
    # end
  end

  def destroy
    comment = Comment.find(params[:id])
    if params[:question_id]
      @question = Question.find_by(id: params[:question_id])
    elsif params[:answer_id]
      @question = Answer.find_by(id: params[:answer_id]).question
    end
    comment.destroy
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
