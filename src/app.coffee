Ext.setup
  tabletStartupScreen: "tablet_startup.png"
  phoneStartupScreen: "phone_startup.png"
  icon: "icon.png"
  glossOnIcon: false
  onReady: ->
    game.init()

    tapHandler = (button, event) ->
      yes

    buttons = [
      text: "Back",
      ui: "back",
      handler: tapHandler
    ]

    dockedItems = [
      xtype: "toolbar",
      dock: "top",
      items: buttons
    ]

    new Ext.Panel((
      id: "toolbartxt",
      fullscreen: yes,
      dockedItems: dockedItems,
      defaults:
        scroll: "vertical",
        xtype: "panel",
        layout: "hbox",
        pack: "justify",
        align: "center",
        defaults:
          xtype: "button",
          ui: "confirm"
    ))
