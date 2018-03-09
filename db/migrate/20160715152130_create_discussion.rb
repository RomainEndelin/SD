class CreateDiscussion < ActiveRecord::Migration[4.2]
  def change
    create_table :discussions do |t|
      t.belongs_to :author, references: :users
      t.belongs_to :article, index: true
      t.text :content

      t.timestamps null: false
    end
  end
end
