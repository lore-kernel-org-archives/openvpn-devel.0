Message-ID: <4F798D84.1070709@...1114...>
Date: Mon, 02 Apr 2012 13:29:08 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <0004-cleanup-avoid-using-0-windows.patch>
	<1333282357-2882-1-git-send-email-alon.barlev@...277...>
In-Reply-To: <1333282357-2882-1-git-send-email-alon.barlev@...277...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigD484A2FBA7A45BCA31E685C5"
Subject: Re: [Openvpn-devel] [PATCH 4/4] cleanup: avoid using ~0 - windows
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
--------------enigD484A2FBA7A45BCA31E685C5
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

On 01/04/12 14:12, Alon Bar-Lev wrote:
> Use the following constants:
> - METRIC_NOT_USED
> - TUN_ADAPTER_INDEX_INVALID
>=20
> Modified: Use MAXDWORD for route loop.
>=20
> Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
> ---
>  src/openvpn/route.c |   30 +++++++++++++++++-------------
>  src/openvpn/tun.c   |   46 +++++++++++++++++++++++-----------------------
>  src/openvpn/tun.h   |    2 ++
>  3 files changed, 42 insertions(+), 36 deletions(-)
>=20

Applied to master branches on -testing and -stable trees

commit 12e46092bad76b88bb7439e1c1666e987669cfb1
Author: Alon Bar-Lev <alon.barlev@...277...>
Date:   Sun Apr 1 15:12:37 2012 +0300

    Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
    Acked-by: Gert Doering <gert@...1296...>
    Signed-off-by: David Sommerseth <davids@...1347...>


kind regards,

David Sommerseth


--------------enigD484A2FBA7A45BCA31E685C5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk95jYQACgkQDC186MBRfrrg5gCgoBM0IjDXv7n/gkin1nyilmU4
tmoAn24QDoeFbrVrdrRi/OytBmUgyPT7
=VU6a
-----END PGP SIGNATURE-----

--------------enigD484A2FBA7A45BCA31E685C5--

