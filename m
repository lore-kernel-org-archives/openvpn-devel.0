Message-ID: <50C9FA21.2080904@...1114...>
Date: Thu, 13 Dec 2012 16:54:09 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1354482672-16136-1-git-send-email-gert@...1296...>
	<1354482672-16136-2-git-send-email-gert@...1296...>
In-Reply-To: <1354482672-16136-2-git-send-email-gert@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig4E826C65F3C5620D9C5ECF65"
Subject: Re: [Openvpn-devel] [PATCH] Implement --mssfix handling for IPv6
 packets.
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
--------------enig4E826C65F3C5620D9C5ECF65
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

On 02/12/12 22:11, Gert Doering wrote:
> Rename process_ipv4_header() to process_ip_header() and PIPV4_MSSFIX
> flag to PIP_MSSFIX, to make visible that it's no longer IPv4-only.
>=20
> Inside process_ip_header(), call out to mss_fixup_ipv6() if --mssfix
> is active and IPv6 packet seen.
>=20
> Rename mss_fixup() to mss_fixup_ipv4(), implement mss_fixup_ipv6().
>=20
> Signed-off-by: Gert Doering <gert@...1296...>
> ---
>  src/openvpn/forward.c |   26 +++++++++++++--------
>  src/openvpn/forward.h |    4 +-
>  src/openvpn/mss.c     |   57 +++++++++++++++++++++++++++++++++++++++++++=
+++++-
>  src/openvpn/mss.h     |    3 +-
>  src/openvpn/multi.c   |    6 ++--
>  src/openvpn/proto.c   |   19 +++++++++++++--
>  src/openvpn/proto.h   |    3 +-
>  7 files changed, 97 insertions(+), 21 deletions(-)

Applied in master and beta/2.3


commit f0e8997a874a89b3fe1f82109c443232e8967b01 (master)
commit 729c8464021ff7c41a7fbb03501465eca55909a3 (beta/2.3)
Author: Gert Doering <gert@...1296...>
Date:   Sun Dec 2 22:11:12 2012 +0100

    Implement --mssfix handling for IPv6 packets.

    Signed-off-by: Gert Doering <gert@...1296...>
    Acked-by: Arne Schwabe <arne@...1227...>
    Message-Id: 1354482672-16136-2-git-send-email-gert@...1296...
    URL: http://article.gmane.org/gmane.network.openvpn.devel/7173
    Signed-off-by: David Sommerseth <davids@...1347...>



--=20
kind regards,

David Sommerseth


--------------enig4E826C65F3C5620D9C5ECF65
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlDJ+iEACgkQDC186MBRfrqbYACfaOTEzJvR+jv9biSOZVeNUrz2
G4kAnRTsS+HBsdoNQDjHuo/MhGuxkVIN
=xmeu
-----END PGP SIGNATURE-----

--------------enig4E826C65F3C5620D9C5ECF65--

