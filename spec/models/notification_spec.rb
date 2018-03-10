require 'rails_helper'

include Rails.application.routes.url_helpers

describe Notification do
  it 'is valid with correct attributes' do
    expect(build(:notification)).to be_valid
  end

  it 'is invalid without reference to an object' do
    notification = build(:notification, reference: nil)
    notification.valid?
    expect(notification.errors[:reference]).to include("can't be blank")
  end

  it 'is invalid with an unknown type' do
    notification = build(:notification, notification_type: "test")
    notification.valid?
    expect(notification.errors[:notification_type]).to include("is not included in the list")
  end

  describe 'new user' do
    before(:each) do
      @user = create(:user)
      @notification = build(:notification, notification_type: "new_user", reference: @user.id)
    end

    it 'displays the right message for a new user' do
      expect(@notification.message).to eq "A new user has registered: #{@user.name}"
    end
  end

  describe 'new discussion' do
    before(:each) do
      @discussion = create(:discussion)
      @notification = build(:notification, notification_type: "new_discussion", reference: @discussion.id)
    end

    it 'displays the right message for a new discussion' do
      expect(@notification.message).to eq "A new discussion has been written on article \"#{@discussion.article.title}\""
    end
  end

  describe 'new comment' do
    before(:each) do
      @comment = create(:comment)
      @notification = build(:notification, notification_type: "new_comment", reference: @comment.id)
    end

    it 'displays the right message for a new comment' do
      expect(@notification.message).to eq "A new comment has been written by #{@comment.author.name} on article \"#{@comment.article.title}\""
    end
  end

  describe 'rejected article' do
    before(:each) do
      @article = create(:article)
      @notification = build(:notification, notification_type: "article_rejected", reference: @article.id)
    end

    it 'displays the right message for the rejected article' do
      expect(@notification.message).to eq "Your article \"#{@article.title}\" has been rejected"
    end
  end

  describe 'accepted article' do
    before(:each) do
      @article = create(:article)
      @notification = build(:notification, notification_type: "article_accepted", reference: @article.id)
    end

    it 'displays the right message for the accepted article' do
      expect(@notification.message).to eq "Your article \"#{@article.title}\" has been published"
    end
  end

  describe 'article to rework' do
    before(:each) do
      @article = create(:article)
      @notification = build(:notification, notification_type: "article_rework", reference: @article.id)
    end

    it 'displays the right message for the article' do
      expect(@notification.message).to eq "Your article \"#{@article.title}\" needs to be reworked"
    end
  end

  describe 'submitted articles' do
    before(:each) do
      @article = create(:article)
      @notification = build(:notification, notification_type: "article_submitted", reference: @article.id)
    end

    it 'displays the right message for the article' do
      expect(@notification.message).to eq "The article \"#{@article.title}\" has been submitted"
    end
  end

  describe 'withdrawn articles' do
    before(:each) do
      @article = create(:article)
      @notification = build(:notification, notification_type: "article_withdrawn", reference: @article.title)
    end

    it 'displays the right message for the article' do
      expect(@notification.message).to eq "The article \"#{@article.title}\" has been withdrawn"
    end
  end

  describe 'deleted articles' do
    before(:each) do
      @article = create(:article)
      @notification = build(:notification, notification_type: "article_deleted", reference: @article.title)
    end

    it 'displays the right message for the article' do
      expect(@notification.message).to eq "The article \"#{@article.title}\" has been deleted"
    end
  end
end
