References: <1509930876-30728-1-git-send-email-selva.nair@...277...>
 <1516815105-17882-1-git-send-email-selva.nair@...277...>
 <2f187b23-c53f-94cb-6a58-d5c9c14b5da1@...1147...>
 <663a0e1d-0d21-6f40-851e-78d770bec68f@...1147...>
 <CAKuzo_i4Ge=3cbg3zZY61ps+wDi8eCC1M4dopNJKGoB-LmT0Qw@...278...>
From: Jan Just Keijser <janjust@...1147...>
Message-ID: <cba28408-81d0-5295-c882-f4bfdfcc20c3@...1147...>
Date: Fri, 26 Jan 2018 16:20:42 +0100
MIME-Version: 1.0
In-Reply-To: <CAKuzo_i4Ge=3cbg3zZY61ps+wDi8eCC1M4dopNJKGoB-LmT0Qw@...278...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH v3] Use lowest metric interface when
 multiple interfaces match a route
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi Selva,



On 26-Jan-18 16:08, Selva Nair wrote:
> On Fri, Jan 26, 2018 at 8:23 AM, Jan Just Keijser <janjust@...1147...> wrote:
>> On 26/01/18 14:11, Jan Just Keijser wrote:
>>> the patch works as expected but I did notice something in the openvpn log
>>> :
>>>
>>> Fri Jan 26 14:08:09 2018 do_ifconfig, tt->did_ifconfig_ipv6_setup=1
>>> Fri Jan 26 14:08:10 2018 NETSH: C:\Windows\system32\netsh.exe interface
>>> ipv6 set address interface=17 2001:610:120::200:0:1001 store=active
>>> Fri Jan 26 14:08:10 2018 add_route_ipv6(2001:610:120::200:0:0/112 ->
>>> 2001:610:120::200:0:1001 metric 0) dev vpn0
>>> Fri Jan 26 14:08:10 2018 C:\Windows\system32\netsh.exe interface ipv6 add
>>> route 2001:610:120::200:0:0/112 interface=17 fe80::8 store=active
>>> Fri Jan 26 14:08:10 2018 env_block: add
>>> PATH=C:\Windows\System32;C:\Windows;C:\Windows\System32\Wbem
>>>
>>> the route was added with the default GW of fe80::8 : should I be worried ?
>>> Note that this also happened with the regular 2.4.4 version of OpenVPN and
>>> also note that the TAP adapter on my Win7 laptop is named 'vpn0'
>>>
>> arrrgh, the important line is missing:
>>   ERROR: Windows route add ipv6 command failed: returned error code 1
> Gert has explained the fe80::8 magic.
>
> Here is my guess about the ERROR: The route already existed and so
> errored trying to add again -- most likely from a previous run as it
> seems we have a problem in deleting the route on exit (I guess this is
> on Windows 10) (see Trac 1003:
> https://community.openvpn.net/openvpn/ticket/1003 )
>
> "netsh int ipv6 show route" will confirm that.
>
> The route destinations have their host bits zeroed out before setting
> route, but those bits reappear (which is strange)  in route delete.
> And netsh doesnt like that at least on Windows 10. Gert, any idea why
> this happens?
>
this is on *Windows 7*  and indeed that route is never deleted when 
OpenVPN exits. Here's the error associated with *that*:

Fri Jan 26 16:13:08 2018 ERROR: Windows route delete ipv6 command 
failed: returned error code 1
Fri Jan 26 16:13:09 2018 NETSH: C:\Windows\system32\netsh.exe interface 
ipv6 delete address vpn0 2001:610:120::200:0:1001 store=active
Fri Jan 26 16:13:09 2018 TAP: DHCP address released

C:\Users\janjust\OpenVPN\config> C:\Windows\system32\netsh.exe interface 
ipv6 delete route 2001:610:120::200:0:1001/112
interface=17 fe80::8 store=active
The parameter is incorrect.


HTH,

JJK


