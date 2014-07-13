class Post
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Taggable
  paginates_per 5

  field :title, type: String
  field :body, type: String
  field :sub_id, type: String
  index({ sub_id: 1 }, { unique: true })

  attr_accessor :keywords

  def body_html(keywords=nil)
    return nil unless body
    if keywords
      _body = nil
      keywords.each do |keyword|
        matches = []
        body.scan(/.{1,40}#{keyword}.{1,40}/).each do |match|
          matches << match.gsub(keyword, "<em>#{keyword}</em>")
        end
        _body = matches.join("...") + "..."
      end
      return _body
    else
      render   = Redcarpet::Render::HTML.new(:prettify => true)
      markdown = Redcarpet::Markdown.new(render,
        :fenced_code_blocks => true,
        :tables => true,
        :autolink => true,
        :strikethrough => true
      )
      markdown.render(body)
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
