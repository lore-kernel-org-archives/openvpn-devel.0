Message-ID: <7fb1ade0-0a4c-97b8-f092-2a6917d011c5@...2108...>
Date: Tue, 5 Sep 2023 01:09:00 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <fbf44b37-f89f-9329-862c-5d1015f6a4a8@...2108...>
 <c370f430-80c6-5fea-6233-042d5069a14e@...2108...>
 <CAHpv4cM_p+zAvCyqmu5cW1aVhM9DoOtRhW5svrBpsVNdj83j1g@...278...>
From: David Sommerseth <dazo+openvpn@...2108...>
In-Reply-To: <CAHpv4cM_p+zAvCyqmu5cW1aVhM9DoOtRhW5svrBpsVNdj83j1g@...278...>
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

On 04/09/2023 23:27, Jeremy Fleischman wrote:
>>       elif (cbfnc is not None and self.__log_callback is not None):
>>           # In this case, the program must first disable the
>>           # current LogCallback() before setting a new one.
>>           raise RuntimeError('LogCallback() is already enabled')
>>
>> This should enforce only one callback function being enabled this way,
>> and if the callback need to be changed - it's enough to first do disable
>> it (LogCallback(None)) before setting the new one.  And if more
>> callbacks functions is wanted/needed, the additional ones can be called
>> via the callback function registered with the LogCallback().  No need to
>> make this code more complicated.
> 
> That makes sense! I *think* things get a little cleaner if we move this check
> to the top of the relevant functions (StatusChangeCallback and LogCallback).
> Basically, by first eliminating the possibility that we're changing an existing
> registered dbus callback, then we don't actually need to be as careful later on.
> For example, here's an updated version of LogCallback:
> 
>      def LogCallback(self, cbfnc):
>          if cbfnc is not None and self.__log_callback is not None:
>              # In this case, the program must first disable the
>              # current LogCallback() before setting a new one.
>              raise RuntimeError('LogCallback() is already enabled')
> 
>          if cbfnc is not None:
>              self.__log_callback = cbfnc
>              self.__dbuscon.add_signal_receiver(cbfnc,
>                                                 signal_name='Log',
>                                                 dbus_interface='net.openvpn.v3.backends',
>                                                 bus_name='net.openvpn.v3.log',
>                                                 path=self.__session_path)
>          else:
>              # Only remove the callback if there actually *is* a callback
>              # currently.
>              if self.__log_callback is not None:
>                  self.__dbuscon.remove_signal_receiver(self.__log_callback, 'Log')
>                  self.__log_callback = None
> 
>          self.__set_log_forward()
> 
> Does this seem safe?

I have a feeling we're missing a check here.

The first check (with the raise RuntimeError), cbfnc and __log_callback 
are both set.

Next check will enable the signal receiver if cbfnc is set.  The 
previous check enforces __log_callback to not be set in this case; this 
is probably fine - but should have a comment of this condition.

The else: clause I'm less convinced about.  If cbfnc is None, 
__log_callback can also be None, which would trigger a 
remove_signal_receiver() call.  We should avoid that.

> I'm not familiar with path email etiquette/best practices. Let me know
> if/when I should send a fully updated patch.

So far, we've discussed possible solutions - so it has been fine doing 
it like this now.  But I think with this last round, we can go for a v2 
patch.


-- 
kind regards,

David Sommerseth
OpenVPN Inc



