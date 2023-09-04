MIME-Version: 1.0
References: <20230709231929.195048-1-jeremyfleischman@...277...>
 <a647bbd5.AWYAACY5qkoAAAAAAAAAAW9e-ykAAYCsnhYAAAAAABXTlQBk9Q8z@...2677...>
 <CAHpv4cMjwtdViA8A0yqZjpeTk0Syb6jZogm4oNXsQ+bM1XMTjA@...278...>
In-Reply-To: <CAHpv4cMjwtdViA8A0yqZjpeTk0Syb6jZogm4oNXsQ+bM1XMTjA@...278...>
From: Jeremy Fleischman <jeremyfleischman@...277...>
Date: Mon, 4 Sep 2023 10:51:25 -0700
Message-ID: <CAHpv4cNRXMzmYV_s7qafY_g2yO0A_SmjdT32kqpLZAUd6xdTSA@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Fix StatusChangeCallback so it works
 without a LogCallback
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: David Sommerseth <dazo+openvpn@...2108...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

> diff --git a/src/python/openvpn3/SessionManager.py
> b/src/python/openvpn3/SessionManager.py
> index 3632790..1a567be 100644
> --- a/src/python/openvpn3/SessionManager.py
> +++ b/src/python/openvpn3/SessionManager.py
> @@ -114,6 +114,7 @@ def __init__(self, dbuscon, objpath):
>          self.__log_callback = None
>          self.__status_callback = None
>          self.__deleted = False
> +        self.__log_forward_enabled = False
>
>
>      def __del__(self):
> @@ -291,16 +292,11 @@ def LogCallback(self, cbfnc):
>
> dbus_interface='net.openvpn.v3.backends',
>                                                 bus_name='net.openvpn.v3.log',
>                                                 path=self.__session_path)
> -            self.__session_intf.LogForward(True)
>          else:
> -            try:
> -                self.__session_intf.LogForward(False)
> -            except dbus.exceptions.DBusException:
> -                # If this fails, the session is typically already removed
> -                pass
>              self.__dbuscon.remove_signal_receiver(self.__log_callback, 'Log')
>              self.__log_callback = None

Oops, this code unconditionally removes the callback, even if there
isn't currently a callback. The code below in StatusChangeCallback
first checks if there is currently a callback registered before removing
it. If `self.__dbuscon.remove_signal_receiver` is resilient to getting
passed None values for callbacks, then I suppose would could skip the
check and just unconditionally remove the callback.
Let me know what's best.

>
> +        self.__set_log_forward()
>
>      ##
>      #  Subscribes to the StatusChange signals for this session and register
> @@ -318,10 +314,14 @@ def StatusChangeCallback(self, cbfnc):
>                                                 bus_name='net.openvpn.v3.log',
>                                                 path=self.__session_path)
>          else:
> -            self.__dbuscon.remove_signal_receiver(self.__status_callback,
> -                                                  'StatusChange')
> -            self.__status_callback = None
> +            # Only remove the callback if there actually *is* a callback
> +            # currently.
> +            if self.__status_callback is not None:
> +                self.__dbuscon.remove_signal_receiver(self.__status_callback,
> +                                                      'StatusChange')
> +                self.__status_callback = None
>
> +        self.__set_log_forward()
>
>
>      ##
> @@ -417,6 +417,30 @@ def GetDCO(self):
>      def SetDCO(self, dco):
>          self.__prop_intf.Set('net.openvpn.v3.sessions', 'dco', dco)
>
> +    ##
> +    #  Internal method to enable/disable LogForward as needed.
> +    #  Must be called whenever a callback that needs LogForward enabled is
> +    #  added or removed.
> +    #
> +    def __set_log_forward(self):
> +        # The LogCallback and the StatusChangeCallback both need LogForward
> +        # enabled. In other words, LogForward should be enabled iff one or both
> +        # of those callbacks are registered.
> +        should_log_forward_be_enabled = (
> +            self.__log_callback is not None or self.__status_callback
> is not None
> +        )
> +
> +        if should_log_forward_be_enabled and not self.__log_forward_enabled:
> +            self.__session_intf.LogForward(True)
> +            self.__log_forward_enabled = True
> +        elif not should_log_forward_be_enabled and self.__log_forward_enabled:
> +            try:
> +                self.__session_intf.LogForward(False)
> +            except dbus.exceptions.DBusException:
> +                # If this fails, the session is typically already removed
> +                pass
> +
> +            self.__log_forward_enabled = False
>
>
>  ##

