class HeadsController < ApplicationController

	def create_head
		if admin?
			@user = User.new
		else
			redirect_to root_path
		end
	end

	def save_head
		if admin?
			@user = User.new(user_params)
			if @user.save
				redirect_to root_path, notice: 'Head created'
			else
				render :new
			end
		else
			redirect_to root_path
		end
	end

	private

	def user_params
		params[:user].permit(:email, :name, :password, :role)
	end
end