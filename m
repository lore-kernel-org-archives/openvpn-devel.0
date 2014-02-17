Date: Mon, 17 Feb 2014 22:34:36 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20140217213435.GS16637@...1296...>
References: <52CFF667.7080600@...1790...> <52CFFAF4.8050306@...1227...>
	<52CFFDA4.4060601@...1790...> <52D07F70.8030609@...1227...>
	<52D08946.6010906@...1790...> <20140119140416.GP226@...1296...>
	<530262FB.7080206@...1790...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="S5Olei2MlvlRk/sW"
Content-Disposition: inline
In-Reply-To: <530262FB.7080206@...1790...>
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

--S5Olei2MlvlRk/sW
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Feb 17, 2014 at 08:28:59PM +0100, Tore Anderson wrote:
> Now that has been fixed upstream (Linux 3.14), I tried again. Here I am
> connecting from 84.209.94.36 to 87.238.35.254, which is a secondary
> address on the server (87.238.35.145 is the primary). The OpenVPN
> server logs:
>=20
> ::ffff:84.209.94.36 TLS: Initial packet from [AF_INET6]::ffff:84.209.94.3=
6:39970 (via ::ffff:87.238.35.254%eth0), sid=3Da79ae4ef 7abb8215

Cool :-)

> So the Linux 3.14 fix seems to work, as OpenVPN now does see which IPv4
> address the server was contacted on. Progress! However the VPN doesn't
> come up, and tcpdump reveals why - OpenVPN is responding from the
> primary address of the server rater than the one it was contacted on:
>=20
> 20:21:02.555667 IP 84.209.94.36.39970 > 87.238.35.254.1194: UDP, length 14
> 20:21:02.556719 IP 87.238.35.145.1194 > 84.209.94.36.39970: UDP, length 26
>=20
> So we're closer, but not quite there yet unfortunately...

Could you run my test program to see whether that gets it right?

http://www.greenie.net/ipv6/mhome.c

For some platforms I also had to change the sending part (data structures,
alignment, whatnot) and that has not yet been integrated into OpenVPN
proper, and I think Linux was among them, at least for 64bit.

> This happens both with today's git master and with 2.3.2. BTW Arne's
> patch to socket.c that fixes the assert crash we originally discussed
> still isn't included in git master, has it been forgotten about?

ISTR that Arne wrote something about "this is a quick fix, will send a
proper patch later".  Then we lost a bit of momentum :-(

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--S5Olei2MlvlRk/sW
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBUwKAa6kuBuNlUUl1AQKIxwQAqxffOLuswPhFnZYwxi2mPmzJSYjI3kx9
qDsg63f7EHzKlxzJsW4tSkUTe4GcEi++WoKNwyx20BR+Zi7tWm+/3drWTMRmtTys
y+c5KytA5TJSC/H/xRYilfNThYMWJ0rrOmLooFH0w4HEmmehOFbVwyV9aHamZL20
jhWLGUH3Q3k=
=K4JB
-----END PGP SIGNATURE-----

--S5Olei2MlvlRk/sW--

