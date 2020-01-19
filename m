Date: Sun, 19 Jan 2020 16:58:47 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20200119155847.GH1431@...1296...>
References: <20191004171246.26343-1-davids@...515...>
 <20191004171246.26343-2-davids@...515...>
 <20200119155108.GG1431@...1296...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="xNm6VWMD3PcA105u"
Content-Disposition: inline
In-Reply-To: <20200119155108.GG1431@...1296...>
Subject: Re: [Openvpn-devel] [PATCH 1/4] re-implement argv_printf_*()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <davids@...515...>
Cc: openvpn-devel@lists.sourceforge.net

--xNm6VWMD3PcA105u
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Jan 19, 2020 at 04:51:08PM +0100, Gert Doering wrote:
> David, shall I just amend the patch, or do you want to resend a v3?
>=20
> (The other 3 of the set should be fine, as they do not touch tun.c)

Not exactly correct, 2/4 renames all argv_reset() calls to argv_free(),
so that *might* need adjustment for tun.c as well.  But these are=20
similarily trivial, and if not done completely, will result in link
failures (so, easy enough, provided I compile on all platforms).

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--xNm6VWMD3PcA105u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJeJHy3AAoJEB2Cnv7KVigS1koL/2a4WwGtTxQyS/4xLkK/o+Ct
FIvrHmVzKTScqdZwF4fMsVxlexfRbTJCJhkL5K8VlCXdkT2owmJsspTB4DYIp2oA
heVmvmB8t7WmgURj1dzniyXqd93nDg48nMWJ9UXMCi2PzbD6Tlkhkky13HWy4r+C
OKpUO6fiEshu8meyrCThjeB3UQCuS0tGQQ9QDNQwpDiHuN11/g0EFXa1XxflO8mw
mm8h1p3uxaLv3NUq9m4p6DgLPSN9OWxPM5k+xAlpLGE3nzq3AZg6LExajshX55o7
O/pyxZS/PZ39uw4t/KMvKMnDHUzoGPMKUYr1Y3hsp7sJpq/xFLeIkaAz6EGoS8XS
qUFqhRyOGVfKpiLIOsresFfgxIVgD23fVAVG8cB+VMk3+FFHa+oay7Il4UYtfE1v
O36DgxdvJ/U0qu6svJO1slblgWkViWCPSKBb+kCzZUBxAsXmQYsBholRGlP66Wii
Ol+XtaXAYExHF7J1veRhq1w1sZe/EqjRIUCCCzymXA==
=rQ7+
-----END PGP SIGNATURE-----

--xNm6VWMD3PcA105u--

