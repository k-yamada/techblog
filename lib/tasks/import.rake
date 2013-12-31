require 'sqlite3'
require 'pp'

namespace :import do
  desc "import from lokka"
  task from_lokka: :environment do
    if Admin.count == 0
      raise "Error: please create admin account"
    end

    admin = Admin.find_one
    db = SQLite3::Database.new(ENV["LOKKA_DB"])
    columns = [
      :id,               # 0
      :user_id,          # 1
      :category_id,      # 2
      :title,            # 3
      :body,             # 4
      :frozen_tag_list,  # 5
      :created_at,       # 6
      :updated_at,       # 7
    ]
    db.execute("select #{columns.join(',')} from entries") do |row|
      pp row[3]
      post_params = {
        :title        => row[3],
        :body         => row[4],
        :url          => row[0],
        :created_at   => row[6],
        :updated_at   => row[7],
      }
      post = Post.create(post_params)
      post.tag(row[5], admin)
    end
  end
end
