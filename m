Message-ID: <50AB4AFB.9030908@...1114...>
Date: Tue, 20 Nov 2012 10:18:51 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1CED409804E2164C8104F9E623B08B901323A48384@...1436...>
In-Reply-To: <1CED409804E2164C8104F9E623B08B901323A48384@...1436...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig8E9C417D9D6EB5F47367C6F0"
Subject: Re: [Openvpn-devel] [PATCH] Fix --show-pkcs11-ids
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Joachim Schipper <joachim.schipper@...1435...>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8E9C417D9D6EB5F47367C6F0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

On 14/11/12 10:03, Adriaan de Jong wrote:
> [PATCH] Fix --show-pkcs11-ids (Bug #239)
>=20
> Broken by 75b49e406430299b187964744f82e50a9035a0d3.
>=20
> Signed-off-by: Joachim Schipper <joachim.schipper@...1435...>
> ---
>  src/openvpn/pkcs11.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Hi Joachim,

Thanks a lot for you fix!  Just a little question.  You mention this
commit as being the offending commit:

commit 75b49e406430299b187964744f82e50a9035a0d3
Author: Alon Bar-Lev <alon.barlev@...277...>
Date:   Sun Apr 1 16:46:28 2012 +0300

    cleanup: gc usage

    Cleanup of "Use the garbage collector when retrieving x509 fields"
    patch series.

    Discussed at [1].

    There should be an effort to produce common function prologue
    and epilogue, so that cleanups will be done at single point.

    [1] http://comments.gmane.org/gmane.network.openvpn.devel/5401

    Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
    Acked-by: Adriaan de Jong <dejong@...1435...>
    Signed-off-by: David Sommerseth <davids@...1347...>


I'm just wondering how this could be related to you fix.  As I see it,
the syntax of the if() statement you change didn't change, neither the
behaviour of pkcs11_certificate_dn().

I see that commit 00b973f8af85c3ea8fa3cef80eec55e8dc139b27 changes the
behaviour of pkcs11_certificate_dn() in both the OpenSSL and PolarSSL
implementation.  So I'm suspecting you referenced the wrong commit.  Right?


--=20
kind regards,

David Sommerseth


--------------enig8E9C417D9D6EB5F47367C6F0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlCrSwAACgkQDC186MBRfrp79gCfVTZrBKHc5sEHrPlGoX+4BIW+
ahQAoI7njktoixyoN3Tg90TNbmNNmYh5
=2Hva
-----END PGP SIGNATURE-----

--------------enig8E9C417D9D6EB5F47367C6F0--

