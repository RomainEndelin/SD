require 'rails_helper'

describe Comment do
  it 'is valid with a content' do
    expect(build(:comment)).to be_valid
  end

  it 'is invalid without a content' do
    comment = build(:comment, content: nil)
    comment.valid?
    expect(comment.errors[:content]).to include("can't be blank")
  end

  it 'is invalid without an author' do
    comment = build(:comment, author: nil)
    comment.valid?
    expect(comment.errors[:author]).to include("can't be blank")
  end

  describe 'date' do
    it 'formats the date and time properly' do
      comment = build(:comment, created_at: DateTime.parse('2016-01-01 12:00:00'))
      expect(comment.date).to eq 'January 01, 2016 12:00'
    end
  end
end
