module ApplicationHelper

	def admin?
		if current_user != nil
			return true if current_user.role == 'admin'
		end
	end
end
