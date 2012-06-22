Message-ID: <4FE445E1.5010309@...1114...>
Date: Fri, 22 Jun 2012 12:16:01 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1340044749-10694-1-git-send-email-arne@...1227...>
	<1340044749-10694-4-git-send-email-arne@...1227...>
In-Reply-To: <1340044749-10694-4-git-send-email-arne@...1227...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig682A20D9B0D1B7663D750406"
Subject: Re: [Openvpn-devel] [PATCH 3/6] Remove ENABLE_INLINE_FILES
 conditionals,
 this code is always enabled and removing the #ifdef make the code a little
 bit clearer
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig682A20D9B0D1B7663D750406
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

On 18/06/12 20:39, Arne Schwabe wrote:
>=20
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>  src/openvpn/common.h       |    2 --
>  src/openvpn/crypto.c       |    6 ------
>  src/openvpn/init.c         |    4 ----
>  src/openvpn/misc.c         |    6 ------
>  src/openvpn/options.c      |   24 ------------------------
>  src/openvpn/options.h      |    6 ------
>  src/openvpn/ssl_backend.h  |   36 ++++++++++--------------------------
>  src/openvpn/ssl_openssl.c  |   39 +++++++--------------------------------
>  src/openvpn/ssl_polarssl.c |   34 ++++++----------------------------
>  src/openvpn/syshead.h      |    8 --------
>  10 files changed, 23 insertions(+), 142 deletions(-)

Applied to master.

commit 31f83cc7ce798c4e355480532f77640b78d74695
Author: Arne Schwabe <arne@...1227...>
Date:   Mon Jun 18 20:39:06 2012 +0200

    Remove ENABLE_INLINE_FILES conditionals
=20=20=20=20
    This code is always enabled and removing the #ifdef make the code a lit=
tle bit clearer
=20=20=20=20
    Signed-off-by: Arne Schwabe <arne@...1227...>
    Acked-by: James Yonan <james@...515...>
    Message-Id: 1340044749-10694-4-git-send-email-arne@...1227...
    URL: http://article.gmane.org/gmane.network.openvpn.devel/6746
    Signed-off-by: David Sommerseth <davids@...1347...>


kind regards,

David Sommerseth


--------------enig682A20D9B0D1B7663D750406
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk/kReEACgkQDC186MBRfrojwACgh6Bbc+MtBtbGE9FEm/pBjG43
oFoAn2XuFgccD7dddNy4lDPTI1C6KCD1
=Eu4l
-----END PGP SIGNATURE-----

--------------enig682A20D9B0D1B7663D750406--

