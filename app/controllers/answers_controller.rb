class AnswersController < ApplicationController

	before_action :authenticate_user
	before_action :find_answer, :find_question, except: [:create]
	before_action :authorize_user, only: [:edit]

	def create
		@question = Question.find_by(id: params[:question_id])
		answer = @question.answers.build(answer_params.merge(responder: current_user))
		if answer.save
			redirect_to question_path(@question)
		else
		redirect_to question_path(@question), flash: {error: 'Failed to Submit the Answer!'}
		end
	end

	def edit
	end

	def update
		@question.update_attributes(best_answer_id: @answer.id) if params[:answer][:best_answer]
		if @answer.update_attributes(answer_params)
			redirect_to question_path(@question)
		else
			redirect_to question_path(@question), flash: {error: 'Failed to Update the Answer!'}
		end
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
		params.require(:answer).permit(:content, :best_answer)
	end

	def authenticate_user
		redirect_to question_path(@question) if !current_user
	end

	def authorize_user
		redirect_to question_path(@question) if current_user!=@answer.responder
	end
end
