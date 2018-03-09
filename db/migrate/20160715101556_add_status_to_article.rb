class AddStatusToArticle < ActiveRecord::Migration[4.2]
  class Article < ApplicationRecord
  end

  def change
    add_column :articles, :status, :string, default: :submitted
    Article.find_each do |article|
      article.status = 'published'
      article.save!
    end
  end
end
