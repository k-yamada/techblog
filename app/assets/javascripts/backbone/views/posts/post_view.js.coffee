Techblog.Views.Posts ||= {}

class Techblog.Views.Posts.PostView extends Backbone.View
  template: JST["backbone/templates/posts/post"]

  events:
    "click .destroy" : "destroy"

  tagName: "article"

  destroy: () ->
    if confirm "Are you sure?"
      @model.destroy()
      this.remove()
    return false

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    $(this.el).find("pre").addClass("highlight")
    return this
