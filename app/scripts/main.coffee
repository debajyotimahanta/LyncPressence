(->
  window.Lync = (->
    Lync = ->
    nameCtrl = undefined
    nameCtrl = null
    Lync.GetLyncPresenceString = (status) ->
      switch status
        when 0
          "avaliabled"
        when 1
          "offline"
        when 2, 4, 16
          "away"
        when  5
          "incall"
        when 3,6, 7, 8, 10
          "busy"
        when 9, 15
          "donotdisturb"
        else
          "busy"
    Lync.GetNameCtrl= ->
      return nameCtrl
    Lync.SetImageClassStatus = (liTag, status) ->
      liTag.removeClass()
      liTag.addClass "author"
      liTag.addClass "sprite-icon-status-" + (@GetLyncPresenceString(status))
      return

    Lync::OnStatusChange = (name, status, id) ->
      that = this
      tags = undefined
      tags = $(".author").filter(->
        $(this).attr("data-user-id") is name
      )
      tags.each ->
        Lync.SetImageClassStatus $(this), status
        $(this).mouseover ->
          Lync.ShowLyncPresencePopup(this)
          return
        $(this).mouseleave ->
          console.log('out')
          Lync.HideLyncPresencePopup()
          return
        return

      return

    Lync.ShowLyncPresencePopup = (target) ->
      eLeft = undefined
      eTop = undefined
      userName = undefined
      x = undefined
      y = undefined
      userName = $(target).attr("data-user-id")
      return  unless nameCtrl
      eLeft = $(target).offset().left
      x = eLeft - $(window).scrollLeft()
      eTop = $(target).offset().top
      y = eTop - $(window).scrollTop()
      nameCtrl.ShowOOUI userName, 0, x, y
      return

    Lync.HideLyncPresencePopup = ->
      return  unless nameCtrl
      window.Lync.GetNameCtrl().HideOOUI()
      return
    Lync::InsertLyncs= ->
      that=this
      $('.author').each (index, item) ->
        that.InsertLync $(item)
        return
      return

    Lync::InsertLync = (author) ->
      authorId = undefined
      err = undefined
      that = undefined
      that = this
      authorId = author.attr("data-user-id")
      try
        nameCtrl = new ActiveXObject("Name.NameCtrl.1")
      catch _error
        err = _error
        nameCtrl = that.CreateNPApiOnWindowsPlugin("application/x-sharepoint-uc")
      if nameCtrl.PresenceEnabled
        nameCtrl.OnStatusChange = that.OnStatusChange
        nameCtrl.GetStatus authorId, "1"
      return

    Lync::CreateNPApiOnWindowsPlugin = (b) ->
      a = undefined
      c = undefined
      d = undefined
      c = null
      that = this
      if that.IsSupportedNPApiBrowserOnWin()
        try
          c = document.getElementById(b)
          if not Boolean(c) and that.IsNPAPIOnWinPluginInstalled(b)
            a = document.createElement("object")
            a.id = b
            a.type = b
            a.width = "0"
            a.height = "0"
            a.style.setProperty "visibility", "hidden", ""
            document.body.appendChild a
            c = document.getElementById(b)
        catch _error
          d = _error
          c = null
        c

    Lync::IsNPAPIOnWinPluginInstalled = (a) ->
      Boolean(navigator.mimeTypes) and navigator.mimeTypes[a] and navigator.mimeTypes[a].enabledPlugin

    Lync::IsSupportedNPApiBrowserOnWin = ->
      true

    Lync
  )()
).call this
