class VotesController < ApplicationController

  def new
    @vote = Vote.new
  end

  def create
    if params[:question_id]
      @question = Question.find_by(id: params[:question_id])
      @vote = @question.votes.build(vote_params.merge(voter: current_user))
      if @vote.save
        redirect_to root_path
      else
        flash[:notice] = 'Your vote has failed'
      end
    elsif params[:answer_id]
      @answer = Answer.find_by(id: params[:answer_id])
      @vote = @answer.votes.build(vote_params.merge(voter_id: 1))
      if @vote.save
        redirect_to root_path
      else
        flash[:notice] = 'Your vote has failed'
      end
    end

  end

  # def destroy
  # end

  private

    def vote_params
      params.require(:vote).permit(:value)
    end

end
