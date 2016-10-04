class Journal < ApplicationRecord
  belongs_to :user
  
  validates :summary, presence: true
  validates :entry, presence: true
  validates :user_id, presence: true
  
end
