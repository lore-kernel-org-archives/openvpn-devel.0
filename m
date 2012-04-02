Message-ID: <4F798D6E.5050906@...1114...>
Date: Mon, 02 Apr 2012 13:28:46 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <CAOazyz1OjVKEq5+0BcAgS9PVPcs77oJemG+kD3S7ZZUv+TiAEg@...278...>
	<1333287988-25921-1-git-send-email-alon.barlev@...277...>
In-Reply-To: <1333287988-25921-1-git-send-email-alon.barlev@...277...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig182EF64B77D3FF30AB194AE8"
Subject: Re: [Openvpn-devel] [PATCH] cleanup: gc usage
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig182EF64B77D3FF30AB194AE8
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

On 01/04/12 15:46, Alon Bar-Lev wrote:
> Cleanup of "Use the garbage collector when retrieving x509 fields"
> patch series.
>=20
> Discussed at [1].
>=20
> There should be an effort to produce common function prologue
> and epilogue, so that cleanups will be done at single point.
>=20
> [1] http://comments.gmane.org/gmane.network.openvpn.devel/5401
>=20
> Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
> ---
>  src/openvpn/pkcs11.c              |    5 +--
>  src/openvpn/pkcs11_polarssl.c     |    8 ++---
>  src/openvpn/ssl_verify.c          |   53 +++++++++++++++++++++----------=
------
>  src/openvpn/ssl_verify_openssl.c  |   15 ++++++----
>  src/openvpn/ssl_verify_polarssl.c |   18 +++++++-----
>  5 files changed, 55 insertions(+), 44 deletions(-)

Applied to master branches on -testing and -stable trees

commit 75b49e406430299b187964744f82e50a9035a0d3
Author: Alon Bar-Lev <alon.barlev@...277...>
Date:   Sun Apr 1 16:46:28 2012 +0300

    Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
    Acked-by: Adriaan de Jong <dejong@...1435...>
    Signed-off-by: David Sommerseth <davids@...1347...>


kind regards,

David Sommerseth


--------------enig182EF64B77D3FF30AB194AE8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk95jXAACgkQDC186MBRfrp4dgCdGyefmsYUi1KqkD3OF40xGC4+
E4AAoJEPntcDZzkhK5hhj82I+epVoL6G
=Tdnp
-----END PGP SIGNATURE-----

--------------enig182EF64B77D3FF30AB194AE8--

