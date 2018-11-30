From: Jan Just Keijser <janjust@...1147...>
References: <6cc03a83-47e6-cedb-254b-f445972788f5@...515...>
 <b9c984d6-bcde-0d0e-349d-3a586600b668@...515...>
 <6ebf219f-6a8e-6e39-893c-5610129abaef@...1147...>
 <CAGyAFMU1iS3FJjVbmBqYq6BeSt+UyxUrAUg=xd=cmiH3nVac6g@...278...>
 <83d19b4c0ee74daa2f5636b40cc9900b.squirrel@...2257...>
 <4b777767-70f1-ebe2-f659-4687c0c640ec@...1147...>
 <CY4PR04MB0935D91D8A4378A6066D8D61DDD30@...2478...>
Message-ID: <fdd85141-b525-d629-23ad-0643e7a55461@...1147...>
Date: Fri, 30 Nov 2018 18:22:06 +0100
MIME-Version: 1.0
In-Reply-To: <CY4PR04MB0935D91D8A4378A6066D8D61DDD30@...2478...>
Content-Language: nl-NL
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
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
To: Kristian McColm <kristianmccolm@...160...>, Simon Matter <simon.matter@...2249...>, Lev Stipakov <lstipakov@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

On 30/11/18 17:27, Kristian McColm wrote:
> 1500 is not safe on many mobile/cell networks as most have a smaller MTU like 1460 due to GTP headers used between the PGW and eNodeB. There is also reduced MTU when performing NAT64, i.e. packets translated from IPv4 to IPv6 become 20 bytes larger after translation due to additional IP header bytes.
>
> I believe it is most efficient to implement an application layer fragmentation feature, similar to IKEv2 fragmentation (RFC7383) so that the underlying network layer does not have to perform IP layer fragmentation which has known risks.
that is pretty much what --fragment does...

> Additionally, TCP MSS rewriting only works for TCP. Many VPNs use UDP which is not helped by MSS fix obviously. If supported by the client/server OS, path MTU discovery can be used to determine the MTU of a given connection.
TCP MSS using --mssfix works inside the tunnel only, and only for TCP 
connections. It does not depend on the outside protocol (UDP or TCP).

I fully agree that having PMTUD would be nice to have, but even that has 
its drawbacks...

JM2CW,

JJK

> -----Original Message-----
> From: Jan Just Keijser [mailto:janjust@...1147...]
> Sent: November 30, 2018 11:16
> To: Simon Matter <simon.matter@...2249...>; Lev Stipakov <lstipakov@...277...>
> Cc: openvpn-devel@lists.sourceforge.net
> Subject: Re: [Openvpn-devel] Summary of the community meeting (Wed, 28th Nov 2018)
>
> Hi Lev, Simon,
>
> On 30/11/18 07:10, Simon Matter wrote:
>>> Hi Jan Just,
>>>
>>> (forgot to add openvpn-devel in previous mail)
>>>
>>> Some background information.
>>>
>>> In openvpn3 we decided not to implement fragments, because:
>>>
>>>    - this is quite a big feature which has to be supported through the
>>> whole stack (client, server, kernel module)
>>>    - we assume that it is not used by most of users
>>>
>>> However, for those who needs --fragment, we'll implement:
>>>
>>>    - mssfix support, this should solve problems with tcp-based protocols
>>>    - sending icmp "packet too big" for other protocols, we assume that
>>> they'll respect icmp response
>>>
>>> --fragment is/was very useful on a system where you do not / cannot
>>> change
>>>> the tun MTU size. Up to Windows XP, this was not possible without
>>>> rebooting the OS. Since Vista, it *is* possible to change the MTU of
>>>> an adapter on the fly (as explained in my trusty old cookbook, of
>>>> course ;))
>>>>
>>> As James wrote a while ago (13 years ago :)
>>>
>>> https://openvpn.net/archive/openvpn-users/2005-10/msg00354.html
>>>
>>>> A lot of experience gained during the OpenVPN 1.x releases showed
>>>> that
>>> it's best to fix the tunnel MTU at
>>>> 1500 and vary the other parameters (and use --mssfix to prevent
>>> fragmentation rather than a lower tunnel MTU).
>>>
>>> Don't know if still holds. Assuming that we can change tun-mtu on any
>>> supported platforms, do you think that it is better to do _that_,
>>> rather than have mssfix/icmp ptb workaround?
>>>
>>>
>>>> With that, it would be possible to fix the link-mtu to 1500 (or
>>>> whatever is set on the outbound interface) and then subtract the
>>>> header size to get a meaningful tun-mtu size.
>>>>
>>> Do you think 1500 is a safe value? Arne just mentioned today that his
>>> network interface MTU is 1500 and router's MTU is 1492 due to PPPoE,
>>> and openvpn2 works because it assumes that mtu is 1450.
>> I also think 1500 isn't safe because different types ob internet
>> connections may reduce it, like the mentioned PPPoE.
>>
>>
> this is why the --fragment feature is so handy - no need to change the mtu values on either end, yet you can fiddle with the fragmentation size to tune performance.
>
> I agree that in most home environments the MTU size should be lower - if you look at e.g. IPsec you will find that it sets the tunnel MTU size to
> 1360 to ensure that it will "almost always" work.
> Having said that, I'd like see a solution that will work in 99% of the cases *AND* that will give most users close-to-optimal performance.  If "fragment" is not implemented in OpenVPN 3 then what happens if the tun MTU is too high?  where does fragmentation occur? at the OS level? at the UDP level?  I'd prefer to leave any fragmenting to the underlying OS as much as possible - hence if I want to send packets of 4000 bytes than either they are fragmented at the tun level (i.e. before they are processed by OpenVPN) or at the transport level (i.e. OpenVPN spits out a 4000 byte packet over the UDP/TCP connection, which the OS then fragements).  The problem with fragmenting at the UDP level is that you need to keep track of the fragments in order to reassemble them - TCP does this for you.
>
> cheers,
>
> JJK
>
>
>
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel


