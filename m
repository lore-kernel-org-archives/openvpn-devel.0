Message-ID: <4FC934FF.1060307@...1114...>
Date: Fri, 01 Jun 2012 23:32:47 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1336036240-23838-1-git-send-email-dazo@...384...>
In-Reply-To: <1336036240-23838-1-git-send-email-dazo@...384...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig938327EB977927B2C591CF59"
Subject: Re: [Openvpn-devel] [PATCH] Remove two unused functions
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
--------------enig938327EB977927B2C591CF59
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

On 03/05/12 11:10, David Sommerseth wrote:
> From: David Sommerseth <davids@...1347...>
>=20
> Both is_persist_option() and is_stateful_restart() functions where never
> used anywhere in the code.  Remove them.
>=20
> Signed-off-by: David Sommerseth <davids@...1347...>
> ---
>  src/openvpn/options.c |   16 ----------------
>  src/openvpn/options.h |    3 ---
>  2 files changed, 0 insertions(+), 19 deletions(-)

ACKed by Gert in IRC during the meeting on Thursday.  Applied to master bra=
nch.


commit e8298885350131ce453da54a1b07495253ee1508
Author: David Sommerseth <davids@...1347...>
Date:   Thu May 3 11:10:40 2012 +0200

    Remove two unused functions
=20=20=20=20
    Signed-off-by: David Sommerseth <davids@...1347...>
    Acked-by: Gert Doering <gert@...1296...>
    Message-Id: 1336036240-23838-1-git-send-email-dazo@...384...
    URL: http://article.gmane.org/gmane.network.openvpn.devel/6402


kind regards,

David Sommerseth


--------------enig938327EB977927B2C591CF59
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk/JNQAACgkQDC186MBRfrop0QCfUJ+z/IVPVOW/IwwWKjtrR5ee
qpoAn3hXVhA2M8FSjAnn+OHI5mXKoreF
=0QGS
-----END PGP SIGNATURE-----

--------------enig938327EB977927B2C591CF59--

