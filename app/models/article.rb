require 'action_view'
include ActionView::Helpers::DateHelper

class Article < ApplicationRecord
  include Location
  include Filterable

  before_save :attach_publish_date
  before_save :calculate_derived_location

  belongs_to :author, class_name: 'User'
  has_many :comments, dependent: :destroy
  has_many :discussions, dependent: :destroy
  has_and_belongs_to_many :categories

  attr_accessor :ignore_picture

  accepts_nested_attributes_for :discussions, :reject_if => lambda { |a| a[:content].blank? }, :allow_destroy => true
  mount_uploader :picture, PictureUploader
  validates :title,   presence: true
  validates :description, presence: true, length: {maximum: 300}
  validates :content, presence: true
  validates :author,  presence: true
  validates :picture, presence: true, on: :create, unless: :ignore_picture
  validates :picture, file_size: {less_than_or_equal_to: 5.megabytes}

  VALID_STATUSES = %w(draft submitted rejected rework published)
  validates :status, presence: true,
            inclusion: { in: VALID_STATUSES }

  scope :draft,     -> { where status: :draft }
  scope :submitted, -> { where status: :submitted }
  scope :rejected,  -> { where status: :rejected }
  scope :rework,    -> { where status: :rework }
  scope :published, -> { where status: :published }

  scope :by_category, -> (id) { where id: Category.find(id).articles }
  scope :by_location, -> (name) { where("lower(derived_location) LIKE ?", "%#{name.strip.downcase}%") }
  scope :by_author, -> (name) { joins(:author).where("lower(users.name) LIKE ?", "%#{name.strip.downcase}%") }
  scope :by_category_name, -> (key) { joins(:categories).where("lower(categories.name) LIKE ?", "%#{key.strip.downcase}%") }
  scope :by_fields, -> (key) do
    key = key.strip.downcase
    where("lower(title) LIKE ?", "%#{key}%").or(where("lower(content) LIKE ?", "%#{key}%")).or(where("lower(description) LIKE ?", "%#{key}%"))
  end
  scope :by_search, -> (key) do
    results = by_fields(key) | by_location(key) | by_author(key) | by_category_name(key)
    Article.where(id: results.map(&:id))
  end

  scope :most_popular, -> { reorder('popularity DESC') }
  scope :most_recent, -> { reorder('published_at DESC') }

  def date
    _date = (status == "published") ? published_at : created_at
    I18n.l _date.to_date
  end

  def similar(similar_count: 3)
    (similar_by_author | similar_by_location | similar_by_categories)
      .sort_by {|a| -a.popularity}
      .take(similar_count)
  end

  def popularity_rank
    Article.where("status='published' AND popularity <= ?", popularity).count
  end

  def similar_by_author(similar_count: 3)
    Article.where(id: author.articles.published)
      .most_popular
      .reject {|a| a == self}
      .take(similar_count)
  end

  def similar_by_location(similar_count: 3)
    _country = ISO3166::Country[country]
    by_continent = Article.published
      .most_popular
      .select{|a| ISO3166::Country[a.country].region == _country.region}
      .reject {|a| a == self}
    by_country, similar_continent = by_continent.partition {|a| a.country == country}
    similar_city, similar_country = by_country.partition {|a| a.city == city}
    (similar_city + similar_country + similar_continent)
      .take(similar_count)
  end

  def similar_by_categories(similar_count: 3)
    Article.where(id: categories.map{|c| c.articles.published}.flatten)
      .most_popular
      .reject {|a| a == self}
      .take(similar_count)
  end

  def popularity
    return -1 if status != 'published'
    self[:popularity]
  end

  def accept!
    update_attributes status: :published if status == "submitted"
  end

  def rework!
    update_attributes status: :rework if ["submitted", "rejected"].include?(status)
  end

  def reject!
    update_attributes status: :rejected if status == "submitted"
  end

  def set_status(status, initiator)
    return if status == self.status
    update_attributes status: status

    notified = initiator.admin? ? [self.author] : User.admin.all
    notified.each do |user|
      Notification.create(user: user, reference: self.id, notification_type: notification(status))
    end
  end

  def remove(initiator)
    notified = initiator.admin? ? [self.author] : User.admin.all
    notified.each do |user|
      Notification.create(user: user, reference: self.id, notification_type: 'article_deleted')
    end
    self.destroy
  end

    def calculate_derived_location
      self.derived_location = full_location
    end

  private

    def attach_publish_date
        self.published_at = DateTime.now if self.status == "published" && self.published_at.nil?
    end

    def notification(status)
      case status.to_s
      when "published"
        "article_accepted"
      when "rework"
        "article_rework"
      when "rejected"
        "article_rejected"
      when "submitted"
        "article_submitted"
      when "draft"
        "article_withdrawn"
      end
    end
end
