class ApplicationController < ActionController::Base
	before_action :require_login
	include Clearance::Controller
	protect_from_forgery with: :exception

	def admin?
		return true if current_user.role == 'admin'
	end

	def head_of_organization?(user)
		return true if @organization.head_id == user.id
	end

	def define_organization
		@organization = Organization.find(params[:organization_id])
	end

	def define_poll
		@poll = Poll.find(params[:poll_id])
	end
end
