class Post
  include MongoMapper::Document

  key :title, String
  key :body, String
  key :page_id, String
  timestamps!

  def body_html
    return nil unless @body
    render   = Redcarpet::Render::HTML.new(:prettify => true)
    markdown = Redcarpet::Markdown.new(render, :fenced_code_blocks => true)
    markdown.render(body)
  end
end
