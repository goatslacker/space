class App

  constructor: ->
    Ext.setup({
      icon: "icon.png",
      tabletStartupScreen: "tablet_startup.png",
      phoneStartupScreen: "phone_startup.png",
      glossOnIcon: false,
      onReady: =>

        @panel = new Ext.TabPanel({
          style: "background: black"
          fullscreen: true
          ui: "light"

          tabBar:
            dock: "bottom"
            scroll: "horizontal"
            sortable: false
            layout:
              pack: "center"

          cls: "card1"
          items: [
            ( iconCls: "team", title: "Game" )
            ( iconCls: "favorites", title: "Achievements" )
            ( iconCls: "info", title: "Info" )
            ( iconCls: "settings", title: "Settings" )
          ]
        })

        @createMenu()
#        @modal.hide()
#        new Notification "hello world foobar"

        # initialize the game
        game.init @panel.width, @panel.height
    })

  tapHandler: (button, event) ->
#    switch button.text
#      when "Aim" then @modal.show ( type: "slide", direction: "up" )
#      else @modal.hide()

    yes

  createMenu: ->

    back = [
      text: "Skip"
      ui: "back"
      handler: @tapHandler
    ]

    modalDialogHandler = @tapHandler.bind @

    options = [(
      xtype: "spacer"
    ), (
      xtype: "segmentedbutton"
      items: [
        ( text: "Aim", handler: modalDialogHandler, pressed: true )
        ( text: "Power", handler: modalDialogHandler )
        ( text: "Weapon", handler: modalDialogHandler )
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

    @dock = new Ext.Toolbar((
      showAnimation:
        type: "slide"
        direction: "down"
      ui: "light"
      dock: "top"
      items: back.concat options.concat forward
      defaults:
        disabled: false
    ))

    @modal = new Ext.Panel({
      floating: true
      modal: false
      centered: false
      draggable: true
      width: 450
      height: 350
#          styleHtmlContent: true
      hideOnMaskTap: false
      dockedItems: [@dock]
      html: ""
    })

    @modal.show "pop"
