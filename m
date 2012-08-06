Message-ID: <501FBA61.6030705@...1114...>
Date: Mon, 06 Aug 2012 14:36:49 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1343821058-11456-1-git-send-email-heiko.hund@...1489...>
	<1343821058-11456-2-git-send-email-heiko.hund@...1489...>
In-Reply-To: <1343821058-11456-2-git-send-email-heiko.hund@...1489...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigED1B661A37CE86C3BC796047"
Subject: Re: [Openvpn-devel] [PATCH 1/2] add x_msg_va() log function
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
--------------enigED1B661A37CE86C3BC796047
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

On 01/08/12 13:37, Heiko Hund wrote:
> This change allows other functions to access the functionality in x_msg().
> Needed for the plug-in logging API.
>=20
> Signed-off-by: Heiko Hund <heiko.hund@...1489...>
> ---
>  src/openvpn/error.c |   11 ++++++++---
>  src/openvpn/error.h |    2 ++
>  2 files changed, 10 insertions(+), 3 deletions(-)
>=20

ACK.  Applied to master.

commit 004ca97c9427841cc240f954d7594416cd249187
Author: Heiko Hund <heiko.hund@...1489...>
Date:   Wed Aug 1 13:37:37 2012 +0200

    add x_msg_va() log function
=20=20=20=20
    Signed-off-by: Heiko Hund <heiko.hund@...1489...>
    Acked-by: David Sommerseth <davids@...1347...>
    Message-Id: 1343821058-11456-2-git-send-email-heiko.hund@...1489...
    URL: http://article.gmane.org/gmane.network.openvpn.devel/6923
    Signed-off-by: David Sommerseth <dazo@...384...>


kind regards,

David Sommerseth


--------------enigED1B661A37CE86C3BC796047
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlAfumMACgkQDC186MBRfroUuwCcCud9RB2c2GfYdFAx/f7B453c
TYMAmwWHNR8zyj5SKqg8zYU/SYoXaoCA
=GEgo
-----END PGP SIGNATURE-----

--------------enigED1B661A37CE86C3BC796047--

