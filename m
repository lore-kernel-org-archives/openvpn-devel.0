Message-ID: <50508E65.3050808@...1114...>
Date: Wed, 12 Sep 2012 15:30:13 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1345211355-26513-1-git-send-email-heiko.hund@...1489...>
	<1347377664-15462-1-git-send-email-dazo@...384...>
In-Reply-To: <1347377664-15462-1-git-send-email-dazo@...384...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig1835DF91F637B1D311B3B128"
Subject: Re: [Openvpn-devel] [PATCH v3] Add --compat-names option
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
--------------enig1835DF91F637B1D311B3B128
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

On 11/09/12 17:34, David Sommerseth wrote:
> From: Heiko Hund <heiko.hund@...1489...>
>=20
> With this option, users can basically undo the changes of the UTF-8
> support commit 5e86fd93779482b90a191f929edebe414cd78a4f. It's here for
> short term compatibility and should be removed again as soon as possible.
>=20
> When OpenSSL is used, the subject strings will be in the proprietary
> format again. Generally username, X.509 CN, and X.509 subject will again
> be subject to '_' replacemant, unless the "no-remapping" flag is
> also specified. That flag ensures compatibility with setups using the
> --no-name-remapping option, that has been removed in 2.3.
>=20
> [v2: More comments related to compat_flags() added by DS plus using
>      COMPAT_FLAG_QUERY expclit]
> [v3: Improved the man page entry for --compat-names, after suggestions
>      from Bernhard R. Link]
>=20
> Signed-off-by: Heiko Hund <heiko.hund@...1489...>
> Signed-off-by: David Sommerseth <davids@...1347...>
> ---
>  doc/openvpn.8                    |   52 ++++++++++++++++++++++++++++++++=
++++
>  src/openvpn/misc.c               |   21 +++++++++++++++
>  src/openvpn/misc.h               |    6 +++++
>  src/openvpn/options.c            |   10 +++++++
>  src/openvpn/ssl_verify.c         |   54 +++++++++++++++++++++++++++++++-=
------
>  src/openvpn/ssl_verify_openssl.c |   12 +++++++++
>  6 files changed, 146 insertions(+), 9 deletions(-)

Applied to master.

commit e7412ca3eee2f2a2fb0af5acbe968137cfd7e995
Author: Heiko Hund <heiko.hund@...1489...>
Date:   Tue Sep 11 17:34:24 2012 +0200

    Add --compat-names option

    Signed-off-by: Heiko Hund <heiko.hund@...1489...>
    Signed-off-by: David Sommerseth <davids@...1347...>
    Acked-by: Gert Doering <gert@...1296...>
    Acked-by: David Sommerseth <davids@...1347...>
    Message-Id: 1347377664-15462-1-git-send-email-dazo@...384...
    URL: http://article.gmane.org/gmane.network.openvpn.devel/7053


kind regards,

David Sommerseth


--------------enig1835DF91F637B1D311B3B128
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlBQjmgACgkQDC186MBRfrrfrgCgpYA9mUKxHPHbI2y+QsRICWJE
BWIAoIdFhEpELDMpP14R7Px3zhLrX2MN
=Gfvr
-----END PGP SIGNATURE-----

--------------enig1835DF91F637B1D311B3B128--

