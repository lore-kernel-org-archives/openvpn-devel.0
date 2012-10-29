Message-ID: <508EA9FD.1040906@...1114...>
Date: Mon, 29 Oct 2012 17:08:29 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1351516597-11128-1-git-send-email-heiko.hund@...1489...>
In-Reply-To: <1351516597-11128-1-git-send-email-heiko.hund@...1489...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig502823399AD1E253091C49ED"
Subject: Re: [Openvpn-devel] [PATCH] support UTF-8 --client-config-dir
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
--------------enig502823399AD1E253091C49ED
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 29/10/12 14:16, Heiko Hund wrote:
> If a common name (or user name, when used in conjunction with
> --username-as-common-name) contains UTF-8 encoded characters their
> octets get replaced by underscores. This becomes problematic when
> user "M=C3=BCller" and "M=C3=B6ller" need to have a CCD files and both wo=
uld
> be receive options from the file "M__ller". The situation is even
> worse for non-latin alphabets, where CCD file names consist of
> underscores entirely.
>=20
> This patch removes that limitation and also allows the file names
> to contain any punctuation characters besided the resevered ones.
>=20
> Signed-off-by: Heiko Hund <heiko.hund@...1489...>
> ---
>  src/openvpn/buffer.c |   10 ++++++++++
>  src/openvpn/buffer.h |    5 +++++
>  src/openvpn/misc.c   |    8 +++++++-
>  3 files changed, 22 insertions(+), 1 deletion(-)
>=20

ACK.  Applied to master and beta/2.3.


commit 9885f57e3ac8d2e32ba20ca84f6bdd0a1a995eac (master)
commit d442b8dbc4230e4252a63fbd57f149ef3fa090c8 (beta/2.3)
Author: Heiko Hund <heiko.hund@...1489...>
Date:   Mon Oct 29 14:16:37 2012 +0100

    Support UTF-8 --client-config-dir
=20=20=20=20
    Signed-off-by: Heiko Hund <heiko.hund@...1489...>
    Acked-by: David Sommerseth <davids@...1347...>
    Message-Id: 1351516597-11128-1-git-send-email-heiko.hund@...1489...
    URL: http://article.gmane.org/gmane.network.openvpn.devel/7110
    Signed-off-by: David Sommerseth <davids@...1347...>


kind regards,

David Sommerseth


--------------enig502823399AD1E253091C49ED
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlCOqf0ACgkQDC186MBRfrrMSACeO1zqstuLuUDVIM7JCSaGimB3
6C8AoIf5t39NEzwi0bt0GT6c/epGwc5e
=UMFA
-----END PGP SIGNATURE-----

--------------enig502823399AD1E253091C49ED--

