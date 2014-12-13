module PostsHelper
  def post_short_description(post)
    text = (post.text.nil?) ? '...' : post.text
    text = text.slice(0, 97).concat('...') if text.length > 100
    text
  end
  def post_short_title(post)
    title = (post.title.nil?) ? '...' : post.title
    title = title.slice(0, 7).concat('...') if title.length > 10
    title
  end
  def post_title(post)
    post.title
  end
end
