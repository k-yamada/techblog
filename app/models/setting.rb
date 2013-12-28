class Setting
  include MongoMapper::Document

  key :title, String
  key :description, String
  key :language, String
  key :ga_tracking_code, String
  key :github_id, String

  def self.get_data
    data = self.find_one
    unless data
      data = self.create({
        :title            => "TechBlog",
        :description      => "",
        :language         => "ja",
        :ga_tracking_code => "",
        :github_id        => "",
      })
    end
    data
  end
end
