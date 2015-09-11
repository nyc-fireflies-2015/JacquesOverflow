class AnswersController < ApplicationController

	before_action :authenticate_user, :find_answer, :find_question
	before_action :authorize_user, except: [:create]

	def create

	end
	
	def update
	end

	def destroy
	end

	private

	def find_answer
		@answer = Answer.find_by(id: params[:id])
	end	

	def find_question
		@question = @answer.question
	end	

	def answer_params
		params.require(:answer).permit(:content)
	end	

	def authenticate_user
		redirect_to root_path if !current_user
	end	

	def authorize_user
		redirect_to root_path if current_user!=@answer.responder
	end	

end	