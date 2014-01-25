# Usage
#   $ RAILS_ENV=production rake onetime:<task_name>

namespace :onetime do
  desc "set Post.sub_id"
  task set_post_sub_id: :environment do
    posts = Post.all
    posts.each do |post|
      if post.sub_id == nil
        p post.default_sub_id
        post.set({:sub_id => post.default_sub_id})
      end
    end
  end
end
