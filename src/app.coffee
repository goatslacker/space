class App

  constructor: ->
    Ext.setup({
      icon: "icon.png",
      tabletStartupScreen: "tablet_startup.png",
      phoneStartupScreen: "phone_startup.png",
      glossOnIcon: false,
      onReady: =>

        panel = new Ext.TabPanel({
          style: "background: black"
          fullscreen: true
          ui: "light"

          tabBar:
            dock: "bottom"
            scroll: "horizontal"
            sortable: true
            layout:
              pack: "center"

          cls: "card1"
          items: [
            ( iconCls: "team", title: "Game" )
            ( iconCls: "favorites", title: "Achievements" )
            ( iconCls: "info", title: "Info" )
            ( iconCls: "settings", title: "Settings" )
          ]
          dockedItems: @createMenu()
        })

        # initialize the game
        game.init panel.width, panel.height
    })

  tapHandler: (button, event) ->
    yes

  createMenu: ->

    back = [
      text: "Skip"
      ui: "back"
      handler: @tapHandler
    ]

    options = [(
      xtype: "spacer"
    ), (
      xtype: "segmentedbutton"
      items: [
        ( text: "Aim", handler: @tapHandler )
        ( text: "Power", handler: @tapHandler )
        ( text: "Weapon", handler: @tapHandler )
        ( xtype: "spacer" )
      ]
    ), (
      xtype: "spacer"
    )]

    forward = [
      text: "Fire!"
      ui: "forward"
      handler: @tapHandler
    ]

    dock =
      xtype: "toolbar"
      ui: "light"
      dock: "top"
      items: back.concat options.concat forward
      defaults:
        disabled: true

    [dock]
