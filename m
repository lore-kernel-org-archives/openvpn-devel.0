Message-ID: <5043B7EB.1030109@...1114...>
Date: Sun, 02 Sep 2012 21:47:55 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <20120807093930.GK2535@...1296...>
	<1344333837-22076-1-git-send-email-arne@...1227...>
In-Reply-To: <1344333837-22076-1-git-send-email-arne@...1227...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig90C132866E4968846D5E1DED"
Subject: Re: [Openvpn-devel] [Version 4] Merge getaddr_multi and getaddr6
 into one function
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
--------------enig90C132866E4968846D5E1DED
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

On 07/08/12 12:03, Arne Schwabe wrote:
> the getaddr6 and getaddr_mutli functions are duplicates of each other. Si=
nce we always require getaddrinfo to be present both function are merge int=
o one openvpn_getaddrinfo.
>=20
> This functions also returns a standard struct addrinfo* so our resolve in=
terface is closer to the standard unix interface. The getaddr function is a=
 wrapper which provides backward compatibility for IPv4 addresses. Ipv6 cal=
ls and calls to getaddr_multi are replaced with the new interface.
>=20
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>  src/openvpn/route.c  |   50 ++---
>  src/openvpn/socket.c |  594 ++++++++++++++++----------------------------=
------
>  src/openvpn/socket.h |   17 +-
>  3 files changed, 220 insertions(+), 441 deletions(-)

Applied to master.

commit f2d6f3bc06db4f9e0815fc25e35e393f794c193a
Author: Arne Schwabe <arne@...1227...>
Date:   Tue Aug 7 12:03:57 2012 +0200

    Merge getaddr_multi and getaddr6 into one function

    Signed-off-by: Arne Schwabe <arne@...1227...>
    Acked-by: Gert Doering <gert@...1296...>
    Message-Id: 1344333837-22076-1-git-send-email-arne@...1227...
    URL: http://article.gmane.org/gmane.network.openvpn.devel/6959
    Signed-off-by: David Sommerseth <davids@...1347...>


kind regards,

David Sommerseth


--------------enig90C132866E4968846D5E1DED
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlBDt+0ACgkQDC186MBRfrrjMACdFWI4FVsxRmmv3EGFXiTbK60I
SWQAn0PcbphhgGTPxoN+mu+1gTfGrcKt
=a0yV
-----END PGP SIGNATURE-----

--------------enig90C132866E4968846D5E1DED--

