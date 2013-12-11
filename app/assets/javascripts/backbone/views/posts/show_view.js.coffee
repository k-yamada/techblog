Techblog.Views.Posts ||= {}

class Techblog.Views.Posts.ShowView extends Backbone.View
  template: JST["backbone/templates/posts/show"]

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    $(this.el).find("pre").addClass("highlight")
    return this
