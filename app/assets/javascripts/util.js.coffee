window.TB ||= {}

class TB.Util
  @setStyle: ->
    $("pre").addClass("highlight")
    prettyPrint()
    $("table").addClass("table table-striped")
