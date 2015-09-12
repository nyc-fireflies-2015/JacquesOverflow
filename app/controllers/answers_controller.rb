class AnswersController < ApplicationController

	before_action :authenticate_user
	before_action :find_answer, :find_question, except: [:create]
	before_action :authorize_user, only: [:edit]

	def create
		@question = Question.find_by(id: params[:question_id])
		answer = @question.answers.build(answer_params.merge(responder: current_user))
		flash[:errors] = answer.errors.full_messages unless @answer.save
		redirect_to question_path(@question)
	end

	def edit
	end	
	
	def update
		@answer.attributes = answer_params
		flash[:errors] = @answer.errors.full_messages unless @answer.save
		redirect_to question_path(@question)
	end

	def destroy
		@answer.destroy
		redirect_to question_path(@question)
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
		redirect_to question_path(@question) if !current_user
	end	

	def authorize_user
		redirect_to question_path(@question) if current_user!=@answer.responder
	end	
end	