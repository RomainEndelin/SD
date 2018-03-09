class AddPopularityToArticles < ActiveRecord::Migration[4.2]
  def change
    add_column :articles, :popularity, :int, default: 0
  end
end
