class AddLocationToArticle < ActiveRecord::Migration[4.2]
  def change
    add_column :articles, :city, :string
    add_column :articles, :country, :string
  end
end
