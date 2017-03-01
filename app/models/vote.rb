class Vote < ApplicationRecord

	validates :voter_id, uniqueness: { :scope => :poll_id }

	belongs_to :user
	belongs_to :poll
end
