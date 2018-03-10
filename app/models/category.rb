class Category < ApplicationRecord
  has_and_belongs_to_many :articles
  validates :name, presence: true, uniqueness: true

  scope :active,     -> { where active: true }
  scope :inactive,     -> { where active: false }

  scope :with_articles, -> { joins(:articles).group('categories.id').having('count(articles.id) > 0') }
end
