Message-ID: <501FBA6C.7020604@...1114...>
Date: Mon, 06 Aug 2012 14:37:00 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <20120801203832.GK2535@...1296...>
	<1343914619-10576-1-git-send-email-arne@...1227...>
In-Reply-To: <1343914619-10576-1-git-send-email-arne@...1227...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig16E6DCDF7B1D9FE0818432D6"
Subject: Re: [Openvpn-devel] [PATCH 3/4] Merge almost identical
 create_socket_tcp and create_socket_tcp6
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
--------------enig16E6DCDF7B1D9FE0818432D6
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

On 02/08/12 15:36, Arne Schwabe wrote:
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>  src/openvpn/manage.c |    4 ++--
>  src/openvpn/socket.c |   53 +++++++-------------------------------------=
------
>  src/openvpn/socket.h |    2 +-
>  3 files changed, 10 insertions(+), 49 deletions(-)
>=20

Applied to master.

commit e1f6121d6c189c59b367890e82efe369e08861b4
Author: Arne Schwabe <arne@...1227...>
Date:   Thu Aug 2 15:36:59 2012 +0200

    Merge almost identical create_socket_tcp and create_socket_tcp6
=20=20=20=20
    Signed-off-by: Arne Schwabe <arne@...1227...>
    Acked-by: Gert Doering <gert@...1296...>
    Message-Id: 1343914619-10576-1-git-send-email-arne@...1227...
    URL: http://article.gmane.org/gmane.network.openvpn.devel/6942
    Signed-off-by: David Sommerseth <dazo@...384...>


kind regards,

David Sommerseth


--------------enig16E6DCDF7B1D9FE0818432D6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlAfumwACgkQDC186MBRfrqtZACbBGojhxkADVicodfoHQ79BqOg
LGYAnRzPxXKccon3lXYaG1xRWPd82IHw
=KQQv
-----END PGP SIGNATURE-----

--------------enig16E6DCDF7B1D9FE0818432D6--

