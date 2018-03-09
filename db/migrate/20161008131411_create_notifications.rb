class CreateNotifications < ActiveRecord::Migration[4.2]
  def change
    create_table :notifications do |t|
      t.references :user, index: true, foreign_key: true
      t.boolean :read, default: false
      t.string :notification_type
      t.string :reference
      t.timestamps null: false
    end
  end
end
