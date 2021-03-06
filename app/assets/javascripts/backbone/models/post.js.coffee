class Techblog.Models.Post extends Backbone.Model
  paramRoot: 'post'

  defaults:
    title: null
    body: null
    sub_id: null
    created_at: null
    updated_at: null
    tags: []


class Techblog.Collections.PostsCollection extends Backbone.Collection
  model: Techblog.Models.Post
  url: '/posts'
