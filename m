Date: Mon, 30 Mar 2015 23:06:37 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20150330210636.GF21893@...1296...>
References: <5519B242.2020009@...1856...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GSafuNNN4NHc9BES"
Content-Disposition: inline
In-Reply-To: <5519B242.2020009@...1856...>
Subject: Re: [Openvpn-devel] FreeBSD+cryptodev testers wanted
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>, openvpn-users@lists.sourceforge.net

--GSafuNNN4NHc9BES
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Mar 30, 2015 at 10:29:54PM +0200, Steffan Karger wrote:
> So, is there anyone with a FreeBSD machine with cryptodev engine=20
> available who is willing to test the patch?

Actually, testing on other platforms using any sort of OpenSSL "engine"
(usually hardware crypto accelerators etc.) is welcome - the patch will not
affect anyone else, so it's not easy to test.

gert


--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--GSafuNNN4NHc9BES
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVRm63KkuBuNlUUl1AQLyowQAswJgpSql2QMiY/abp43HIi0mzndkqGvG
7nFKJtjh9wtnMgwvdUbpnU8AjRFhpTYVgvKg5xIKigsKRVtJ1fu1azbH7UvyHITE
sKfVJkwjjyxTFa0PVaWPmWJTZz9H2uQCeKhsDzRjhC13r6RvOVjUh9ukVjFHuXcU
HEqAScXMq9s=
=LuuQ
-----END PGP SIGNATURE-----

--GSafuNNN4NHc9BES--

