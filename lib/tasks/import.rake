require 'sqlite3'
require 'pp'

namespace :import do
  desc "import from lokka"
  task from_lokka: :environment do
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
      post_params = {
        :title        => row[3],
        :body         => row[4],
        :url          => row[0],
        :tags         => row[5].split(','),
        :created_at   => row[6],
        :updated_at   => row[7],
      }
      Post.create(post_params)
    end
  end
end
