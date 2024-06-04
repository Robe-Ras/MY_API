class Article < ApplicationRecord
  belongs_to :user

  validates :title, presence: true
  validates :content, presence: true


  attribute :private, :boolean, default: false
end
