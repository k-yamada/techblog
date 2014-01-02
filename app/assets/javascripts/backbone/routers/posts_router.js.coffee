class Techblog.Routers.PostsRouter extends Backbone.Router
  initialize: (options) ->
    @posts = new Techblog.Collections.PostsCollection()
    @posts.reset options.posts

  routes:
    "new"         : "newPost"
    "index"       : "index"
    ":id/edit"    : "edit"
    ":id/destroy" : "destroy"
    ":id"         : "show"
    ".*"          : "index"

  newPost: ->
    @view = new Techblog.Views.Posts.NewView(collection: @posts)
    $("#posts").html(@view.render().el)

  index: ->
    @view = new Techblog.Views.Posts.IndexView(posts: @posts)
    $("#posts").html(@view.render().el)
    TB.Util.setStyle()

  show: (id) ->
    post = @posts.get(id)
    @view = new Techblog.Views.Posts.ShowView(model: post)
    $("#posts").html(@view.render().el)
    TB.Util.setStyle()

  edit: (id) ->
    post = @posts.get(id)
    @view = new Techblog.Views.Posts.EditView(model: post)
    $("#posts").html(@view.render().el)

  destroy: (id) ->
    if confirm "Are you sure?"
      post = @posts.get(id)
      @posts.remove(post)
      @index()
