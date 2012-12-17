Message-ID: <50CEEA1C.9000906@...1114...>
Date: Mon, 17 Dec 2012 10:47:08 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <20121204203156.GH22465@...1296...>
	<1355692520-24362-1-git-send-email-gert@...1296...>
In-Reply-To: <1355692520-24362-1-git-send-email-gert@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigC6E7E8E21B0437422BAB1A1A"
Subject: Re: [Openvpn-devel] [PATCH] Fix option inconsistency warnings about
 "proto" and "tun-ipv6"
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
--------------enigC6E7E8E21B0437422BAB1A1A
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

On 16/12/12 22:15, Gert Doering wrote:
> "tun-ipv6" is only sent in option string if running in point-to-point
> mode (=3D not --server and not --client or --pull), because in those
> scenarios it's usually pushed by the server, and the client does not
> yet have it when comparing options -> needless warning.
>=20
> Completely ignore "proto" values when comparing option strings - this
> is in preparation for removing proto from the option string in a future
> release, and to avoid warnings when 2.3 talks to this future release.
>=20
> Signed-off-by: Gert Doering <gert@...1296...>
> ---
>  src/openvpn/options.c |   12 +++++++++++-
>  1 files changed, 11 insertions(+), 1 deletions(-)

ACK.  Applied to master and beta/2.3


commit 3b860cf27b9374f6ebe67ff21011661f8ec391c6 (master)
commit f21410729e68b553f391dc036c0372fd3690714e (beta/2.3)
Author: Gert Doering <gert@...1296...>
Date:   Sun Dec 16 22:15:20 2012 +0100

    Fix option inconsistency warnings about "proto" and "tun-ipv6"

    Signed-off-by: Gert Doering <gert@...1296...>
    Acked-by: David Sommerseth <davids@...1347...>
    Message-Id: 1355692520-24362-1-git-send-email-gert@...1296...
    URL: http://article.gmane.org/gmane.network.openvpn.devel/7194
    Signed-off-by: David Sommerseth <davids@...1347...>



--=20
kind regards,

David Sommerseth


--------------enigC6E7E8E21B0437422BAB1A1A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlDO6h0ACgkQDC186MBRfrqhDwCfRfzCk9G24Zo4T6C/CLnSLE3U
COMAnA33wQ7NRe5B94f0NwXPLslvg7W3
=gYf8
-----END PGP SIGNATURE-----

--------------enigC6E7E8E21B0437422BAB1A1A--

