class App

  constructor: ->
    Ext.regModel "Weapons", ( fields: ["name"] )

    Ext.setup({
      icon: "icon.png",
      tabletStartupScreen: "tablet_startup.png",
      phoneStartupScreen: "phone_startup.png",
      glossOnIcon: false,
      onReady: =>

        @panel = new Ext.TabPanel({
          fullscreen: true
          ui: "light"
          cardSwitchAnimation: "flip"
          tabBar:
            dock: "bottom"
            scroll: "horizontal"
            sortable: false
            layout:
              pack: "center"

          items: [
            ( iconCls: "team", title: "Game", items: @__getGame() )
            ( iconCls: "favorites", title: "Achievements", items: @__getAchievements() )
            ( iconCls: "info", title: "Info", items: @__getInfo() )
            ( iconCls: "settings", title: "Settings", items: @__getSettings() )
          ]
        })

        @createMenu()
#        @modal.hide()
#        new Notification "hello world foobar"

        # initialize the game
        game.init @panel.width, @panel.height
    })


  __getGame: ->
    [ html: "<div id=\"game\" style=\"width: 100%; height: 100%; background: black\"></div>" ]

  __getAchievements: ->
    []

  __getInfo: ->
    []

  __getSettings: ->
    []

  __getWeapons: ->
    return @weapons if @weapons

    @weapons = new Ext.data.Store((
      model: "Weapons"
      sorters: "name"
      data: [
        ( name: "Small Missile" )
        ( name: "Medium Missile" )
      ]
    ))

    @weapons

  tapHandler: (button, event) ->
    switch button.text
      when "Fire!" then @fire()
      when "Skip" then @skip()
#      when "Aim" then @modal.show ( type: "slide", direction: "up" )
#      else @modal.hide()

    yes

  skip: ->
    Ext.Msg.confirm("Skip Turn", "Are you sure you want to skip your turn?", (skipTurn) =>
      @modal.hide() if skipTurn is "yes"
    )

  fire: ->
    @modal.hide()

  createMenu: ->

    menuHandler = @tapHandler.bind @

    back = [
      text: "Skip"
      ui: "back"
      handler: menuHandler
    ]

    options = [(
      xtype: "spacer"
    ), (
      xtype: "segmentedbutton"
      items: [
        ( text: "Aim", handler: menuHandler, pressed: true )
        ( text: "Power", handler: menuHandler )
        ( text: "Weapon", handler: menuHandler )
        ( xtype: "spacer" )
      ]
    ), (
      xtype: "spacer"
    )]

    forward = [
      text: "Fire!"
      ui: "forward"
      handler: menuHandler
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

    apw = new Ext.TabPanel((
      tabBar:
        dock: "bottom"
        scroll: "horizontal"
        sortable: false
        layout:
          pack: "center"

      items: [(
        title: "Aim"
        xtype: "form"
        items: [( xtype: "sliderfield" )]
      ), (
        title: "Power"
        xtype: "form"
        items: [( xtype: "sliderfield" )]
        title: "Power"
      ), (
        title: "Weapon"
        items: [( xtype: "list", store: @__getWeapons(), itemTpl: "<div><strong>[name]</strong></div>" )]
      )]
    ))

    @modal = new Ext.Panel({
      floating: true
      modal: false
      centered: false
      draggable: true
      width: 450
      height: 350
#      styleHtmlContent: true
      hideOnMaskTap: false
      dockedItems: [@dock]
      items: apw
#      [
#        xtype: "form"
#        items: [( xtype: "sliderfield" )]
#      ]
    })

    @modal.show "pop"
