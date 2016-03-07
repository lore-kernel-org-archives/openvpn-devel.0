Message-ID: <456C3CCF740F41DF9D6210172868AD4C@...2089...>
From: <debbie10t@...277...>
References: <2BE9E186EE9A49CCA063BEC9E3E38F20@...2089...>
	<CAKuzo_iBQUDyT6fqygSOn==xAts1i7UsyiATaZhB6e8auSkP1Q@...278...>
	<56DDA0D0.1090107@...1227...>
Date: Mon, 7 Mar 2016 18:03:35 -0000
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] Samsung Galaxy S6 to android 6.0.1 powersave
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; format=flowed; charset="Windows-1252";
	reply-type=original
Content-Transfer-Encoding: 7bit
To: Arne Schwabe <arne@...1227...>, Selva Nair <selva.nair@...277...>
Cc: openvpn-devel@lists.sourceforge.net, openvpn-users@lists.sourceforge.net

----- Original Message ----- 
From: "Arne Schwabe" <arne@...1227...>
To: "Selva Nair" <selva.nair@...277...>; "Debbie Tent" <debbie10t@...277...>
Cc: <openvpn-devel@lists.sourceforge.net>;
<openvpn-users@lists.sourceforge.net>
Sent: Monday, March 07, 2016 3:40 PM
Subject: Re: [Openvpn-devel] Samsung Galaxy S6 to android 6.0.1 powersave


>
>
> Am 07.03.16 um 16:28 schrieb Selva Nair:
>> Hi,
>>
>> On Mon, Mar 7, 2016 at 9:55 AM, <debbie10t@...277...
>> <mailto:debbie10t@...277...>> wrote:
>>
>>     An interesting tid-bit about Samsung Galaxy S6 to android 6.0.1
>>     and OpenVPN Connect
>>
>>     https://forums.openvpn.net/post59478.html#p59478
>>
>>
>> Sounds, suspiciously similar to the sleep-resume issue we had on
>> windows.. The interface probably suspends and openvpn exits?
>>
> In this case that is again some Samsung "optmization". If there is one
> manufacture of Android that consistently breaks things it is Samsung. I
> have no idea what new idea they now had to break the VPNService when
> combined with powersaving features or if OpenVPN Connect is doing
> something wrong but normally the app is notified by an onRevoke call
> before the tun device is closed.
>
> Arne
>

I just thought it was interesting that somebody found
*a* solution to what seems to be a common problem
and it was worth letting ppl here know.

regards



