window.TB ||= {}

class TB.Util
  @setStyle: ->
    prettyPrint()
    $("table").addClass("table table-striped")
