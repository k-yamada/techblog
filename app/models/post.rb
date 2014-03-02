class Post
  include MongoMapper::Document
  include ActsAsMongoTaggable
  paginates_per 5

  key :title, String
  key :body, String
  key :sub_id, String, :unique => true, :required => true
  timestamps!

  attr_accessor :keyword

  def title
    if @keyword
      @title.gsub(@keyword, "<em>#{@keyword}</em>")
    else
      @title
    end
  end

  def body_html
    return nil unless @body
    if @keyword
      matches = []
      @body.scan(/.{1,40}#{@keyword}.{1,40}/).each do |match|
        matches << match.gsub(@keyword, "<em>#{@keyword}</em>")
      end
      @body = matches.join("...") + "..."
    else
      render   = Redcarpet::Render::HTML.new(:prettify => true)
      markdown = Redcarpet::Markdown.new(render,
        :fenced_code_blocks => true,
        :tables => true,
        :autolink => true,
        :strikethrough => true
      )
      markdown.render(@body)
    end
  end

  def created_at_fmt
    created_at.strftime("%e %B %Y")
  end

  def default_sub_id
    time = created_at ? created_at : Time.now
    time.strftime("%Y/%m/%d/%H%M%S")
  end
end
