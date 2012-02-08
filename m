Date: Wed, 8 Feb 2012 21:39:48 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20120208203948.GD13929@...1296...>
References: <CA+3tv22Xq447J_EXKM4SYP-45V7LN0NJfH6o9skUNPPij3PDuQ@...278...>
	<1CED409804E2164C8104F9E623B08B90129328AD5E@...1436...>
	<20120208080953.GS13929@...1296...>
	<CA+3tv2064zxi_v1hJPWaF+bd5FUrXYm+h+qYDnorHz8OrpxyGQ@...278...>
	<CA+3tv20-SBYOaDZG_+DgmVvAgkAYVR=CoWJ_dyzMjf2yFdLMGA@...278...>
	<20120208182413.GB13929@...1296...>
	<CA+3tv21sZAxo0hKF_tVrpmxCc3Uzcmv1fAiqaSDsyAhcavLdvQ@...278...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dIV3CY5swYZsO92m"
Content-Disposition: inline
In-Reply-To: <CA+3tv21sZAxo0hKF_tVrpmxCc3Uzcmv1fAiqaSDsyAhcavLdvQ@...278...>
Subject: Re: [Openvpn-devel] OpenVPN and Android 4.0 VPN API
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: James Ring <sjr@...1546...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--dIV3CY5swYZsO92m
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Feb 08, 2012 at 11:27:10AM -0800, James Ring wrote:
> > Exactly. =A0The first three things are sort of "nearly done", the
> > "receive file descriptor to use for tun/tap" would need to be
> > implemented (tun.c, open_tun(), #ifdef ANDROID_MAGIC_VPN :-) )
>=20
> I was thinking about this a little more. Presumably openvpn will be
> forked and exec'd before the file descriptor is available. Presumably
> openvpn could connect to a UNIX domain socket inside open_tun() if
> ANDROID_MAGIC_VPN is specified.
>=20
> Does other code within openvpn care whether the fd is a UNIX socket or
> a tun/tap device? I'm guessing there may be some ioctls it wants to
> perform on the device.=20

There aren't any ioctl()s (I'm aware of) for tun/tap devices, but=20
blocking/non-blocking behaviour might be an interesting problem, and
performance / battery usage won't be helped by copying the packet=20
around another time...

> Other than that, openvpn would be reading and
> writing IP packets with an encrypted payload and the Java wrapper
> would be responsible for forwarding the bytes between the UNIX domain
> socket and the actual tun device.

Don't show idea that to Jan-Just, he's already complaining that OpenVPN
wastes too many CPU cycles...

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--dIV3CY5swYZsO92m
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBTzLdlKkuBuNlUUl1AQIt9wQAmrF7mTbiwe+hmn3aihOkwaNC0qh+/FMQ
khtuPo/hC9y7MXDfmI6qdmEchTkLN74A55GYiJpXImiB53g6yTBf0mTVKdgy4jqK
C6FrdfyQfn04Cn4QMs+sUeuyoBlQNm14IPY0SWzBvmmxZPR6jZ1Oje8ad317Jsm7
R19ADpka7XY=
=9x59
-----END PGP SIGNATURE-----

--dIV3CY5swYZsO92m--

