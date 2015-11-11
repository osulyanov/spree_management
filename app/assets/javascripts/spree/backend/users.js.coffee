$ ->
  $('#by_role').on "change", (e) ->
    $(@).closest('form').submit()
