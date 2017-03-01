class User < ApplicationRecord
  include Clearance::User

  has_many :organizations, foreign_key: "head_id", dependent: :destroy
  has_many :organizations, through: :memberships
  has_many :memberships
  has_many :created_invites, class_name: "Invite", foreign_key: "head_id", dependent: :destroy
  has_many :received_invites, class_name: "Invite", foreign_key: "voter_id", dependent: :nullify
  has_many :votes, foreign_key: 'voter_id', dependent: :destroy

end
