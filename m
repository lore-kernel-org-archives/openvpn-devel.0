Message-ID: <501FBA7D.7040804@...1114...>
Date: Mon, 06 Aug 2012 14:37:17 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1343821058-11456-1-git-send-email-heiko.hund@...1489...>
	<1343920822-29161-1-git-send-email-heiko.hund@...1489...>
In-Reply-To: <1343920822-29161-1-git-send-email-heiko.hund@...1489...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigF156AF80FEBFC23AA757EBE8"
Subject: Re: [Openvpn-devel] [PATCH 2/2 v4] add API for plug-ins to write to
 openvpn log
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
--------------enigF156AF80FEBFC23AA757EBE8
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

On 02/08/12 17:20, Heiko Hund wrote:
> Some plugins want to add messages to the openvpn log file. The
> plugin_log() and plugin_vlog() APIs provide ways for them to do so.
>=20
> OPENVPN_PLUGINv3_STRUCTVER is not incremented as the v3 plugin API
> is new in 2.3 and this is merged during alpha phase.
>=20
> Signed-off-by: Heiko Hund <heiko.hund@...1489...>
> ---
>=20
> Changes since PATCH 2/2 v3:
>=20
>   * enable gcc specific format checking with log functions
>=20
>  include/openvpn-plugin.h |   61 ++++++++++++++++++++++++++++++++++++++++=
++++-
>  src/openvpn/plugin.c     |   62 ++++++++++++++++++++++++++++++++++++++++=
+++++-
>  2 files changed, 121 insertions(+), 2 deletions(-)

ACK.  Applied to master

commit be532e0d151bc5ad404970fdc7b49e61512a625c
Author: Heiko Hund <heiko.hund@...1489...>
Date:   Thu Aug 2 17:20:22 2012 +0200

    add API for plug-ins to write to openvpn log
=20=20=20=20
    Signed-off-by: Heiko Hund <heiko.hund@...1489...>
    Acked-by: David Sommerseth <davids@...1347...>
    Message-Id: 1343920822-29161-1-git-send-email-heiko.hund@...1489...
    URL: http://article.gmane.org/gmane.network.openvpn.devel/6946
    Signed-off-by: David Sommerseth <dazo@...384...>


kind regards,

David Sommerseth


--------------enigF156AF80FEBFC23AA757EBE8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlAfun0ACgkQDC186MBRfrpBqgCcCr2+LrgTmJHUiPhTfvv4vYjS
ZE0AoJXHvFuqK36sgBqMSiIcigk5HBva
=5rda
-----END PGP SIGNATURE-----

--------------enigF156AF80FEBFC23AA757EBE8--

