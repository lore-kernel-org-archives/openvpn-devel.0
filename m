Message-ID: <508EA9F6.80809@...1114...>
Date: Mon, 29 Oct 2012 17:08:22 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1351517910-11414-1-git-send-email-heiko.hund@...1489...>
In-Reply-To: <1351517910-11414-1-git-send-email-heiko.hund@...1489...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig5D0B343C73392056E72192DA"
Subject: Re: [Openvpn-devel] [PATCH] fix display of plugin hook types
Reply-To: openvpn-devel@lists.sourceforge.net
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
--------------enig5D0B343C73392056E72192DA
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

On 29/10/12 14:38, Heiko Hund wrote:
> The OPENVPN_PLUGIN_ROUTE_PREDOWN hook was missing and displayed as
> "PLUGIN_???" in the log.
>=20
> OPENVPN_PLUGIN_ENABLE_PF was the only one that displayed the
> OPENVPN_ prefix.
>=20
> Signed-off-by: Heiko Hund <heiko.hund@...1489...>
> ---
>  src/openvpn/plugin.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20

ACK.  Applied to master and beta/2.3

commit ae303d444c11984b87e0046c4138982d7a41fd8b (master)
commit 3b8d116d3d9dbe2fac786311db8b2bec53d88c77 (beta/2.3)
Author: Heiko Hund <heiko.hund@...1489...>
Date:   Mon Oct 29 14:38:30 2012 +0100

    Fix display of plugin hook types

    Signed-off-by: Heiko Hund <heiko.hund@...1489...>
    Acked-by: David Sommerseth <davids@...1347...>
    Message-Id: 1351517910-11414-1-git-send-email-heiko.hund@...1489...
    URL: http://article.gmane.org/gmane.network.openvpn.devel/7111
    Signed-off-by: David Sommerseth <davids@...1347...>
    (cherry picked from commit ae303d444c11984b87e0046c4138982d7a41fd8b)



kind regards,

David Sommerseth




--------------enig5D0B343C73392056E72192DA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlCOqfkACgkQDC186MBRfrrxnQCgrJtbV0P6KO4NjtKG71EJLt7r
flcAnR+DoQo76JyJIPh0rojdOCez4vXw
=p3hB
-----END PGP SIGNATURE-----

--------------enig5D0B343C73392056E72192DA--

