Message-ID: <4FD86BB6.4050307@...1114...>
Date: Wed, 13 Jun 2012 12:30:14 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <20120607174255.GV1059@...1296...>
In-Reply-To: <20120607174255.GV1059@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig7C7181E24285E70B22BB7BB9"
Subject: Re: [Openvpn-devel] another t_client.sh patch...
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
--------------enig7C7181E24285E70B22BB7BB9
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

On 07/06/12 19:42, Gert Doering wrote:
>=20
> From b5b301591ef0804084bd661d090d36aa44100101 Mon Sep 17 00:00:00 2001
> From: Gert Doering <gert@...1296...>
> Date: Thu, 7 Jun 2012 17:35:53 +0200
> Subject: [PATCH] t_client.sh - fix for iproute2, print summary line
>=20
> Yet another postprocess-output fix for iproute2 (sometimes there was
> no whitespace in the output, so substituting away expiry time failed).
>=20
> Print summary line of succeeded and failed test sets at the very end.
>=20
> Signed-off-by: Gert Doering <gert@...1296...>
> ---
>  tests/t_client.sh.in |   12 +++++++++++-
>  1 files changed, 11 insertions(+), 1 deletions(-)

ACK.  Applied to master.

commit 64a6bdf73cd624939a8f597fc5330b946f6bf1f1
Author: Gert Doering <gert@...1296...>
Date:   Thu Jun 7 17:35:53 2012 +0200

    t_client.sh - fix for iproute2, print summary line

    Signed-off-by: Gert Doering <gert@...1296...>
    Acked-by: David Sommerseth <davids@...1347...>
    Message-Id: 20120607174255.GV1059@...1296...
    URL: http://article.gmane.org/gmane.network.openvpn.devel/6704
    Signed-off-by: David Sommerseth <davids@...1347...>


kind regards,

David Sommerseth


--------------enig7C7181E24285E70B22BB7BB9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk/Ya7YACgkQDC186MBRfrr+cACeNRbwtBM1vKOuiWrruEIkOWee
tfAAn2OZTurnl0dtVg3wN8JdsIPzTtrc
=2J3B
-----END PGP SIGNATURE-----

--------------enig7C7181E24285E70B22BB7BB9--

