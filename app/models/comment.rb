class Comment < ApplicationRecord
  belongs_to :article
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  validates :content, presence: true
  validates :author, presence: true
  validates :article, presence: true

  def date
    I18n.l(created_at, format: :long)
  end

  after_create do
    notified = (User.admin + [article.author]).reject {|u| u == self.author}.uniq

    notified.each do |user|
      Notification.create(user: user, reference: self.id, notification_type: :new_comment)
    end
  end

  before_destroy do |comment|
    Notification.where(notification_type: :new_comment, reference: comment.id).destroy_all
  end
end
