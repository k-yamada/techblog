class Techblog.Models.Post extends Backbone.Model
  paramRoot: 'post'

  defaults:
    title: null
    body: null
    page_id: null


class Techblog.Collections.PostsCollection extends Backbone.Collection
  model: Techblog.Models.Post
  url: '/posts'
