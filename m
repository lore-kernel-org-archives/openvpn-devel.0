Message-ID: <50D2D3E3.9090208@...1114...>
Date: Thu, 20 Dec 2012 10:01:23 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <20121217220355.GB23292@...1794...>
	<20121219212619.GN22465@...1296...>
In-Reply-To: <20121219212619.GN22465@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigF4E1E7D1207789E148D95AFE"
Subject: Re: [Openvpn-devel] Fixing "passtos" on !Linux
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
--------------enigF4E1E7D1207789E148D95AFE
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

On 19/12/12 22:26, Gert Doering wrote:
> Hi,
>=20
> On Mon, Dec 17, 2012 at 11:03:55PM +0100, Jeremie Le Hen wrote:
>> I thereby kindly ask you to bring this patch in the source tree.  I
>> don't know about your release procedure, but it would be really nice if
>> it could hit the tree before 2.3 is released.
>=20
> Thanks for the excessive links to documentation - it helps verifying
> things.  I agree that this is a useful last-minute correction and should
> go in (feature-ACK).
>=20
> I don't particularily like the way your patch is coded, though, as it's
> "all of them but Linux" that have "int" here (except Windows, which uses
> DWORD, but the docs say "use QoS API instead") - too many #ifdefs.
>=20
> http://msdn.microsoft.com/en-us/library/windows/desktop/ms738586(v=3Dvs.8=
5).aspx
>=20
> so I'd propose to #ifdef it differently, patch appended.
>=20

> From b6e0f27b4e6965de14cf0ec3e901a52d256cc88a Mon Sep 17 00:00:00 2001
> From: Gert Doering <gert@...1296...>
> Date: Wed, 19 Dec 2012 22:12:41 +0100
> Subject: [PATCH] Fix parameter type for IP_TOS setsockopt on non-Linux
>  systems.
>=20
> Linux uses uint8_t, all BSD based stacks and Solaris use "int"  (Windows
> documentation says "DWORD" and "do not use, use QoS API instead").
>=20
> Bug reported and fix provided by Torsten Vielhak and Jeremie Le Hen.
>=20
> Signed-off-by: Gert Doering <gert@...1296...>
> ---
>  src/openvpn/socket.h |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)

ACK.  Applied to master and beta/2.3


commit d39f31d96378aa5eeade74670ffd9e08bf4c7234 (master)
commit a28048a20f46f718c3df3af95e230ab72234f915 (beta/2.3)
Author: Gert Doering <gert@...1296...>
Date:   Wed Dec 19 22:12:41 2012 +0100

    Fix parameter type for IP_TOS setsockopt on non-Linux systems.
=20=20=20=20
    Signed-off-by: Gert Doering <gert@...1296...>
    Acked-by: David Sommerseth <davids@...1347...>
    Message-Id: 20121219212619.GN22465@...1296...
    URL: http://article.gmane.org/gmane.network.openvpn.devel/7207
    Signed-off-by: David Sommerseth <davids@...1347...>


--=20
kind regards,

David Sommerseth


--------------enigF4E1E7D1207789E148D95AFE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlDS0+UACgkQDC186MBRfroWCQCgsXa2n6uiD2TvujGkxbMYpFBm
nZYAoIgYC2mkIpFPxdAkR4FI26Tp7vFo
=AU9n
-----END PGP SIGNATURE-----

--------------enigF4E1E7D1207789E148D95AFE--

