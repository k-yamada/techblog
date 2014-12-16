Techblog.Views.Images ||= {}

class Techblog.Views.Images.IndexView extends Backbone.View
  template: JST["backbone/templates/images/index"]
  tagName: 'div'
  events:
    'shown'              : 'shown'
    'hidden'             : 'hidden'
    'click .select-group': 'select'

  hidden: () ->
    @remove()
    false

  shown: () ->
    false

  render: (groups) ->
    $(@el).html(@template())
    @$('.modal').modal({'show': true, 'keyboard': true, 'backdrop': true})
    @

  show: () ->
#    return if ScWeb.is_render_group_dialog
#    Util.setTimeoutFlag("is_render_group_dialog", 2000)
#
#    $.get '/users/groups', (groups) =>
#      $(".panel-container.selected").removeClass("selected")
    $(document.body).append(@render().el);

  submit: ->
    @$('.modal').modal('hide')

  select: (ev) ->
    group = JSON.parse($(ev.target).attr("data-group-json"))
    @selectGroup(group)
    false

  initialize: () ->
    #@options.images.bind('reset', @addAll)

  addAll: () =>
    @options.images.each(@addOne)

  addOne: (image) =>
    view = new Techblog.Views.Images.ImageView({model : image})
    @$(".images").append(view.render().el)
