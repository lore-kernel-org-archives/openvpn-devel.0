Date: Sat, 16 Jul 2011 12:09:08 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20110716100908.GX8496@...1296...>
References: <1312f1908b4.-8162753897021314559.8311264442879771774@...1486...>
	<1313210dc57.-2479533967587045360.2173550128923027198@...1486...>
	<13132141bbe.-6554633753716236145.-6995683147743455020@...1486...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="l6/WQTCpesCiQS7Z"
Content-Disposition: inline
In-Reply-To: <13132141bbe.-6554633753716236145.-6995683147743455020@...1486...>
Subject: Re: [Openvpn-devel] Fwd: Re: OpenVPN on OpenWrt
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: lancebaynes87 <lancebaynes87@...1486...>
Cc: OpenVPN devel <openvpn-devel@lists.sourceforge.net>

--l6/WQTCpesCiQS7Z
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Jul 16, 2011 at 01:33:23AM -0700, lancebaynes87 wrote:
> Where can I ask a question regarding OpenVPN?=20

openvpn-users would be better suited for user questions...  or the
openvpn forum (https://forums.openvpn.net/)

> Did I found a bug, or what?
>=20
> Here:
> http://unix.stackexchange.com/questions/16412/openvpn-on-openwrt

Well, it's telling you where the problem is coming from:

Sat Jul  9 13:14:21 2011 WARNING: potential route subnet conflict between l=
ocal LAN [192.168.80.0/255.255.255.0] and remote VPN [192.168.80.1/255.255.=
255.255]

don't use the same network for the LAN on the client side and the VPN=20
addresses ("server ..." in the openvpn server config).

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--l6/WQTCpesCiQS7Z
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBTiFjRKkuBuNlUUl1AQLfiQQAxbfjte9/9D9ZEOll2ip8+uYhkEFxQuXO
uRpQuXPOM/HG4IGhJx+Rsz/dWPxqmpXCbI4zs27Bf0PhpUVG50+248ZuOY1YLO6C
0fxe7s0oUwssfyIYQvvdY0ogUdSMc20XBB6jj0DC0kqWqRHSMnX2cVaZnufwNbpU
0hwQL2lrksI=
=Qnb+
-----END PGP SIGNATURE-----

--l6/WQTCpesCiQS7Z--

