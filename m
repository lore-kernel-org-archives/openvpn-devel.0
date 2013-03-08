From: Mikko Vainikainen <mikko.vainikainen@...1813...>
Date: Fri, 8 Mar 2013 14:41:06 +0000
Message-ID: <E4029AEA85D4DB438D6DF8A00A242A08120C2861@...1814...>
References: <E4029AEA85D4DB438D6DF8A00A242A08120C1843@...1814...>,
	<1CED409804E2164C8104F9E623B08B9013B8D6E33F@...1436...>
In-Reply-To: <1CED409804E2164C8104F9E623B08B9013B8D6E33F@...1436...>
Content-Language: en-US
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH] Fix for bug #49 for openvpn 2.2.2
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: Joachim Schipper <joachim.schipper@...1435...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi,

it is absolutely true that it is necessary to do HMAC hash per every existi=
ng session, as far as I know there's no other way to tell reliably if the p=
acket really belongs to an existing session... I haven't measured the HMAC =
performance myself, but I'd guess it would take a bit more than a few hundr=
ed packets per second to exhaust a modern CPU.

The for-loop part was originally (shamelessly) adapted from tls_pre_decrypt=
() @ ssl.c, it could have been more clear I have to admit...

I think the memcmp() is already constant-time as the HMAC hash has fixed si=
ze per hash algorithm (as far as I can remember, please correct me if I'm w=
rong). This was also shamelessly adopted from openvpn_decrypt() @ crypto.c.=
=20

I don't think there are any timing related attack opportunities as acceptin=
g the incoming packet does not trigger any immediate replies being sent bac=
k to anyone; the accepted packet is just processed as if it was received fr=
om the original address. As the data channel packet is being forwarded away=
 from the original sender to the trusted side of the tunnel it should be qu=
ite hard for an attacker to make any timing calculations..

I wasn't aware the  --float option could be specified per client...

Best regards, and nice weekend!
Mikko




________________________________________
From: Joachim Schipper [joachim.schipper@...1435...]
Sent: Friday, March 08, 2013 2:58 PM
To: openvpn-devel@lists.sourceforge.net
Cc: Mikko Vainikainen; Steffan Karger
Subject: RE: [PATCH] Fix for bug #49 for openvpn 2.2.2

> Hi,
>
> our setup needs openvpn UDP/TLS tunnels with dynamic client IP addresses,=
 so I implemented a fix for the bug #49 that has been open for over two yea=
rs.
>
> The patch is for version 2.2.2 as I had trouble compiling the 2.3.x tarba=
ll from openvpn.net. As the solution is rather simple (just two small utili=
ty functions in mudp.c) I'd guess it could be comfortambly migrated to 2.3.=
x.
>
> Basically what the fix does is the following: incoming data channel UDP p=
ackets from an unknown IP are matched against existing UDP/TLS sessions, an=
d if the packet passes the HMAC authentication against an existing TLS cont=
ext we know the client IP has changed and the session state will be instant=
ly updated accordingly.
>
> I have tested this fix to some extent, and the IP handover works impressi=
vely smoothly in my test setup where I randomly switch between two routes f=
rom client to server.
>
> Dynamic client IP's are enabled/disabled with --float in the server side.
>
> Please feel free to contact me for any questions etc.

This is not a full review of the patch, just a few quick remarks.

This patch seems to do (number of tunnels) HMAC's for any packet received f=
rom an unknown IP. If this is correct, couldn't a server with a couple thou=
sand tunnels be brought just by sending it a few hundred packets a second?

authenticate_tls_packet() contains a for() loop, but I see no code path tha=
t actually loops - everything seems to return immediately?

memcmp() should be replaced by a constant-time function to prevent timing a=
ttacks (probably only realistic on a server with a single tunnel); even the=
n, this patch allows determining the (approximate) number of tunnels in use=
 by looking at processing time.

I haven't looked at how this interacts with other features; it's at least n=
oteworthy that the floating behavior can't be specified on a per-connection=
 basis.

                Joachim



