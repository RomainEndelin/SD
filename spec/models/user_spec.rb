require 'rails_helper'

describe User do
  it 'is valid with correct attributes' do
    expect(build(:user)).to be_valid
  end

  it 'is invalid without a name' do
    user = build(:user, name: nil)
    user.valid?
    expect(user.errors[:name]).to include("can't be blank")
  end

  it 'is not admin by default' do
    user = build(:user)
    expect(user.admin?).to be false
  end

  it 'is admin when specified' do
    user = build(:admin)
    expect(user.admin?).to be true
  end

  describe 'website' do
    it 'is valid with a blank website' do
      expect(build(:user, website: '')).to be_valid
    end

    it 'is valid with a correct url as website' do
      expect(build(:user, website: 'https://suratdunia.id')).to be_valid
    end

    it 'is invalid with a non-url website' do
      user = build(:user, website: 'suratdunia')
      user.valid?
      expect(user.errors[:website]).to include("is invalid")
    end
  end

  describe 'location' do
    context 'with a city and country' do
      it 'provides a complete location' do
        user = build(:user, city: 'Montpellier', country: 'FR')
        expect(user.location).to eq 'Montpellier, France'
      end
    end

    context 'without a city' do
      before :each do
        @user = build(:user, city: nil, country: 'FR')
      end

      it 'provides the country as location' do
        expect(@user.location).to eq 'France'
      end

      it 'is valid without a city' do
        expect(@user).to be_valid
      end
    end

    context 'without a country' do
      it 'is invalid without a country' do
        user = build(:user, country: nil)
        user.valid?
        expect(user.errors[:country]).to include("can't be blank")
      end
    end
  end

  describe 'Notifications' do
    describe 'Admin Notifications' do
      before(:each) do
        @admin = create(:admin)
      end

      it 'notifies @admin when there is a new user' do
        create(:user)
        expect(@admin.notifications.last.notification_type).to eq "new_user"
      end

      it 'notifies @admin when user writes a new discussion' do
        create(:discussion)
        expect(@admin.notifications.last.notification_type).to eq "new_discussion"
      end

      it 'does not notify @admin when he writes a new discussion' do
        article = create(:article)
        expect {
          create(:discussion, author: @admin, article: article)
        }.not_to change{ @admin.notifications.count }
      end

      it 'notifies @admin when there is a new comment' do
        create(:comment)
        expect(@admin.notifications.last.notification_type).to eq "new_comment"
      end

      it 'does not notify @admin when he authors a new comment' do
        article = create(:article)
        expect {
          create(:comment, author: @admin, article: article)
        }.not_to change{ @admin.notifications.count }
      end

      it 'notifies @admin when the author submits his article' do
        article = create(:article, status: :draft)
        article.set_status("submitted", article.author)
        expect(@admin.notifications.last.notification_type).to eq "article_submitted"
      end

      it 'notifies @admin when the author withdraws his article' do
        article = create(:article, status: :submitted)
        article.set_status("draft", article.author)
        expect(@admin.notifications.last.notification_type).to eq "article_withdrawn"
      end

      it 'notifies @admin when the author destroys his article' do
        article = create(:article, status: :submitted)
        article.remove(article.author)
        expect(@admin.notifications.last.notification_type).to eq "article_deleted"
      end

      it 'does not notify @admin when he destroys an article' do
        article = create(:article, status: :submitted)
        expect {
          article.remove(@admin)
        }.not_to change{ @admin.notifications.count }
      end

      it 'does not notify @admin when he changes the status of an article' do
        article = create(:article, status: :submitted)
        expect {
          article.set_status("accepted", @admin)
        }.not_to change{ @admin.notifications.count }
      end
    end

    describe 'User notifications' do
      before(:each) do
        @user = create(:user)
      end

      it 'notifies user when @admin writes a new discussion on his article' do
        article = create(:article, author: @user)
        create(:discussion, article: article)
        expect(@user.notifications.last.notification_type).to eq "new_discussion"
      end

      it 'does not notify user when he writes a new discussion on his article' do
        article = create(:article, author: @user)
        expect {
          create(:discussion, article: article, author: @user)
        }.not_to change{@user.notifications.count }
      end

      it 'notifies user when there is a new comment on his article' do
        article = create(:article, author: @user)
        create(:comment, article: article)
        expect(@user.notifications.last.notification_type).to eq "new_comment"
      end

      it 'does not notify user when he writes a new comment on his article' do
        article = create(:article, author: @user)
        expect {
          create(:comment, article: article, author: @user)
        }.not_to change{ @user.notifications.count }
      end

      it 'notifies user when an article is rejected' do
        article = create(:article, author: @user, status: :submitted)
        admin = create(:admin)
        article.set_status("rejected", admin)
        expect(@user.notifications.last.notification_type).to eq "article_rejected"
      end

      it 'notifies user when an article is accepted' do
        article = create(:article, author: @user, status: :submitted)
        admin = create(:admin)
        article.set_status("published", admin)
        expect(@user.notifications.last.notification_type).to eq "article_accepted"
      end

      it 'notifies user when an article needs rework' do
        article = create(:article, author: @user, status: :submitted)
        admin = create(:admin)
        article.set_status("rework", admin)
        expect(@user.notifications.last.notification_type).to eq "article_rework"
      end

      it 'notifies user when the admin destroys his article' do
        article = create(:article, author: @user, status: :submitted)
        admin = create(:admin)
        article.remove(admin)
        expect(@user.notifications.last.notification_type).to eq "article_deleted"
      end

      it 'does not notify user when he destroys an article' do
        article = create(:article, author: @user, status: :submitted)
        expect {
          article.remove(@user)
        }.not_to change{ @user.notifications.count }
      end

      it 'does not notify user when he withdraws an article' do
        article = create(:article, author: @user, status: :submitted)
        expect {
          article.set_status("draft", @user)
        }.not_to change{ @user.notifications.count }
      end

      it 'does not notify user when he submits an article' do
        article = create(:article, author: @user, status: :draft)
        expect {
          article.set_status("submitted", @user)
        }.not_to change{ @user.notifications.count }
      end
    end
  end
end
