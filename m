Message-ID: <4F798D7A.2080705@...1114...>
Date: Mon, 02 Apr 2012 13:28:58 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <CAOazyz0xh540Gk3j3T_O0B3ix9htz12dm0VMuKmB16FOQAAQoA@...278...>
	<1333012602-5419-3-git-send-email-alon.barlev@...277...>
In-Reply-To: <1333012602-5419-3-git-send-email-alon.barlev@...277...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigEB8A49A74D73209DFDD1B37D"
Subject: Re: [Openvpn-devel] [PATCH 2/4] cleanup: avoid using ~0 - ipv6
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
--------------enigEB8A49A74D73209DFDD1B37D
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

On 29/03/12 11:16, Alon Bar-Lev wrote:
> Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
> ---
>  src/openvpn/route.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>=20

Applied to master branches on -testing and -stable trees

commit ffa1184d7fde8262f5c19438a59657e318d5126f
Author: Alon Bar-Lev <alon.barlev@...277...>
Date:   Thu Mar 29 11:16:40 2012 +0200

    Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
    Acked-by: Gert Doering <gert@...1296...>
    Signed-off-by: David Sommerseth <davids@...1347...>



kind regards,

David Sommerseth




--------------enigEB8A49A74D73209DFDD1B37D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk95jXoACgkQDC186MBRfrqHaQCgo3ecfjIh6bO/5TcXiOmh3C/B
74cAoIKA8RQaBr3BBG9HEs5JqZL+jEYW
=Tg5M
-----END PGP SIGNATURE-----

--------------enigEB8A49A74D73209DFDD1B37D--

