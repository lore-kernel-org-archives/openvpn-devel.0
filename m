Message-ID: <4FE445DF.4030500@...1114...>
Date: Fri, 22 Jun 2012 12:15:59 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1340044749-10694-1-git-send-email-arne@...1227...>
	<1340044749-10694-3-git-send-email-arne@...1227...>
In-Reply-To: <1340044749-10694-3-git-send-email-arne@...1227...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig03C016F1EC6D30BAE0E85D87"
Subject: Re: [Openvpn-devel] [PATCH 2/6] Completely remove ancient IANA port
 warning.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig03C016F1EC6D30BAE0E85D87
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

On 18/06/12 20:39, Arne Schwabe wrote:
>=20
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>  src/openvpn/init.c    |    6 ------
>  src/openvpn/options.c |    3 ---
>  src/openvpn/options.h |    1 -
>  3 files changed, 0 insertions(+), 10 deletions(-)

Applied to master.

commit 53c48f41b19331594205f2dd2215d46054eac210
Author: Arne Schwabe <arne@...1227...>
Date:   Mon Jun 18 20:39:05 2012 +0200

    Completely remove ancient IANA port warning.
=20=20=20=20
    Signed-off-by: Arne Schwabe <arne@...1227...>
    Acked-by: Gert Doering <gert@...1296...>
    Message-Id: 1340044749-10694-3-git-send-email-arne@...1227...
    URL: http://article.gmane.org/gmane.network.openvpn.devel/6742
    Signed-off-by: David Sommerseth <davids@...1347...>


kind regards,

David Sommerseth


--------------enig03C016F1EC6D30BAE0E85D87
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk/kRd8ACgkQDC186MBRfrqbywCghNSAfI+r2nGF5TjtlQqNrQ0p
x+cAoI/vSdFep2LF70HBmz7awEXsxpL3
=BOx1
-----END PGP SIGNATURE-----

--------------enig03C016F1EC6D30BAE0E85D87--

