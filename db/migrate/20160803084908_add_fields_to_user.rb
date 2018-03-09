class AddFieldsToUser < ActiveRecord::Migration[4.2]
  def change
    change_table :users do |t|
      t.string :avatar
      t.string :background_picture
      t.text :biography
      t.string :city
      t.string :country
    end
  end
end
