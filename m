From: Mathias Sundman <mathias@...209...>
Subject: Re: [Openvpn-devel] Problem with --route-method exe and --redirect-gateway
In-Reply-To: <Pine.LNX.4.58.0501220104040.3271@...41...>
Message-ID: <Pine.LNX.4.61.0501221227160.19757@...210...>
References: <Pine.LNX.4.61.0501212021010.17863@...210...>
 <Pine.LNX.4.61.0501212112490.17957@...210...> <Pine.LNX.4.58.0501220104040.3271@...41...>
MIME-Version: 1.0
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Sat Jan 22 03:41:00 2005
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 8bit
To: James Yonan <jim@...41...>
Cc: openvpn-devel@lists.sourceforge.net, Sven-Erik Fraenell <sven-erik.fraenell@...341...>

On Sat, 22 Jan 2005, James Yonan wrote:

> On Fri, 21 Jan 2005, Mathias Sundman wrote:
>
>> On Fri, 21 Jan 2005, Mathias Sundman wrote:
>>
>>> Just because someone reported about problems with route additions via IPAPI
>>> when using PPP or PPPoE adapters the other day, one of my users reported the
>>> same problem to me today. I'll try to reproduce it on my computer later to
>>> night, so we can get to the bottom with that problem.
>>>
>>> While thoubleshouting that problem, I switched to --route-method exe, but
>>> found another problem!
>>>
>>> I would call it bug in Windows route.exe rather than in OpenVPN. The problem
>>> is that when using --redirect-gateway def1, and disconnecting, OpenVPN
>>> executes the command:
>>>
>>> ROUTE DELETE 0.0.0.0 MASK 128.0.0.0
>>>
>>> The problem is that route.exe deletes both the 0.0.0.0/1, AND the real
>>> 0.0.0.0/0 route, regardless if the MASK option is used or not.
>>>
>>> I double MS will fix this, so I think we need to work around this.
>>>
>>> I can see two solutions:
>>>
>>> 1) Re-add the old default gw, like we do when not using the def1 parameter.
>>>
>>> 2) Also specify the gateway parameter on the route delete cmd. This causes
>>> route.exe only to delete the correct route.
>>
>> Here's a small patch that does the trick for me:
>>
>> $ diff -u route.c.orig route.c
>> --- route.c.orig        Sun Jan  9 18:46:28 2005
>> +++ route.c     Fri Jan 21 21:12:22 2005
>> @@ -820,8 +820,10 @@
>>
>>   #elif defined (WIN32)
>>
>> -  buf_printf (&buf, ROUTE_PATH " DELETE %s",
>> -             network);
>> +  buf_printf (&buf, ROUTE_PATH " DELETE %s MASK %s %s",
>> +             network,
>> +              netmask,
>> +              gateway);
>>
>>     msg (D_ROUTE, "%s", BSTR (&buf));
>
> This is good, though we need to be sure that this will consistently work
> for different kinds of routes.
>
> The dwForwardType fix for the IP helper API + RRAS problem shows that
> there's a certain amount of hidden complexity in the Windows routing
> engine that can potentially break things if it's not fully understood.

Yes, you're right.

I've done the following tests now on WinXP SP2 without any problems:

HOST routes (255.255.255.255)
NETWORK routes (about 10 diffrent subnet masks)
--redirect-gateway
--redirect-gateway def1
routes to the old default gateway

I've done all tests on both ethernet and PPP adapters.

/Mathias

