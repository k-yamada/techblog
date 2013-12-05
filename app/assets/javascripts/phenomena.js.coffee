window.Techblog =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  init: ->
    new Techblog.Routers.Companies()
    Backbone.history.start()
