From: Denis Vlasenko <vda@...216...>
Subject: Re: [Openvpn-devel] openvpn-2.0_beta1: tunnel MTU a bit too large
References: <200405161143.42983.vda@...216...> <twig.1084740580.39452@...41...>
In-Reply-To: <twig.1084740580.39452@...41...>
MIME-Version: 1.0
Message-Id: <200405171204.55053.vda@...216...>
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
Date: Mon May 17 18:14:07 2004
Content-Type: text/plain; charset="koi8-r"
Content-Transfer-Encoding: quoted-printable
To: James Yonan <jim@...41...>, openvpn-devel@lists.sourceforge.net
Cc: Denis Vlasenko <vda@...216...>

On Sunday 16 May 2004 23:49, James Yonan wrote:
> Denis,
>
> There are two ways of setting the MTU in OpenVPN, one is to use --tun-mtu
> which doesn't include any encapsulation overhead, the other is to use
> --link-mtu which sets the maximum encrypted UDP datagram size sent between
> OpenVPN daemons after encapsulation.

A bit misleading name. Both ifconfig and ip tools report MTU
as maximum size of whole IP packet, not UDP packet encapsulated
in IP packet. Do you say that --link-mtu means UDP packet size,
not IP?

Can it be the case that openvpn code itself use different
meanings of --link-mtu in different parts of code?

> 2.0 takes a different approach to earlier version of OpenVPN on this.  1.x
> tries to use a lower MTU to get around fragmentation problems.  But since
> MTU=3D1500 is a kind of industry standard for ethernet networks, lowering=
 it
> can cause problems.  So the 2.0 approach is to set the MTU to 1500 and th=
en
> use --mssfix 1450 by default.

It's not a proper fix. IP traffic shall work through path of any valid MTU.
Artificially keeping tunnel MTU=3D1500 is a hack.

Think about multi-gigabit nets of the future: do you still want MTU=3D1500
everywhere?

Think about lossy links with small 'real' MTU: with tunnel MTU=3D1500
UDP/ICMP/other being packets fragmented and some fragments lost, you
get horrible performance of e.g. NFS over UDP.

> This will keep TCP connections over the
> tunnel from using the full size 1500 MTU by advertising lower MSS values =
to
> TCP senders. Instead TCP senders will use a segment size that will result
> in total encrypted, encapsulated OpenVPN packet sizes of 1450 or less.  A=
nd
> then when you add on the IP header and UDP header, you are still under
> 1500.

Yes. There is similar thing in iptables (--TCP-MSS).
Also, PMTU discovery will do this in properly configured network.

> So if you're getting fragmentation on an HTTP download, I would try
> reducing --mssfix to something below 1450 and see if that that fixes the
> problem.

I don't get fragmentation on HTTP. I get fragmentation of carrier packets
whan I send large UDP over tunnel link.

Anyway, regarding --mssfix: I dont want to work around the problem.
I want to set correct tunnel MTU. An MTU such that:
1) large UDP packets (say, 7000 bytes) sent over tunnel link are cut into
fragments of such size that, when encapsulated and sent over
carrier link, do not exceed MTU of carrier path (in my case, 1500).
Ideally, they should be equal to it.
2) TCP streams should use MSS which, again, results in sending full-sized
packets over carrier link.

Currently, openvpn, when configured with --link-mtu 1500, sets --tun-mtu
which is too large and (1) does not hold. "UDP doublefrag" bug.
TCP works according to (2).

If I force smaller --tun-mtu 1434, UDP doublefrag does not happen.
But now TCP does not use full-sized packets.

Look at the sizes of IP packets carrying UDP carrier packets
(sniffed over carrier link). UDP is almost 1500, TCP is _not_:

> > --tun-mtu 1434:
> >
> > UDP flood (dd if=3D/dev/zero bs=3D1M | nc -nuvvv -w1 1.1.5.6 34564):
> > ...
> > 20:44:23.376801 IP (tos 0x0, ttl  64, id 5657, offset 0, flags [DF], le=
ngth: 1496)
                                                                           =
      ^^^^
> > TCP flood (e.g. HTTP download):
> > ...
> > 20:41:55.514646 IP (tos 0x0, ttl  64, id 5293, offset 0, flags [DF], le=
ngth: 1472)
                                                                           =
      ^^^^

Hope this clarifies.
--
vda

