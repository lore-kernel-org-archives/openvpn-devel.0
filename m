Date: Thu, 10 Dec 2015 09:36:41 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20151210083641.GZ24952@...1296...>
References: <5668A592.8080802@...2101...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0jUhJxQJ3IDt3BFR"
Content-Disposition: inline
In-Reply-To: <5668A592.8080802@...2101...>
Subject: Re: [Openvpn-devel] MSVC "parser stack overflow"
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gisle Vanem <gvanem@...2101...>
Cc: OpenVPN-dev <openvpn-devel@lists.sourceforge.net>

--0jUhJxQJ3IDt3BFR
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Dec 09, 2015 at 11:05:06PM +0100, Gisle Vanem wrote:
> While compiling src/openvpn/options.c with MSVC 2015, I got this
> error:
>   src/openvpn/options.c(5944): fatal error C1026: parser stack overflow, =
program too complex
>=20
> I've also seen such error in GeoIP-lib due to all the 'if..else if' state=
ments.
> Can this be written using some kind of a table-lookup code instead?

We could, certainly, if we had nothing else to do.

For the time being we just use a compiler that is not mainly a pain in the
back, solidly stuck in the last century before C99 - as in, none of the
core developers compile on windows, we all do cross-compilation with=20
mingw64 on Linux.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--0jUhJxQJ3IDt3BFR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVmk5makuBuNlUUl1AQKZyAP/TeLsa4uDJuEuzQuar2IfP5NxVitVCD6i
SXBwro3fkEsqwcLhZzWUDlysY03OCAq0B2wtZX1+R0Y0BSfZxQvvpHhWG5UgMTwL
nqMjaD6rAb6wU6EIIk9HfiWGFBb8MZHz/v6ReBP2qaZHLdO6EHXmWsFzoU1mxQiG
3IQEmy9tV/s=
=4djl
-----END PGP SIGNATURE-----

--0jUhJxQJ3IDt3BFR--

