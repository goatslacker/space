class Notification

  constructor: (@msg = null) ->
    return false if @msg is null

    @value = new Ext.Panel({
      floating: true
      modal: false
      centered: false
      width: Notification.WIDTH
      height: Notification.HEIGHT
      styleHtmlContent: true
      scroll: "vertical"
      html: @msg
    })

    @value.show Notification.ANIMATION

Notification.ANIMATION = "pop"
Notification.WIDTH = 250
Notification.HEIGHT = 100
