class CreateCategories < ActiveRecord::Migration[4.2]
  def change
    create_table :categories do |t|
      t.string :name, null: false, unique: true
      t.boolean :active, default: true

      t.timestamps null: false
    end

    create_table :articles_categories do |t|
      t.belongs_to :article, index: true
      t.belongs_to :category, index: true
    end
  end
end
