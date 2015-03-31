Message-ID: <551A4A9B.6010508@...68...>
Date: Tue, 31 Mar 2015 09:19:55 +0200
From: Matthias Andree <matthias.andree@...68...>
MIME-Version: 1.0
References: <1427784294-22175-1-git-send-email-samuli@...515...>
In-Reply-To: <1427784294-22175-1-git-send-email-samuli@...515...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="wtlHbhCnN5kK5I383W0MQK4ogFwC7LPlr"
Subject: Re: [Openvpn-devel] [PATCH] Remove useless dash escapes from the
 man-page
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wtlHbhCnN5kK5I383W0MQK4ogFwC7LPlr
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 31.03.2015 um 08:44 schrieb samuli@...515...:
> From: Samuli Sepp=C3=A4nen <samuli@...515...>
>=20
> This patch is against the release/2.3 branch
>=20
> Trac: 512
> Signed-off-by: Samuli Sepp=C3=A4nen <samuli@...515...>
> ---
>  doc/openvpn.8 | 1800 ++++++++++++++++++++++++++++-----------------------=
------
>  1 file changed, 900 insertions(+), 900 deletions(-)
>=20
> diff --git a/doc/openvpn.8 b/doc/openvpn.8
> index a95d353..bcd2d76 100644
> --- a/doc/openvpn.8
> +++ b/doc/openvpn.8
> @@ -37,7 +37,7 @@
>  .TH openvpn 8 "17 November 2008"
>  .\"*********************************************************
>  .SH NAME
> -openvpn \- secure IP tunnel daemon.
> +openvpn - secure IP tunnel daemon.

I am concerned this will cause misformattings and inability to search
for options with leading dashes on some systems - I don't recall
versions, but I do know that some systems used some sort of Unicode
(soft?) hyphen for a simple non-escaped MINUS character (ASCII 0x2B).

So, for the release/2.3 branch, NAK for now, and more questions on the
2.4/trunk.

My objections will be void the moment that we can be sure that those
(major) distributions that played with the Unicode outside-ASCII hyphens
in *roff have gone out of support, and supported versions no longer
modify the plain ASCII minus, but render it verbatim.


--wtlHbhCnN5kK5I383W0MQK4ogFwC7LPlr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlUaSqEACgkQvmGDOQUufZWtawCgumx0uBlLWF/Lca4ujdH7h6wU
nfIAmQHBOWlyXM6bTKckox4QBOjlHOKt
=yfRD
-----END PGP SIGNATURE-----

--wtlHbhCnN5kK5I383W0MQK4ogFwC7LPlr--

