class  Lync
  nameCtrl=null
  GetLyncPresenceString:(status) ->
    switch status
        when 0 then return "avaliabled"
        when 1 then return "offline"
        when 2,4,16 then return "away"
        when 3,5 then return "incall"
        when 6,7,8,10 then return "busy"
        when 9,15 then return "donotdisturb"
        else return "busy"
  SetImageClassStatus: (liTag,status )->
     (liTag).addClass "sprite-icon-status-#{this.GetLyncPresenceString(status)}"
     return
  OnStatusChange : (name, status, id) ->
    tags = $(".author").filter(->
      $(this).attr("data-user-id") is name
    )
    tags.each ->
      SetImageClassStatus this,status
      return
    return
  ShowLyncPresencePopup : ( target) ->
    userName=$(target).attr('data-user-id')
    return  unless nameCtrl
    eLeft = $(target).offset().left
    x = eLeft - $(window).scrollLeft()
    eTop = $(target).offset().top
    y = eTop - $(window).scrollTop()
    nameCtrl.ShowOOUI userName, 0, x, y
    return
  HideLyncPresencePopup : ->
    return  unless nameCtrl
    window.Lync.GetNameCtrl().HideOOUI()
    return
  InsertLynch : (author) ->
    that=this

    authorId = (author).attr("data-user-id")
    try
      nameCtrl = new ActiveXObject("Name.NameCtrl.1")
    catch err 
        nameCtrl= that.CreateNPApiOnWindowsPlugin("application/x-sharepoint-uc")
    if nameCtrl.PresenceEnabled
      nameCtrl.OnStatusChange =that.OnStatusChange 
    return

  CreateNPApiOnWindowsPlugin:(b)->
    c = null
    if IsSupportedNPApiBrowserOnWin()
      try
        c = document.getElementById(b)
        if not Boolean(c) and IsNPAPIOnWinPluginInstalled(b)
          a = document.createElement("object")
          a.id = b
          a.type = b
          a.width = "0"
          a.height = "0"
          a.style.setProperty "visibility", "hidden", ""
          document.body.appendChild a
          c = document.getElementById(b)
      catch d
            c = null
          c
  IsNPAPIOnWinPluginInstalled : (a) ->
    Boolean(navigator.mimeTypes) and navigator.mimeTypes[a] and navigator.mimeTypes[a].enabledPlugin
  IsSupportedNPApiBrowserOnWin : ->
    true # SharePoint does this: IsSupportedChromeOnWin() || IsSupportedFirefoxOnWin()
    
     
module.exports = Lync unless typeof module is ""

