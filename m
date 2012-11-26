Date: Mon, 26 Nov 2012 19:39:42 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20121126183941.GY22465@...1296...>
References: <1353063726-25113-1-git-send-email-dazo@...384...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aTHdXM4WpLndGb15"
Content-Disposition: inline
In-Reply-To: <1353063726-25113-1-git-send-email-dazo@...384...>
Subject: Re: [Openvpn-devel] [PATCH] Avoid recursion in
	virtual_output_callback_func()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <dazo@...384...>
Cc: openvpn-devel@lists.sourceforge.net

--aTHdXM4WpLndGb15
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Nov 16, 2012 at 12:02:06PM +0100, David Sommerseth wrote:
> From: David Sommerseth <davids@...1347...>
>=20
> This solves a SEGV situation when using the management API while OpenVPN
> is closing down.

ACK.

Basically, what it does is "*any* activity of virtual_output_callback_func()
only takes place if not in-recursion".  So in normal circumstances,=20
nothing changes, and in the recursion case, nothing at all(!) is attempted
- which sounds like a sane thing to do.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--aTHdXM4WpLndGb15
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (NetBSD)

iQCVAwUBULO3bakuBuNlUUl1AQL2+gP+JecfTfOu5mdrJLKmoyZzStu94QDBoJJF
1x7JtDZik3VNya95Cr1nk3C2l0iqfUwFciUzwTm9MwNXMC1SjYOy88Ysx2N4J23R
1Yg/2pMVp6ScWEECZxzmwZ0nZL0Ka7V68BL1+Ke5kq27BBD4jBHIlvSCIDIyKgDP
/0Ft5NMQa0g=
=exBP
-----END PGP SIGNATURE-----

--aTHdXM4WpLndGb15--

