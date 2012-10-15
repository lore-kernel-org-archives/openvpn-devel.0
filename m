Message-ID: <507C4131.70803@...1114...>
Date: Mon, 15 Oct 2012 19:00:33 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1349082318-985-1-git-send-email-arne@...1227...>
In-Reply-To: <1349082318-985-1-git-send-email-arne@...1227...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig4AD1480256C7F8F7FF9F4C91"
Subject: Re: [Openvpn-devel] [PATCH] Document man agent-external-key
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
--------------enig4AD1480256C7F8F7FF9F4C91
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

On 01/10/12 11:05, Arne Schwabe wrote:
> Adapt commit message from cf69617bbea45a15423c4188daa9386debcbe1ec for ma=
n page and management documentation.
>=20
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>  doc/management-notes.txt |   28 ++++++++++++++++++++++++++++
>  doc/openvpn.8            |    5 +++++
>  2 files changed, 33 insertions(+)

ACK.  Applied to master and beta/2.3 branches.

commit 75b6f4bd84302d225a301f4ed87e2bb27908b972 (master)
commit 7ab52ad0011f7ff3502d30abc718a9257d5f3916 (beta/2.3)
Author: Arne Schwabe <arne@...1227...>
Date:   Mon Oct 1 11:05:18 2012 +0200

    Document man agent-external-key

    Signed-off-by: Arne Schwabe <arne@...1227...>
    Acked-by: David Sommerseth <davids@...1347...>
    Message-Id: 1349082318-985-1-git-send-email-arne@...1227...
    URL: http://article.gmane.org/gmane.network.openvpn.devel/7081
    Signed-off-by: David Sommerseth <davids@...1347...>


kind regards,

David Sommerseth


--------------enig4AD1480256C7F8F7FF9F4C91
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlB8QTMACgkQDC186MBRfrqwmQCeKjXOxcckReijWrDk9yMYitqw
R/8AoINgDBgl7CtpdraaabAPdD2sGHgX
=Xlit
-----END PGP SIGNATURE-----

--------------enig4AD1480256C7F8F7FF9F4C91--

