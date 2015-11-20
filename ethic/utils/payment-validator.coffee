module.exports =
  makeValidator: (fn, msg) ->
    (value) ->
      if not fn value
        return msg
