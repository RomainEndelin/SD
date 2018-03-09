class AddNotificationPreferencesToUser < ActiveRecord::Migration[4.2]
  def change
    add_column :users, :notification_new_user, :boolean, default: true
    add_column :users, :notification_new_discussion, :boolean, default: true
    add_column :users, :notification_new_comment, :boolean, default: true
    add_column :users, :notification_article_status, :boolean, default: true
  end
end
