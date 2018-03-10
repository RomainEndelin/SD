class Discussion < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  belongs_to :article
  validates :content, presence: true
  validates :author,  presence: true

  def date
    I18n.l created_at, format: :long
  end

  after_create do
    notified = (User.admin + [article.author]).reject {|u| u == self.author}.uniq

    notified.each do |user|
      Notification.create(user: user, reference: self.id, notification_type: :new_discussion)
    end
  end

  before_destroy do |discussion|
    Notification.where(notification_type: :new_discussion, reference: discussion.id).destroy_all
  end
end
