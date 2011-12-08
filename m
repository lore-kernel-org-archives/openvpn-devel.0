Date: Thu, 8 Dec 2011 14:39:23 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20111208133922.GU18948@...1296...>
References: <CAOazyz13pmU4=6XOA-2uq0rAwTMRrRYF73sszehxbcPQsa2rmQ@...278...>
	<1323349407-21374-1-git-send-email-davids@...1347...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CGDBiGfvSTbxKZlW"
Content-Disposition: inline
In-Reply-To: <1323349407-21374-1-git-send-email-davids@...1347...>
Subject: Re: [Openvpn-devel] [PATCH] Enable access() when building in Visual
	Studio
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <davids@...1347...>
Cc: openvpn-devel@lists.sourceforge.net

--CGDBiGfvSTbxKZlW
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Dec 08, 2011 at 02:03:27PM +0100, David Sommerseth wrote:
> Visual Studio does not enable certiain standard Unix functions,
> such as access().  By defining _CRT_NONSTDC_NO_WARNINGS and
> _CRT_SECURE_NO_WARNINGS, these functions are enabled.
>=20
> This patch also adds a ./configure check for access() as well,
> in case this needs to be implemented on other platforms lacking
> this feature.  Which is why HAVE_ACCESS is defined in win/config.h.in
>=20
> Thanks to Alon Bar-Lev for helping solving this.

ACK!

And thanks to Alon.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--CGDBiGfvSTbxKZlW
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBTuC+CqkuBuNlUUl1AQLBsgP/cpZlIs6Uap9zSBGsSaOo3B9JS/1p7qc1
HA6tTOAlKhAe1M+ykA0SAA0rGSJ/OBwzOzBKPLIdbF7MGRgYhyJ1LmcJ1zVyhhKj
A+Tn8x1/fg72fhFRqG8u3hanxz2YzFMRgC45PlSDeMZEPKvu99ja4CGbq4lzLIht
kXcvSE1/QLI=
=uo+N
-----END PGP SIGNATURE-----

--CGDBiGfvSTbxKZlW--

