require 'rails_helper'

describe Article do
  it 'is valid with correct attributes' do
    expect(build(:article)).to be_valid
  end

  it 'is invalid without a title' do
    article = build(:article, title: nil)
    article.valid?
    expect(article.errors[:title]).to include("can't be blank")
  end

  it 'is invalid without a description' do
    article = build(:article, description: nil)
    article.valid?
    expect(article.errors[:description]).to include("can't be blank")
  end

  it 'is invalid without a too long description' do
    article = build(:article, description: "a" * 301)
    article.valid?
    expect(article.errors[:description]).to include(/is too long/)
  end

  it 'is invalid without a content' do
    article = build(:article, content: nil)
    article.valid?
    expect(article.errors[:content]).to include("can't be blank")
  end

  it 'is invalid without an author' do
    article = build(:article, author: nil)
    article.valid?
    expect(article.errors[:author]).to include("can't be blank")
  end

  it 'is invalid without a background picture' do
    article = build(:article, picture: nil, ignore_picture: false)
    article.valid?
    expect(article.errors[:picture]).to include("can't be blank")
  end

  it 'is attached to articles' do
    article = create(:article)
    categories = Array.new(3){ create(:category, articles: [article]) }
    expect(article.categories).to match_array categories
  end

  describe 'status' do
    it 'is valid if status is "published"' do
      expect(build(:article, status: :published)).to be_valid
    end

    it 'is valid if status is "draft"' do
      expect(build(:article, status: :draft)).to be_valid
    end

    it "is invalid without a status" do
      article = build(:article, status: nil)
      article.valid?
      expect(article.errors[:status]).to include("can't be blank")
    end

    it "is invalid if status isn't valid" do
      article = build(:article, status: 'hello')
      article.valid?
      expect(article.errors[:status]).to include("is not included in the list")
    end
  end

  describe 'published_at' do
    it "doesn't attach a published_at date before publish" do
      Timecop.freeze
      article = create(:article, status: :draft)
      expect(article.published_at).to eq nil
      Timecop.return
    end

    it "attachs a published_at date when publishing new article" do
      Timecop.freeze
      article = create(:article, status: :published)
      expect(article.published_at).to eq DateTime.now
      Timecop.return
    end

    it 'attachs a published_at date on publishing existing article' do
      Timecop.freeze
      article = create(:article, status: :draft)
      article.status = :published
      article.save
      expect(article.published_at).to eq DateTime.now
      Timecop.return
    end

    it "doesn't update published_at on updating published article" do
      article = create(:article, status: :published)
      original_published_at = article.published_at
      Timecop.freeze
      article.title = "Updated content"
      article.save
      expect(article.published_at).to eq original_published_at
      Timecop.return
    end
  end

  describe 'location' do
    context 'with a city and country' do
      it 'provides a complete location' do
        article = build(:article, city: 'Montpellier', country: 'FR')
        expect(article.location).to eq 'Montpellier, France'
      end
    end

    context 'without a city' do
      before :each do
        @article = build(:article, city: nil, country: 'FR')
      end

      it 'provides the country as location' do
        expect(@article.location).to eq 'France'
      end

      it 'is valid without a city' do
        expect(@article).to be_valid
      end
    end

    context 'without a country' do
      it 'is invalid without a country' do
        article = build(:article, country: nil)
        article.valid?
        expect(article.errors[:country]).to include("can't be blank")
      end
    end
  end

  describe 'workflow' do
    describe 'accept!' do
      it "changes the status from submitted to accepted" do
        article = create(:article, status: :submitted)
        article.accept!
        expect(article.status).to eq "published"
      end

      it "doesn't change the status from draft to accepted" do
        article = create(:article, status: :draft)
        article.accept!
        expect(article.status).to eq "draft"
      end
    end
    describe 'rework!' do
      it "changes the status from submitted to rework" do
        article = create(:article, status: :submitted)
        article.rework!
        expect(article.status).to eq "rework"
      end

      it "changes the status from rejected to rework" do
        article = create(:article, status: :rejected)
        article.rework!
        expect(article.status).to eq "rework"
      end

      it "doesn't change the status from draft to rework" do
        article = create(:article, status: :draft)
        article.rework!
        expect(article.status).to eq "draft"
      end
    end
    describe 'reject!' do
      it "changes the status from submitted to rejected" do
        article = create(:article, status: :submitted)
        article.reject!
        expect(article.status).to eq "rejected"
      end

      it "doesn't change the status from draft to rejected" do
        article = create(:article, status: :draft)
        article.reject!
        expect(article.status).to eq "draft"
      end
    end
  end

  describe 'filters' do
    describe 'by category' do
      it 'only selects article from a category' do
        cat = create(:category)
        create(:article, categories: [])
        article1 = create(:article, categories: [create(:category), cat])
        article2 = create(:article, categories: [cat])
        create(:article, categories: [create(:category)])
        expect(Article.by_category(cat.id)).to match_array [article1, article2]
      end
    end

    describe 'by location' do
      it 'is empty if nothing matches' do
        create(:article, country: "FR", city: "Montpellier")
        expect(Article.by_location("test")).to be_empty
      end

      it 'selects articles by city' do
        article = create(:article, country: "FR", city: "Montpellier")
        expect(Article.by_location("Montpellier")).to match_array [article]
      end

      it 'selects articles by country' do
        article = create(:article, country: "FR", city: "Montpellier")
        expect(Article.by_location("France")).to match_array [article]
      end

      it 'selects articles by continent' do
        article = create(:article, country: "FR", city: "Montpellier")
        expect(Article.by_location("Europe")).to match_array [article]
      end
    end

    describe 'search' do
      it 'is empty if nothing matches' do
        create(:article, country: "FR", city: "Montpellier")
        expect(Article.by_search("test")).to be_empty
      end

      it 'includes location in search' do
        article = create(:article, country: "FR", city: "Montpellier")
        expect(Article.by_search("France")).to match_array [article]
      end

      it 'includes title in search' do
        article = create(:article, title: "Hello world")
        expect(Article.by_search("Hello")).to match_array [article]
      end

      it 'includes author in search' do
        article = create(:article, author: create(:user, name: "Dini"))
        expect(Article.by_search("Dini")).to match_array [article]
      end

      it 'includes content in search' do
        article = create(:article, content: "Hello world")
        expect(Article.by_search("Hello")).to match_array [article]
      end

      it 'includes categories in search' do
        article = create(:article, categories: create_list(:category, 1, name: "Hello world"))
        expect(Article.by_search("Hello")). to match_array [article]
      end

      it 'includes description in search' do
        article = create(:article, description: "Hello world")
        expect(Article.by_search("Hello")).to match_array [article]
      end
    end
  end

  describe 'suggestions' do
    it 'should suggest articles from same author' do
      author = create(:user)
      article = create(:article, author: author)
      create_list(:article, 2, author: author, popularity: rand(0..9))
      create(:article)
      popular_articles = create_list(:article, 3, author: author, popularity: rand(10..20))
      expect(article.similar_by_author).to match_array popular_articles
    end

    it 'should suggest articles from same categories' do
      categories = create_list(:category, 2)
      article = create(:article, categories: categories)
      create_list(:article, 3, categories: [categories.sample], popularity: rand(0..9))
      create(:article, categories: [create(:category)])
      popular_articles = create_list(:article, 3, categories: [categories.sample], popularity: rand(10..20))
      expect(article.similar_by_categories).to match_array popular_articles
    end

    it 'should suggest articles from same location including continent' do
      article = create(:article, city: "Montpellier", country: "FR")
      create(:article, country: "IT", popularity: 3)
      create(:article, country: "ID")
      other_articles = [create(:article, country: "FR", popularity: 2)]
      other_articles << create(:article, country: "FR", popularity: 1)
      other_articles << create(:article, country: "IT", popularity: 4)
      expect(article.similar_by_location).to match_array other_articles
    end

    it 'should suggest articles from same location' do
      article = create(:article, city: "Montpellier", country: "FR")
      create(:article, country: "FR", popularity: 3)
      create(:article, country: "ID")
      other_articles = [create(:article, city: "Montpellier", country: "FR", popularity: 2),
                        create(:article, city: "Montpellier", country: "FR", popularity: 1),
                        create(:article, country: "FR", popularity: 4)]
      expect(article.similar_by_location).to match_array other_articles
    end

    it 'should suggest similar articles' do
      categories = create_list(:category, 2)
      article = create(:article, city: "Montpellier", country: "FR", categories: categories)
      create(:article, country: "FR", popularity: 0)
      create(:article, country: "ID")
      other_articles = [create(:article, city: "Montpellier", country: "FR", popularity: 2),
                        create(:article, city: "Montpellier", country: "FR", popularity: 1),
                        create(:article, country: "ID", categories: [categories.first], popularity: 4)]
      expect(article.similar).to match_array other_articles
    end
  end

  describe 'order' do
    it 'should order by most recent' do
      article1 = create(:article, published_at: 5.minutes.ago)
      article2 = create(:article, published_at: 10.minutes.ago)
      article3 = create(:article, published_at: 15.minutes.ago)
      expect(Article.most_recent).to eq [article1, article2, article3]
    end

    it 'should order by most popular' do
      article1 = create(:article, popularity: 4)
      article2 = create(:article, popularity: 3)
      article3 = create(:article, popularity: 2)
      expect(Article.most_popular).to eq [article1, article2, article3]
    end
  end
end
