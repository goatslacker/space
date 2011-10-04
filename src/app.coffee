Ext.setup
  tabletStartupScreen: "tablet_startup.png"
  phoneStartupScreen: "phone_startup.png"
  icon: "icon.png"
  glossOnIcon: false
  onReady: ->

    tapHandler = (button, event) ->
      yes

    back = [
      text: "Skip"
      ui: "back"
      handler: tapHandler
    ]

    options = [
      xtype: "segmentedbutton"
      items: [
        ( text: "Aim", handler: tapHandler )
        ( text: "Power", handler: tapHandler )
        ( text: "Weapon", handler: tapHandler )
      ]
    ]

    forward = [
      text: "Fire!"
      ui: "forward"
      handler: tapHandler
    ]

    panel = new Ext.Panel((
      id: "toolbartxt"
      style: "background-color: black"
      fullscreen: yes
      dockedItems: [
        xtype: "toolbar"
        dock: "bottom"
        items: back.concat options.concat forward
      ]
      defaults:
        scroll: "vertical"
        xtype: "panel"
        layout: "hbox"
        pack: "justify"
        align: "center"
    ))

    # FIXME
    Game.WIDTH = panel.width
    Game.HEIGHT = panel.height

    game = new Game
    game.init()
