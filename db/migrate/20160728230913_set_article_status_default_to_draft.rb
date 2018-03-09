class SetArticleStatusDefaultToDraft < ActiveRecord::Migration[4.2]
  def change
    change_column_default :articles, :status, "draft"
  end
end
