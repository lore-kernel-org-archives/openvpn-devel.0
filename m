Date: Sat, 11 Jan 2014 12:22:25 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20140111112225.GK226@...1296...>
References: <52CFF667.7080600@...1790...> <52CFFAF4.8050306@...1227...>
	<52CFFDA4.4060601@...1790...> <52D07F70.8030609@...1227...>
	<52D08946.6010906@...1790...> <20140111094837.GJ226@...1296...>
	<52D11696.8040204@...1790...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Zw8LCl77lEqAzX6n"
Content-Disposition: inline
In-Reply-To: <52D11696.8040204@...1790...>
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

--Zw8LCl77lEqAzX6n
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Jan 11, 2014 at 11:01:58AM +0100, Tore Anderson wrote:
> > I *thought* that both proto udp and proto udp6 would create an IPv6 soc=
ket
> > bound to :: with IPV6_V6ONLY set to 0 (=3D accepting IPv4 and IPv6 pack=
ets
> > to any address).  Only "proto udp4" should listen to 0.0.0.0.
>=20
> This is not how git master behaves for me. "proto udp" and "proto udp4"
> both yield an IPv4-only socket (AF_INET):

Mmmh.  Right you are, at least on *Linux*...

"proto upd6" gives an udp6/TYPE=3DIPv6 socket, while "proto udp" gives
an udp/TYPE=3DIPv4 socket, on my Gentoo system (and this is not an artifact
from netstat or lsof, but it really only listens on 0.0.0.0)...

Sat Jan 11 12:27:35 2014 us=3D883703   proto =3D udp
Sat Jan 11 12:27:35 2014 us=3D883794   local =3D '[UNDEF]'
Sat Jan 11 12:27:35 2014 us=3D883885   local_port =3D '61194'
Sat Jan 11 12:27:35 2014 us=3D912736 UDP link local (bound): [AF_INET][unde=
f]:61194


When I tested that, I used a FreeBSD system, which behaves differently -=20
there, "proto udp" gives the same result as "proto udp6", and you need to do
"proto udp4" to get an IPv4-only socket...

Sat Jan 11 12:11:44 2014 us=3D286820   proto =3D udp
Sat Jan 11 12:11:44 2014 us=3D286849   local =3D '[UNDEF]'
Sat Jan 11 12:11:44 2014 us=3D286877   local_port =3D '51194'
Sat Jan 11 12:11:44 2014 us=3D383743 UDP link local (bound): [AF_INET6][und=
ef]:51194

$ netstat -an |grep 1194
udp46      0      0 *.51194                *.*=20


I do think I know where the problem is coming from (or, more precise, Arne
mentioned this a while ago already) - Arne's new code uses getaddrinfo()
with AI_PASSIVE to get "something suitable for listening on", and Linux'=20
getaddrinfo() seems to return INADDR_ANY before IN6ADDR_ANY, which is=20
arguably a pretty stupid thing to do... and yes, I think that we should
workaround this.


> I can submit a separate bug
> report about this if you wish. That said, I would be perfectly happy to
> simply use "proto udp6" instead, IFF "multihome" had worked correctly.

Our documentation says that "proto udp" or "proto tcp[-server]" is "use
dual-stack", so it should better do that, correctly on all platforms.

Bug opened, #360, and assigned to Arne.  Thanks for telling us.

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--Zw8LCl77lEqAzX6n
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBUtEpcakuBuNlUUl1AQIvMgQAw6z2i8/oBmFkACJ40Aq/PMaezzWa0Qka
36oXY+InkLeXSBnAimUl3n+dNikLuDm5eVUQemdaeHRu5zPEy65pNboZbfWpwFIH
YM0Hpp40rEKEcZYI/poCf2qDoHFViR1/zkVxMKHN9klUNag6OEQloP+ryv7aeL50
5do4mPXailM=
=MAQU
-----END PGP SIGNATURE-----

--Zw8LCl77lEqAzX6n--

