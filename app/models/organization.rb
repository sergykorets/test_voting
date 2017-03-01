class Organization < ApplicationRecord

	has_many :invites, dependent: :destroy
	has_many :memberships
	has_many :voters, :class_name => 'User', through: :memberships, source: :user  
	belongs_to :head, :class_name => 'User'
	has_many :polls, dependent: :destroy

	has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
    validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/

	def has_membership?(user)
		Membership.where(user_id: user.id, organization_id: self.id).exists?
	end
	
end
