Message-ID: <4FF169AA.4050106@...1114...>
Date: Mon, 02 Jul 2012 11:28:10 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1341089443-2287-1-git-send-email-gert@...1296...>
In-Reply-To: <1341089443-2287-1-git-send-email-gert@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig2DDDCE80C9F0641498C45837"
Subject: Re: [Openvpn-devel] [PATCH] Repair "tap server" mode brokenness
 caused by <stdbool.h> fallout
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
--------------enig2DDDCE80C9F0641498C45837
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

On 30/06/12 22:50, Gert Doering wrote:
> Operator/Cast precedence wrong: casting mac[0] to (bool) first - giving
> "1" for "any mac address that does not start with 00:" - and only then
> bit-anding with "1" - thus always returning "true".  Which, in turn,
> leads to "reject all incoming packets with 'bad source address'".
>=20
> OpenVPN bug #216.
>=20
> Signed-off-by: Gert Doering <gert@...1296...>
> ---
>  src/openvpn/mroute.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>=20

Applied to master.

commit 8df08de6f84d224c6a79ab6c74ba73c33a47735d
Author: Gert Doering <gert@...1296...>
Date:   Sat Jun 30 22:50:43 2012 +0200

    Repair "tap server" mode brokenness caused by <stdbool.h> fallout

    Signed-off-by: Gert Doering <gert@...1296...>
    Acked-by: Fabian Knittel <fabian.knittel@...1547...>
    Message-Id: 1341089443-2287-1-git-send-email-gert@...1296...
    URL: http://article.gmane.org/gmane.network.openvpn.devel/6817
    Signed-off-by: David Sommerseth <dazo@...384...>


kind regards,

David Sommerseth


--------------enig2DDDCE80C9F0641498C45837
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk/xaawACgkQDC186MBRfrqfNgCdFuuqtlw72Syiq8OH0ENvVAdR
ejMAoKpjxD0cIEuCMf5jFOtssAeNlXM5
=P8MD
-----END PGP SIGNATURE-----

--------------enig2DDDCE80C9F0641498C45837--

