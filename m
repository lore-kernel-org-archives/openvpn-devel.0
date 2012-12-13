Message-ID: <50C9FA2E.60906@...1114...>
Date: Thu, 13 Dec 2012 16:54:22 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1354650174-25601-1-git-send-email-arne@...1227...>
In-Reply-To: <1354650174-25601-1-git-send-email-arne@...1227...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig3F4AAFA76BE66FEA6086EB46"
Subject: Re: [Openvpn-devel] [PATCH] Fix the proto is used inconsistently
 warning
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
--------------enig3F4AAFA76BE66FEA6086EB46
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

On 04/12/12 20:42, Arne Schwabe wrote:
> Fix the "WARNING: 'proto' is used inconsistently, local=3D'proto UDP', re=
mote=3D'proto UDPv6'." message.
>=20
> Note that the on wire strings are now always TCPv4 and UDPv4 to be compat=
ible to pre2.3
>=20
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>  src/openvpn/socket.c |   22 ++++++++++++++++++----
>  1 file changed, 18 insertions(+), 4 deletions(-)

Applied to master and beta/2.3

commit 38727e09df35245ba0cfe335e23e6b43c817ce58 (master)
commit 34bc52d611deec62e7fe56622771b58921d52176 (beta/2.3)
Author: Arne Schwabe <arne@...1227...>
Date:   Tue Dec 4 20:42:54 2012 +0100

    Fix the proto is used inconsistently warning

    Signed-off-by: Arne Schwabe <arne@...1227...>
    Acked-by: Gert Doering <gert@...1296...>
    Message-Id: 1354650174-25601-1-git-send-email-arne@...1227...
    URL: http://article.gmane.org/gmane.network.openvpn.devel/7175
    Signed-off-by: David Sommerseth <davids@...1347...>


--=20
kind regards,

David Sommerseth


--------------enig3F4AAFA76BE66FEA6086EB46
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlDJ+i4ACgkQDC186MBRfroY0gCfRLqg7au2gF065AYXJ/EPj0T+
eGEAnjdWYoFGMnPik5URCnejSLLERfJc
=rUnQ
-----END PGP SIGNATURE-----

--------------enig3F4AAFA76BE66FEA6086EB46--

