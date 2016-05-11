Date: Wed, 11 May 2016 22:21:52 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20160511202152.GY53051@...1296...>
References: <CAAM7bARYZSecZZb2aU7dTaRc1a6rP8dz4hsHR=tDUbTmSTpgFg@...278...>
	<CAFHpkQH--CiX4XguNMsoCNSKJ3GEFShPpae+=AVon-h6bT4c5Q@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bNm442JWL28TwMyy"
Content-Disposition: inline
In-Reply-To: <CAFHpkQH--CiX4XguNMsoCNSKJ3GEFShPpae+=AVon-h6bT4c5Q@...278...>
Subject: Re: [Openvpn-devel] Need help for adding feature: Selecting remote
 servers by best latency
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: ???????? ?????????????? <chipitsine@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--bNm442JWL28TwMyy
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

hi,

On Thu, May 12, 2016 at 12:35:38AM +0500, ???????? ?????????????? wrote:
> how are you going to resolve
>=20
> a) host.example.com resolves in multiple "A" records
> b) host.example.com resolves in both "AAAA" and "A" records
>=20
> ?

By treating them the way the current code effectively does - "multiple
remote servers"

You do not really need to distinguish between "2x remote in the config"
vs. "1x remote in the config which points to 2x A records" - find out
which one is the fastest, and use that.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--bNm442JWL28TwMyy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVzOUX6kuBuNlUUl1AQKitQQAl17eioag5oes7wYTF37N8MMkoUCbX4kK
xgW6bePXaJ3jGON9YelWCW6uWYf1WOHMTeOuu65oxgehtqnhVs+N8LfuWB2j8Rk+
CwDxr5WjMM+XPJLdAdi4goqmmExYd4F4DtbC7rUsn8ibWb8FuCC52lt7dIpbSv9j
eYkX0c7IPZE=
=EXxR
-----END PGP SIGNATURE-----

--bNm442JWL28TwMyy--

