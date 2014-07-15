class Post
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Taggable
  paginates_per 10

  field :title, type: String
  field :body, type: String
  field :sub_id, type: String
  index({ sub_id: 1 }, { unique: true })

  def body_html(opts={})
    return nil unless body
    get_markdown.render(body)
  end

  def body_html_by_line_count(line_count)
    return nil unless body
    get_markdown.render(body.split("\n")[0..line_count].join("\n"))
  end

  def body_html_by_keywords(keywords)
    return nil unless body
    _body = nil
    keywords.each do |keyword|
      matches = []
      body.scan(/.{1,40}#{keyword}.{1,40}/).each do |match|
        matches << match.gsub(keyword, "<em>#{keyword}</em>")
      end
      _body = matches.join("...") + "..."
    end
    _body
  end

  def created_at_fmt
    created_at.strftime("%e %B %Y")
  end

  def default_sub_id
    time = created_at ? created_at : Time.now
    time.strftime("%Y/%m/%d/%H%M%S")
  end

  private
    def get_markdown
      render   = Redcarpet::Render::HTML.new(:prettify => true)
      markdown = Redcarpet::Markdown.new(render,
        :fenced_code_blocks => true,
        :tables => true,
        :autolink => true,
        :strikethrough => true
      )
    end
end
