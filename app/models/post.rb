class Post
  include MongoMapper::Document

  key :title, String
  key :body, String
  key :page_id, String
  timestamps!

  def body_html
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, :fenced_code_blocks => true)
    markdown.render(body)
  end
end
