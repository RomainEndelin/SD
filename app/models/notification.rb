class Notification < ApplicationRecord
  belongs_to :user

  VALID_TYPES = %w(new_user new_comment new_discussion article_accepted article_rejected article_rework article_submitted article_withdrawn article_deleted)
  validates :notification_type, presence: true,
            inclusion: { in: VALID_TYPES }
  validates :reference, presence: true

  scope :unread, -> { where new: true }

  def object_reference
    case notification_type
    when "new_user"
      User.find_by(id: reference)
    when "new_discussion"
      Discussion.find_by(id: reference)
    when "new_comment"
      Comment.find_by(id: reference)
    when "article_rejected"
      Article.find_by(id: reference)
    when "article_accepted"
      Article.find_by(id: reference)
    when "article_rework"
      Article.find_by(id: reference)
    when "article_submitted"
      Article.find_by(id: reference)
    when "article_withdrawn"
      Article.find_by(id: reference)
    when "article_deleted"
      Article.find_by(id: reference)
    end
  end

  def message
    case notification_type
    when "new_user"
      I18n.t("notification.new_user_created", name: object_reference.name)
    when "new_discussion"
      I18n.t("notification.new_discussion_written", article: object_reference.article.title)
    when "new_comment"
      I18n.t("notification.new_comment_written", article: object_reference.article.title, author: object_reference.author.name)
    when "article_rejected"
      I18n.t("notification.article_rejected", article: object_reference.title)
    when "article_accepted"
      I18n.t("notification.article_accepted", article: object_reference.title)
    when "article_rework"
      I18n.t("notification.article_rework", article: object_reference.title)
    when "article_submitted"
      I18n.t("notification.article_submitted", article: object_reference.title)
    when "article_withdrawn"
      I18n.t("notification.article_withdrawn", article: reference)
    when "article_deleted"
      I18n.t("notification.article_deleted", article: reference)
    end
  end

  def path
    # TODO
  end

  def admin_path
    # TODO
  end

  def sends_email?
    case notification_type
    when "new_user"
      user.notification_new_user
    when "new_discussion"
      user.notification_new_discussion
    when "new_comment"
      user.notification_new_comment
    when "article_rejected", "article_accepted", "article_rework", "article_submitted", "article_withdrawn", "article_deleted"
      user.notification_article_status
    end
  end

  after_create do
    if sends_email?
      NotificationMailer.notification_email(self).deliver_later
    end
  end
end
