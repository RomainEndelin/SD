class AddDerivedLocationToArticles < ActiveRecord::Migration[5.1]
  def change
    add_column :articles, :derived_location, :string
  end
end
