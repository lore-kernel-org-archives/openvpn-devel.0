Message-ID: <4FF5ABA8.8060708@...1114...>
Date: Thu, 05 Jul 2012 16:58:48 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1341479835-12963-1-git-send-email-arne@...1227...>
In-Reply-To: <1341479835-12963-1-git-send-email-arne@...1227...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigEC9EB2C1AAC58D7757AD9E9D"
Subject: Re: [Openvpn-devel] [PATCH] Fix compiling with --disable-management
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
--------------enigEC9EB2C1AAC58D7757AD9E9D
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

On 05/07/12 11:17, Arne Schwabe wrote:
> Some of the  MANAGEMENT_QUERY_REMOTE were actually needed. Put #ifdef ENA=
BLE_MANAGMENT in their place
>=20
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>  src/openvpn/init.c |    7 ++++++-
>  1 files changed, 6 insertions(+), 1 deletions(-)

ACK.  Applied to master.

commit cf93f0e0a65d66ed57f24efb7fbd96dc455b3732
Author: Arne Schwabe <arne@...1227...>
Date:   Thu Jul 5 11:17:15 2012 +0200

    Fix compiling with --disable-management
=20=20=20=20=20=20=20=20
    Signed-off-by: Arne Schwabe <arne@...1227...>
    Acked-by: David Sommerseth <davids@...1347...>
    Message-Id: 1341479835-12963-1-git-send-email-arne@...1227...
    Signed-off-by: David Sommerseth <dazo@...384...>


kind regards,

David Sommerseth


--------------enigEC9EB2C1AAC58D7757AD9E9D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk/1q6oACgkQDC186MBRfrpKBgCePPpXRixtCwDTBPIe7h6N5Pc8
n2YAn0hzKIKAk0mPmPUe3yvGe7KQ8keG
=RdL3
-----END PGP SIGNATURE-----

--------------enigEC9EB2C1AAC58D7757AD9E9D--

