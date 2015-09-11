class VotesController < ApplicationController
  def create
    if params[:questions]
      @voteable = Question.find_by(id: @voteable.id)
      vote = Vote.new(vote_params)
      #implmement a user helper method here; current_user etc..
      vote.voter_id = current_user
      if vote.save
        redirect_to question_path
      else
        flash[:notice] = 'Your vote has failed'
      end
    elsif params[:answers]

    end


  end

  def destroy
  end

  private

    def vote_params
      params.require(:vote).permit(:voteable_id, :voter_id, :voteable_type)
    end

end
