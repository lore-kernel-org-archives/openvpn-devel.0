Date: Sun, 19 Jan 2014 15:04:17 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20140119140416.GP226@...1296...>
References: <52CFF667.7080600@...1790...> <52CFFAF4.8050306@...1227...>
	<52CFFDA4.4060601@...1790...> <52D07F70.8030609@...1227...>
	<52D08946.6010906@...1790...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0HX8KfI760FczsQW"
Content-Disposition: inline
In-Reply-To: <52D08946.6010906@...1790...>
Subject: Re: [Openvpn-devel] git master proto udp6+multihome is broken
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Tore Anderson <tore@...1790...>
Cc: openvpn-devel@lists.sourceforge.net

--0HX8KfI760FczsQW
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Jan 11, 2014 at 12:59:02AM +0100, Tore Anderson wrote:
> FWIW: Now I also got to test git master with what I wanted to in the
> first place, namely to see whether or not all the nice dualstack changes
> had also made "multihome" work for IPv4-mapped clients coming in to the
> server on an udp6 socket (ticket #306). Unfortunately that's still
> broken, and it seems that for a server process "proto udp" is still
> IPv4-only. So it doesn't appear to be possible to get a functioning
> dual-stacked UDP server (that has multiple addresses/interfaces) at the
> moment.

FWIW, that seems to be a Linux oddity.

I've extracted the "bind to an UDP socket, listen on it, print all
addresses I can find" out of openvpn to see whether I can more easily
debug all the multihome oddities people have seen, and that code=20
tells me that for IPv4-mapped clients, we are not actually receiving=20
any "ancilliary data" in recvmsg(), which is needed to see our local
socket address.

It works for IPv6 clients on IPv6 sockets, and for IPv4 clients on IPv4-only
sockets, but not for IPv4 (-mapped) clients on dual-stack IPv6 sockets.


This is made worse by the OpenVPN code assuming that it would always
receive data, so the "if not" case neither triggers a warning, nor is
the data structure properly cleaned in that case - so you'll see packet
info related to the last properly reported connection.

In case you want to test yourself, the code is appended.  It's not pretty,
but gets the job done :-)

Compile with "gcc -o mhome mhome.c", run with

  ./mhome (4|6) <port>

like "./mhome 4 12345" or "./mhome 6 50001".

In lieu of a good tool to generate IPv6 UDP packets, I've used "traceroute6"
to trigger this ("traceroute6 -p 50000" generates 50001 and up :-) ).


A *working* sample is here, from FreeBSD 9.2:

$ ./mhome=20
AF_INET6/IPV6_RECVPKTINFO enabled
setsockopt(IPV6_V6ONLY=3D0)
Socket bound to local address [AF_INET6][undef]:50001
--
CMSG_NXTHDR=3D0x0, level=3D41, type=3D46
IPV6_PKTINFO
read: fromlen=3D28, r_len=3D12
  from=3D[AF_INET6]2001:608:4::3:52613 (via 2001:608:0:814::f000:5%[undef])
--
CMSG_NXTHDR=3D0x0, level=3D41, type=3D46
IPV6_PKTINFO
read: fromlen=3D28, r_len=3D12
  from=3D[AF_INET6]::ffff:193.149.48.167:59559 (via ::ffff:194.97.140.5%[un=
def])
--


A non-working example from a Linux 3.3.8 kernel:

$ ./mhome
AF_INET6/IPV6_RECVPKTINFO enabled
setsockopt(IPV6_V6ONLY=3D0)
Socket bound to local address [AF_INET6][undef]:50001
--
CMSG_NXTHDR=3D(nil), level=3D41, type=3D50
IPV6_PKTINFO
read: fromlen=3D28, r_len=3D12
  from=3D[AF_INET6]2001:608:0:814::f000:5:61802 (via 2001:608:0:814::f000:1=
1%eth0)
--
CMSG_FIRSTHDR()=3DNULL, no packet info available
read: fromlen=3D28, r_len=3D24
  from=3D[AF_INET6]::ffff:194.97.140.5:54859 (via ::%[undef])
--


meh...

(So if someone really wants to make this work, the next step would be=20
to figure out why it's not working in the Linux IPv4-mapped case, and
get it fixed...)

More to come.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--0HX8KfI760FczsQW
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBUtvbYKkuBuNlUUl1AQLD6wP+M4bgPxZ4rX5p6Im3NoF624ixPl06p95i
MSayeGH9RrhFtO1UnUn4jdzSk5stLayAXEVPxPsV0+WTprSSo4g/WBgXvI1DbFJw
hI9kZqoC482p6fjXQ7dKqHWy8JCjdXyR6Ej4CC/t72F/G3fdKKAn1r67ONbjx34M
AgGtVtPv86Y=
=lbBo
-----END PGP SIGNATURE-----

--0HX8KfI760FczsQW--

