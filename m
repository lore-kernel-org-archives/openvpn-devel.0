Message-ID: <c370f430-80c6-5fea-6233-042d5069a14e@...2108...>
Date: Mon, 4 Sep 2023 22:26:25 +0200
MIME-Version: 1.0
From: David Sommerseth <dazo+openvpn@...2108...>
References: <fbf44b37-f89f-9329-862c-5d1015f6a4a8@...2108...>
Content-Language: en-US
Reply-To: David Sommerseth <dazo+openvpn@...2108...>
In-Reply-To: <fbf44b37-f89f-9329-862c-5d1015f6a4a8@...2108...>
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
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

[re-sent to ML]

On 04/09/2023 19:51, Jeremy Fleischman wrote:
>> diff --git a/src/python/openvpn3/SessionManager.py
>> b/src/python/openvpn3/SessionManager.py
>> index 3632790..1a567be 100644
>> --- a/src/python/openvpn3/SessionManager.py
>> +++ b/src/python/openvpn3/SessionManager.py
>> @@ -114,6 +114,7 @@ def __init__(self, dbuscon, objpath):
>>           self.__log_callback = None
>>           self.__status_callback = None
>>           self.__deleted = False
>> +        self.__log_forward_enabled = False
>>
>>
>>       def __del__(self):
>> @@ -291,16 +292,11 @@ def LogCallback(self, cbfnc):
>>
>> dbus_interface='net.openvpn.v3.backends',
>>                                                  bus_name='net.openvpn.v3.log',
>>                                                  path=self.__session_path)
>> -            self.__session_intf.LogForward(True)
>>           else:
>> -            try:
>> -                self.__session_intf.LogForward(False)
>> -            except dbus.exceptions.DBusException:
>> -                # If this fails, the session is typically already removed
>> -                pass
>>               self.__dbuscon.remove_signal_receiver(self.__log_callback, 'Log')
>>               self.__log_callback = None
> 
> Oops, this code unconditionally removes the callback, even if there
> isn't currently a callback. The code below in StatusChangeCallback
> first checks if there is currently a callback registered before removing
> it. If `self.__dbuscon.remove_signal_receiver` is resilient to getting
> passed None values for callbacks, then I suppose would could skip the
> check and just unconditionally remove the callback.
> Let me know what's best.

If you look at my proposal; in the LogCallback() method, I have this check:

     if cbfnc is not None and self.__log_callback is None:

while you only do:

     if cbfnc is not None:

I believe you need to check both (more below on that).  And there is a 
similar logic check when disabling the callback:

     elif cbfnc is None and self.__log_callback is not None:

I believe this is the trap you fell into.  Your new patch just do an "else:"

The additional final check of setting a new callback without disabling 
the previous one can avoid some additional trouble.  IIRC, the Python 
D-Bus API will actually call multiple callbacks if add_signal_receiver() 
is called more times with different callback methods.  To support this, 
the LogCallback() and StatusChangeCallback() methods would need to track 
each callback function independently.   I did not consider this a needed 
feature just yet; hence the additional final check:

     elif (cbfnc is not None and self.__log_callback is not None):
         # In this case, the program must first disable the
         # current LogCallback() before setting a new one.
         raise RuntimeError('LogCallback() is already enabled')

This should enforce only one callback function being enabled this way, 
and if the callback need to be changed - it's enough to first do disable 
it (LogCallback(None)) before setting the new one.  And if more 
callbacks functions is wanted/needed, the additional ones can be called 
via the callback function registered with the LogCallback().  No need to 
make this code more complicated.


Otherwise, I like what you did to __set_log_forward().  That makes sense!



-- 
kind regards,

David Sommerseth
OpenVPN Inc



