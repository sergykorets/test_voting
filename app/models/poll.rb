class Poll < ApplicationRecord

	belongs_to :organization
	has_many :votes, dependent: :destroy
end
