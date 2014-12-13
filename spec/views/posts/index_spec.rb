require 'rails_helper'

describe 'posts/index.html.erb' do
  it 'renders _post partial for each post' do
    assign(:posts, [stub_model(Post), stub_model(Post)])
    render
    expect(view).to render_template(:partial => '_post', :count => 2)
  end

  it 'has posts list selector' do
    assign(:posts, [stub_model(Post), stub_model(Post)])
    render
    expect(rendered).to have_selector('#posts')
  end
end