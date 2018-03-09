class CreateComments < ActiveRecord::Migration[4.2]
  def change
    create_table :comments do |t|
      t.references :author, references: :users
      t.references :article, index: true, foreign_key: true
      t.text :content

      t.timestamps null: false
    end
  end
end
