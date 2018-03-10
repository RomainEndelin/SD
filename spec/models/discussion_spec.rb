require 'rails_helper'

describe Discussion do
  it 'is valid with a content' do
    expect(build(:discussion)).to be_valid
  end

  it 'is invalid without a content' do
    discussion = build(:discussion, content: nil)
    discussion.valid?
    expect(discussion.errors[:content]).to include("can't be blank")
  end

  it 'is invalid without an author' do
    discussion = build(:discussion, author: nil)
    discussion.valid?
    expect(discussion.errors[:author]).to include("can't be blank")
  end

  describe 'date' do
    it 'formats the date and time properly' do
      discussion = build(:discussion, created_at: DateTime.parse('2016-01-01 12:00:00'))
      expect(discussion.date).to eq 'January 01, 2016 12:00'
    end
  end
end
