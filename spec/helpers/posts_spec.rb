require 'rails_helper'

describe PostsHelper do
  describe '#post_title' do
    it 'should return post title' do
      post = stub_model(Post, title: 'New age of IT')
      expect(post_title(post)).to eq 'New age of IT'
    end
  end

  describe '#post_short_title' do
    it 'should return the same description' do
      post = stub_model(Post, title: 'New title')
      expect(post_short_title(post)).to eq 'New title'
    end
    it 'should return short title and ...' do
      post = stub_model(Post, title: 'New age of IT')
      expect(post_short_title(post)).to eq 'New age...'
    end
  end

  describe '#post_short_description' do
    it 'should return the same text' do
      description = 'Description of New age of IT title'
      post = stub_model(Post, text: description)
      expect(post_short_description(post)).to eq description
    end
    it 'should return short text and ...' do
      description = 'Description of New age of IT title 12345670 12345670 12345670 12345670 12345670 12345670 12345670 12345670'
      post = stub_model(Post, text: description)
      expect(post_short_description(post)).to eq description.slice(0, 97).concat('...')
    end
  end
end