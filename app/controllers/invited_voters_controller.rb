class InvitedVotersController < ApplicationController
     skip_before_action :require_login

	def new
		@newUser = User.new
	   @token = params[:invite_token]
	   	  puts '***************************************************************************'
	  puts @token.inspect #<-- pulls the value from the url query string
	end

	def create
	  puts '***************************************************************************'
	  puts @token.inspect
	  @newUser = User.new(user_params)
	  @newUser.role = 'voter'
	  @newUser.save

	  @token = params[:invite_token]
	  puts '***************************************************************************'
	  puts @token.inspect
	  if @token != nil
	     org =  Invite.find_by_token(@token).organization #find the user group attached to the invite
	     @newUser.organizations.push(org) #add this user to the new user group as a member
	  else
	  	redirect_to root_path
	  end
	end

	private

	def user_params
	  params[:user].permit(:email, :name, :password)
	end

end