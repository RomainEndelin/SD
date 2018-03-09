class AddAuthorIdToArticle < ActiveRecord::Migration[4.2]
  def change
    add_reference :articles, :author, references: :users, index: true
  end
end
