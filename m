Message-ID: <504F7E03.9070906@...1114...>
Date: Tue, 11 Sep 2012 20:08:03 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1346674564-17260-1-git-send-email-arne@...1227...>
In-Reply-To: <1346674564-17260-1-git-send-email-arne@...1227...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig334AD44B4333FB78FFE282AF"
Subject: Re: [Openvpn-devel] [PATCH v2] Document that keep alive will double
 the second value in server mode and give a short explanation why the value
 is chosen.
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
--------------enig334AD44B4333FB78FFE282AF
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

On 03/09/12 14:16, Arne Schwabe wrote:
> ---
>  doc/openvpn.8 |    4 ++++
>  1 file changed, 4 insertions(+)

Applied to master.

commit 341e6bb67f072731d75769ce875633e544544062
Author: Arne Schwabe <arne@...1227...>
Date:   Mon Sep 3 14:16:04 2012 +0200

    Document that keep alive will double the second value in server mode an=
d give a short explanation why the value is chosen.
=20=20=20=20
    Acked-by: Gert Doering <gert@...1296...>
    Message-Id: 1346674564-17260-1-git-send-email-arne@...1227...
    URL: http://article.gmane.org/gmane.network.openvpn.devel/7041=20=20
    Signed-off-by: David Sommerseth <davids@...1347...>


kind regards,

David Sommerseth


--------------enig334AD44B4333FB78FFE282AF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlBPfgYACgkQDC186MBRfrrXTwCfTTozQlRnzV342vHJmfR9PEwX
v+8AnAoNVffLkqezdOoVKUaax15O57u+
=H/Yl
-----END PGP SIGNATURE-----

--------------enig334AD44B4333FB78FFE282AF--

