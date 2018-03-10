require 'rails_helper'

describe Category do
  it 'is valid with correct attributes' do
    expect(build(:category)).to be_valid
  end

  it 'is invalid without a name' do
    category = build(:category, name: nil)
    category.valid?
    expect(category.errors[:name]).to include("can't be blank")
  end

  it 'is invalid with name duplicate' do
    create(:category, name: "Food")
    category = build(:category, name: "Food")
    category.valid?
    expect(category.errors[:name]).to include("has already been taken")
  end

  it 'is attached to articles' do
    category = create(:category)
    articles = Array.new(3){ create(:article, categories: [category]) }
    expect(category.articles).to match_array articles
  end
end
