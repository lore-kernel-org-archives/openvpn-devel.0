Message-ID: <8d81c30e-06e1-adc0-e504-7949c0219d9e@...2108...>
Date: Mon, 4 Sep 2023 00:56:45 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20230709231929.195048-1-jeremyfleischman@...277...>
From: David Sommerseth <dazo+openvpn@...2108...>
In-Reply-To: <20230709231929.195048-1-jeremyfleischman@...277...>
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
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Jeremy Fleischman <jeremyfleischman@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>


Hi Jeremy,

First of all; sorry it's taken so long time to get back to you.  GH 
issue #171 has unfortunately taken most of my time, so this patch went 
on the side burner.

I've looked at your patch, and I wonder if it can be done a bit simpler. 
  I'm open to hear your views; I might have overlooked some details.


On 10/07/2023 01:19, Jeremy Fleischman wrote:
[...snip...]
> @@ -285,22 +286,24 @@ def GetFormattedStatistics(self, prefix='Connection statistics:\n', format_str='
>       #
>       def LogCallback(self, cbfnc):
>           if cbfnc is not None:
> +            # Remove the existing callback if there is one.
> +            if self.__log_callback is not None:
> +                self.LogCallback(None)
> +
>               self.__log_callback = cbfnc
>               self.__dbuscon.add_signal_receiver(cbfnc,
>                                                  signal_name='Log',
>                                                  dbus_interface='net.openvpn.v3.backends',
>                                                  bus_name='net.openvpn.v3.log',
>                                                  path=self.__session_path)
> -            self.__session_intf.LogForward(True)
> +            self.__add_LogForward_receiver()


I'm wondering if this could be made cleared.  The recursion is kinda 
clever, but feels like it hides the purpose.

Wouldn't this code below work just as well (consider this more a concept 
code than proper Python code)?  Here there is no recursion and no 
reference counting which could go wrong.

------------------------------------------------------------------------
class Session(object):
      [...]
      self.__log_forward_enabled = False

      def LogCallback(self, cbfnc):	
	if cbfnc is not None and self.__log_callback is None:
	    # Log Callback function is being enabled; not
             # set before
             self.__log_callback = cbfnc
	    self.__dbuscon.add_signal_receiver(cbfnc, ...)
	    self.__set_log_forward(True)

	elif cbfnc is None and self.__log_callback is not None:
	    # Log Callback function is being disabled; can only
             # happen because it was set
             self.__dbuscon.remove_signal_receiver(self.__log_callback,
                                                   ...)
             self.__log_callback = None
	    try:
		self.__set_log_forward(False)
	    except dbus.exception.DBusException:
		pass

	elif (cbfnc is not None and self.__log_callback is not None):
             # In this case, the program must first disable the
             # current LogCallback() before setting a new one.
	    raise RuntimeErrpr('LogCallback() is already enabled')

	# No need to complain if unsetting an unset log callback
         # function; this will not have any behavioral impact at all.




      def __set_log_forward(self, enable):
          # This method can only be called *after* callback
          # function has been set in this object

          if not self.__log_forward_enabled and enable:
              # If log forwarding is disabled it can be enabled
              self.__log_forward_enabled = True
              self.__session_intf.LogForward(True)

	 elif self.__log_forward_enabled and not enable:
              # Log forwarding can only be disabled if
              # both Log and StatusChange callbacks are unset
	     if (self.__log_callback is None)
                 and (self.__status_callback is None):
		 self.__log_forward_enabled = False
                  self.__session_intf.LogForward(False)

------------------------------------------------------------------------

The StatusChangeCallback() would need a similar implementation as 
LogCallback() too.

In regards to multi-threading; I would not expect this code to be used 
in a multi-threaded setup where different callbacks would be 
enabled/disabled on the fly in parallel.  But it might be good to add 
this as a comment in general, that these methods are not considered 
thread-safe.  However, since the code snippets above does not use 
reference counting, it should be a bit more robust as it bases the 
decision on the value of the callback function pointers.


Thoughts?


-- 
kind regards,

David Sommerseth
OpenVPN Inc



