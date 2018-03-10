require 'uri'

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :confirmable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :name, presence: true
  validates_confirmation_of :password
  validates_format_of :website, with: URI::Parser.new.make_regexp(['http', 'https']), allow_blank: true

  mount_uploader :avatar, AvatarUploader
  mount_uploader :background_picture, PictureUploader
  validates :avatar, file_size: { less_than_or_equal_to: 5.megabytes }
  validates :background_picture, file_size: { less_than_or_equal_to: 5.megabytes }

  include Location

  has_many :articles, inverse_of: :author, foreign_key: "author_id"
  has_many :discussions, inverse_of: :author, foreign_key: "author_id"
  has_many :comments, inverse_of: :author, foreign_key: "author_id"

  has_many :notifications

  def date
    I18n.l(created_at.to_date, format: :long)
  end

  after_create do
    User.admin.each do |admin|
      Notification.create(user: admin, reference: self.id, notification_type: :new_user)
    end
  end

  before_destroy do |user|
    Notification.where(notification_type: :new_user, reference: user.id).destroy_all
  end

  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later
  end

  scope :admin,       -> { where admin: true }
  scope :user,        -> { where('confirmed_at IS NOT NULL AND admin = ?', false) }
  scope :unconfirmed, -> { where('confirmed_at IS NULL AND admin = ?', false) }
  scope :author, -> { joins(:articles).group("author_id").where("articles.status" => "published").having("count(author_id) > 0") }
end
