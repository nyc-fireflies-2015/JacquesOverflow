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
    elsif params[:answers]
      # @answer = Answer.find_by(id: )
    end

  end

  def destroy
  end

  private

    def vote_params
      params.require(:vote).permit(:value)
    end

end
