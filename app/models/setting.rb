class Setting
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, type: String
  field :description, type: String
  field :about, type: String
  field :language, type: String
  field :ga_tracking_code, type: String
  field :github_id, type: String
  field :twitter_id, type: String
  field :facebook_url, type: String

  def self.get_data
    data = self.first
    unless data
      data = self.create({
        :title            => "TechBlog",
        :description      => "",
        :language         => "ja",
        :ga_tracking_code => "",
        :github_id        => "",
        :twitter_id       => "",
        :facebook_url     => ""
      })
    end
    data
  end
end
