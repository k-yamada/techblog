require 'nokogiri'

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
    html = get_markdown.render(body)
    doc = Nokogiri::HTML.parse(html)
    doc.css('* :not(html) :not(body)').each do |node|
      keywords.each do |keyword|
        node.inner_html = node.inner_html.gsub(keyword, "<span class='keyword-match'>#{keyword}</span>")
      end
    end
    doc.css("body").to_html
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
