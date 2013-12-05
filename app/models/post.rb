class Post
  include MongoMapper::Document

  key :title, String
  key :body, String
  key :page_id, String
  timestamps!
end
