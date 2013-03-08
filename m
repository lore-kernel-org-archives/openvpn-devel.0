From: Joachim Schipper <joachim.schipper@...1435...>
Date: Fri, 8 Mar 2013 13:58:02 +0100
Message-ID: <1CED409804E2164C8104F9E623B08B9013B8D6E33F@...1436...>
References: <E4029AEA85D4DB438D6DF8A00A242A08120C1843@...1814...>
In-Reply-To: <E4029AEA85D4DB438D6DF8A00A242A08120C1843@...1814...>
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

> Hi,
>
> our setup needs openvpn UDP/TLS tunnels with dynamic client IP addresses,=
 so I implemented a fix for the bug #49 that has been open for over two yea=
rs.=20
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

