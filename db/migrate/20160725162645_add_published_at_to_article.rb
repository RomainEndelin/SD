class AddPublishedAtToArticle < ActiveRecord::Migration[4.2]
  class Article < ApplicationRecord
  end
  
  def change
    add_column :articles, :published_at, :datetime
    Article.find_each do |article|
      if article.status == 'published'
        article.published_at = DateTime.now
        article.save!
      end
    end
  end
end
