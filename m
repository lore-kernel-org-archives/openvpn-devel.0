Message-ID: <5043B802.3000808@...1114...>
Date: Sun, 02 Sep 2012 21:48:18 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <5DDA5487-D6B2-4EF2-8F20-D4324FBEB843@...1286...>
	<1345140549-29256-1-git-send-email-gert@...1296...>
In-Reply-To: <1345140549-29256-1-git-send-email-gert@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig07E33108EE1EE7595F6AE239"
Subject: Re: [Openvpn-devel] [PATCH] Keep pre-existing tun/tap devices
 around on *BSD
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
--------------enig07E33108EE1EE7595F6AE239
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

On 16/08/12 20:09, Gert Doering wrote:
> This amends commit 62c613d46dc49 to check whether a named tun/tap
> device ("--dev tunX" instead of "--dev tun") exists before OpenVPN
> started - if yes, keep around at program end.  If no, destroy.
>=20
> Also has a spelling fix, and changes clear_tuntap() to be "static"
> (only ever called from within tun.c).
>=20
> Tested on FreeBSD 7.4, FreeBSD 9.0, NetBSD 5.1, OpenBSD 4.9
>=20
> Signed-off-by: Gert Doering <gert@...1296...>
> Acked-by: Eric Crist <ecrist@...1286...>
> ---
>  src/openvpn/tun.c |   22 +++++++++++++++++-----
>  src/openvpn/tun.h |    4 +++-
>  2 files changed, 20 insertions(+), 6 deletions(-)

Applied to master.

commit 3630a7a50099874d55bf8e212ad4a97d6e70966f
Author: Gert Doering <gert@...1296...>
Date:   Thu Aug 16 20:09:09 2012 +0200

    Keep pre-existing tun/tap devices around on *BSD
=20=20=20=20=20=20=20=20
    Signed-off-by: Gert Doering <gert@...1296...>
    Acked-by: Eric Crist <ecrist@...1286...>
    Signed-off-by: David Sommerseth <davids@...1347...>


kind regards,

David Sommerseth


--------------enig07E33108EE1EE7595F6AE239
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlBDuAIACgkQDC186MBRfroS3QCdEf4sW44AoGI8stEwxpwLDjyv
iwQAoJKZQ3yEoe3EdO9xNDUVVmNkhft3
=Ozfe
-----END PGP SIGNATURE-----

--------------enig07E33108EE1EE7595F6AE239--

