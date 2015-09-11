class VotesController < ApplicationController

  def new
    @vote = Vote.new
  end

  def create
    if params[:questions]
      @question = Question.find_by(id: params[:id])
      @vote = Vote.new(vote_params)
      @vote.voter_id = current_user
      if @vote.save
        redirect_to question_path
      else
        flash[:notice] = 'Your vote has failed'
      end
    elsif params[:answers]
      @answer = Answer.find_by(id: )
    end

  end

  def destroy
  end

  private

    def vote_params
      params.require(:vote).permit(:voteable_id, :voter_id, :voteable_type, :value)
    end

end
