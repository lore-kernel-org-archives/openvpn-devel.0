Date: Thu, 11 Aug 2011 08:18:03 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20110811061803.GD8496@...1296...>
References: <1312980908-25157-1-git-send-email-heiko.hund@...1489...>
	<1312980908-25157-3-git-send-email-heiko.hund@...1489...>
	<CAOazyz3rzcfQaCpS0stJiGHHxyP_5D+ZcAmXH+8_JoJhsUw_uA@...278...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3U3bYITUAgF/y0A0"
Content-Disposition: inline
In-Reply-To: <CAOazyz3rzcfQaCpS0stJiGHHxyP_5D+ZcAmXH+8_JoJhsUw_uA@...278...>
Subject: Re: [Openvpn-devel] [PATCH 2/2] don't use struct in6_addr s6_addr32
	member anymore
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--3U3bYITUAgF/y0A0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Aug 10, 2011 at 11:40:28PM +0300, Alon Bar-Lev wrote:
> I think this should be done by autoconf.
> And hand added into win32 for MSVC.

Any sort of conditional code here is causing more pain than just using
the 8-bit accessors in a straightforward way with no #ifdefs.

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--3U3bYITUAgF/y0A0
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBTkN0GqkuBuNlUUl1AQJfXgP/Zn8tWRTs3/Ked6JpDlhKU6nfrbN6Zfir
RnjjhRMq2daoS17FwDk9WigWA24ql0B+chhOAqJyexo7WchjN9GF+tIikzm2KCDA
3hsjffhTH4+ovcMbUpoTOdRzssRhoaliexYlUq7pMLVHhWn4zHlLKBJPWJQ822v7
UpgwlFWGtSY=
=HCIq
-----END PGP SIGNATURE-----

--3U3bYITUAgF/y0A0--

