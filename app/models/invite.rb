class Invite < ApplicationRecord

	validates :email, presence: true, uniqueness: { :scope => :organization_id }

	belongs_to :organization
	belongs_to :head, :class_name => 'User'
	belongs_to :voter, :class_name => 'User'

	before_create :generate_token

	def generate_token
	   self.token = Digest::SHA1.hexdigest([self.organization_id, Time.now, rand].join)
	end

end
