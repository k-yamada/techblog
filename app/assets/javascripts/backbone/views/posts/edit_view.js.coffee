Techblog.Views.Posts ||= {}

class Techblog.Views.Posts.EditView extends Backbone.View
  template : JST["backbone/templates/posts/edit"]
  events :
    "submit #edit-post" : "update"
    "click #btn_write"  : "showEditor"
    "click #btn_preview": "preview"

  update : (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.save(null,
      success : (post) =>
        @model = post
        window.location.hash = "/#{@model.id}"
    )

  showEditor: ->
    $("#btn_preview").removeClass("active")
    $("#btn_write").addClass("active")

  preview: ->
    $("#btn_write").removeClass("active")
    $("#btn_preview").addClass("active")

  render : ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
