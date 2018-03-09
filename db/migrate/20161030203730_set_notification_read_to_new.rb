class SetNotificationReadToNew < ActiveRecord::Migration[4.2]
  def change
    rename_column :notifications, :read, :new
    change_column_default(:notifications, :new, true)
  end
end
