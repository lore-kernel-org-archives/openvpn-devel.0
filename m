From: Mikko Vainikainen <mikko.vainikainen@...1813...>
Date: Tue, 12 Mar 2013 08:33:36 +0000
Message-ID: <E4029AEA85D4DB438D6DF8A00A242A08120C68FF@...1814...>
References: <E4029AEA85D4DB438D6DF8A00A242A08120C1843@...1814...>,
	<1CED409804E2164C8104F9E623B08B9013B8D6E33F@...1436...>,
	<E4029AEA85D4DB438D6DF8A00A242A08120C2861@...1814...>
In-Reply-To: <E4029AEA85D4DB438D6DF8A00A242A08120C2861@...1814...>
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
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi,

I did some quick HMAC benchmarking on my linux box with one core of my Inte=
l i7:

+ 300k HMAC ops/s using 1200 byte packets
+ 700k HMAC ops/s using 100 byte packets
+ 840k HMAC ops/s using 10 byte packets

This is clearly fast enough for use cases like ours where a few tens of cus=
tomer sites with fault-tolerant primary/backup internet connections are con=
nected to our backend VPN service. If openvpn can't deal with client IP cha=
nges in (near) real-time it makes network design much harder as problems wi=
th the remote site's primary internet connection will quickly affect end-us=
ers.

I can't antipate any major risks in integrating this patch (assuming the im=
plementation is correct and secure):=20

1) currently the  --float option is broken for TLS servers anyway, so hardl=
y anyone should be using the option at the moment.

2) sysadmins can use their own judgement when assessing whether to enable t=
he patched --float on their servers: limited scalability in terms of number=
 of clients vs. improved network reliability and quality for site-to-site l=
ive systems.=20

3) I wouldn't put too much emphasis on the number of client sessions this p=
atch can handle, as the problem seems to be partially caused by openvpn's c=
urrent inability to run multi-threaded (that will hopefully be fixed in the=
 future?). If a server setup needs max scalability the --float can always b=
e turned off. This is why to me this patch looks like a win-win case.

Any thoughts?

Best regards,=20
Mikko

________________________________________
From: Mikko Vainikainen [mikko.vainikainen@...1813...]
Sent: Friday, March 08, 2013 4:41 PM
To: Joachim Schipper; openvpn-devel@lists.sourceforge.net
Subject: Re: [Openvpn-devel] [PATCH] Fix for bug #49 for openvpn 2.2.2

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
rong). This was also shamelessly adopted from openvpn_decrypt() @ crypto.c.

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



---------------------------------------------------------------------------=
---
Symantec Endpoint Protection 12 positioned as A LEADER in The Forrester
Wave(TM): Endpoint Security, Q1 2013 and "remains a good choice" in the
endpoint security space. For insight on selecting the right partner to
tackle endpoint security challenges, access the full report.
http://p.sf.net/sfu/symantec-dev2dev
_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel



