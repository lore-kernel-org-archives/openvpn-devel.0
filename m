Message-ID: <83d19b4c0ee74daa2f5636b40cc9900b.squirrel@...2257...>
In-Reply-To: <CAGyAFMU1iS3FJjVbmBqYq6BeSt+UyxUrAUg=xd=cmiH3nVac6g@...278...>
References: <6cc03a83-47e6-cedb-254b-f445972788f5@...515...>
 <b9c984d6-bcde-0d0e-349d-3a586600b668@...515...>
 <6ebf219f-6a8e-6e39-893c-5610129abaef@...1147...>
 <CAGyAFMU1iS3FJjVbmBqYq6BeSt+UyxUrAUg=xd=cmiH3nVac6g@...278...>
Date: Fri, 30 Nov 2018 07:10:33 +0100
From: "Simon Matter" <simon.matter@...2249...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] Summary of the community meeting (Wed,
 28th Nov 2018)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: 8bit
To: Lev Stipakov <lstipakov@...277...>
Cc: Jan Just Keijser <janjust@...1147...>, openvpn-devel@lists.sourceforge.net

> Hi Jan Just,
>
> (forgot to add openvpn-devel in previous mail)
>
> Some background information.
>
> In openvpn3 we decided not to implement fragments, because:
>
>  - this is quite a big feature which has to be supported through the whole
> stack (client, server, kernel module)
>  - we assume that it is not used by most of users
>
> However, for those who needs --fragment, we'll implement:
>
>  - mssfix support, this should solve problems with tcp-based protocols
>  - sending icmp "packet too big" for other protocols, we assume that
> they'll respect icmp response
>
> --fragment is/was very useful on a system where you do not / cannot change
>> the tun MTU size. Up to Windows XP, this was not
>> possible without rebooting the OS. Since Vista, it *is* possible to
>> change
>> the MTU of an adapter on the fly (as explained in my
>> trusty old cookbook, of course ;))
>>
>
> As James wrote a while ago (13 years ago :)
>
> https://openvpn.net/archive/openvpn-users/2005-10/msg00354.html
>
>> A lot of experience gained during the OpenVPN 1.x releases showed that
> it's best to fix the tunnel MTU at
>> 1500 and vary the other parameters (and use --mssfix to prevent
> fragmentation rather than a lower tunnel MTU).
>
> Don't know if still holds. Assuming that we can change tun-mtu on any
> supported platforms, do you think that it is better
> to do _that_, rather than have mssfix/icmp ptb workaround?
>
>
>> With that, it would be possible to fix the link-mtu to 1500 (or
>> whatever is set on the outbound interface) and then subtract the header
>> size to get a meaningful tun-mtu size.
>>
>
> Do you think 1500 is a safe value? Arne just mentioned today that his
> network interface MTU is 1500 and router's MTU is 1492 due to
> PPPoE, and openvpn2 works because it assumes that mtu is 1450.

I also think 1500 isn't safe because different types ob internet
connections may reduce it, like the mentioned PPPoE.

Regards,
Simon


