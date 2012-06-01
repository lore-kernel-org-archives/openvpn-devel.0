Message-ID: <4FC8B7A5.9050605@...1114...>
Date: Fri, 01 Jun 2012 14:37:57 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1336813338-9219-1-git-send-email-alon.barlev@...277...>
In-Reply-To: <1336813338-9219-1-git-send-email-alon.barlev@...277...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigA0763A468763151074E271B7"
Subject: Re: [Openvpn-devel] [PATCH] build: detect sys/wait.h required for
 *bsd
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
--------------enigA0763A468763151074E271B7
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

On 12/05/12 11:02, Alon Bar-Lev wrote:
> Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
> ---
>  configure.ac |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>=20

Applied to master branch.

commit f641637a73663dc44d9ef2c3fe82ea557d3cda02
Author: Alon Bar-Lev <alon.barlev@...277...>
Date:   Sat May 12 12:02:18 2012 +0300

    build: detect sys/wait.h required for *bsd
=20=20=20=20
    Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
    Acked-by: Gert Doering <gert@...1296...>
    Message-Id: 1336813338-9219-1-git-send-email-alon.barlev@...277...
    URL: http://article.gmane.org/gmane.network.openvpn.devel/6532
    Signed-off-by: David Sommerseth <davids@...1347...>


kind regards,

David Sommerseth


--------------enigA0763A468763151074E271B7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk/It6UACgkQDC186MBRfrpf2wCgn/+M6E3GPE9Ji4dtnLC2aNKN
5CcAnjsagNlhOHkoE05lYEVIqu8uA86o
=uSt9
-----END PGP SIGNATURE-----

--------------enigA0763A468763151074E271B7--

