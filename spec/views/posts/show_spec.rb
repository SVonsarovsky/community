require 'rails_helper'

describe 'posts/show.html.erb' do
  it "displays the post's title" do
    assign(:post, stub_model(Post, :title => 'Cool title'))
    render
    #expect(rendered).to match /Cool title/m
    #expect(rendered).to contain('Cool title')
    expect(rendered).to have_content('Cool title')
  end
end