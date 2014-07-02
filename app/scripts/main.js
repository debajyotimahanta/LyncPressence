// Generated by CoffeeScript 1.7.1
(function() {
  

  window.Lync = (function() {
    var nameCtrl;

    function Lync() {}

    nameCtrl = null;

    Lync.GetLyncPresenceString = function(status) {
      switch (status) {
        case 0:
          return "avaliabled";
        case 1:
          return "offline";
        case 2:
        case 4:
        case 16:
          return "away";
        case 3:
        case 5:
          return "incall";
        case 6:
        case 7:
        case 8:
        case 10:
          return "busy";
        case 9:
        case 15:
          return "donotdisturb";
        default:
          return "busy";
      }
    };

    Lync.SetImageClassStatus = function(liTag, status) {
      liTag.addClass("sprite-icon-status-" + (this.GetLyncPresenceString(status)));
    };

    Lync.prototype.OnStatusChange = function(name, status, id) {
      var that=this;
      var tags;
      tags = $(".author").filter(function() {
        return $(this).attr("data-user-id") === name;
      });
      tags.each(function() {
        Lync.SetImageClassStatus($(this), status);
      });
    };

    Lync.prototype.ShowLyncPresencePopup = function(target) {
      var eLeft, eTop, userName, x, y;
      userName = $(target).attr('data-user-id');
      if (!nameCtrl) {
        return;
      }
      eLeft = $(target).offset().left;
      x = eLeft - $(window).scrollLeft();
      eTop = $(target).offset().top;
      y = eTop - $(window).scrollTop();
      nameCtrl.ShowOOUI(userName, 0, x, y);
    };

    Lync.prototype.HideLyncPresencePopup = function() {
      if (!nameCtrl) {
        return;
      }
      window.Lync.GetNameCtrl().HideOOUI();
    };

    Lync.prototype.InsertLynch = function(author) {
      var authorId, err, that;
      that = this;
      authorId = author.attr("data-user-id");
      try {
        nameCtrl = new ActiveXObject("Name.NameCtrl.1");
      } catch (_error) {
        err = _error;
        nameCtrl = that.CreateNPApiOnWindowsPlugin("application/x-sharepoint-uc");
      }
      if (nameCtrl.PresenceEnabled) {
        nameCtrl.OnStatusChange = that.OnStatusChange;
        nameCtrl.GetStatus(authorId, "1");
        
      }
    };

    Lync.prototype.CreateNPApiOnWindowsPlugin = function(b) {
      var a, c, d;
      c = null;
      var that=this;
      if (that.IsSupportedNPApiBrowserOnWin()) {
        try {
          c = document.getElementById(b);
          if (!Boolean(c) && that.IsNPAPIOnWinPluginInstalled(b)) {
            a = document.createElement("object");
            a.id = b;
            a.type = b;
            a.width = "0";
            a.height = "0";
            a.style.setProperty("visibility", "hidden", "");
            document.body.appendChild(a);
            c = document.getElementById(b);
          }
        } catch (_error) {
          d = _error;
          c = null;
        }
        return c;
      }
    };

    Lync.prototype.IsNPAPIOnWinPluginInstalled = function(a) {
      return Boolean(navigator.mimeTypes) && navigator.mimeTypes[a] && navigator.mimeTypes[a].enabledPlugin;
    };

    Lync.prototype.IsSupportedNPApiBrowserOnWin = function() {
      return true;
    };

    return Lync;

  })();

  if (typeof module !== "") {
    module.exports = Lync;
  }

}).call(this);
