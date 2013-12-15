class Admin
  include MongoMapper::Document

  key :email, String
  key :title, String
  key :description, String
  key :language, String

end
