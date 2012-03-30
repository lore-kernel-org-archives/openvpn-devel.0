Message-ID: <4F761FE7.1020108@...1114...>
Date: Fri, 30 Mar 2012 23:04:39 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <CAOazyz06swLVgdoE1GPt2m9EEO7cvB2S8nBstn-a1ktDYtgH-Q@...278...>
	<1332960195-25301-1-git-send-email-alon.barlev@...277...>
In-Reply-To: <1332960195-25301-1-git-send-email-alon.barlev@...277...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigFE5A179B96146EA4FF558F9F"
Subject: Re: [Openvpn-devel] [PATCH] Enable pedantic in windows compilation
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
--------------enigFE5A179B96146EA4FF558F9F
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

On 28/03/12 20:43, Alon Bar-Lev wrote:
> Apparently -ansi undef WIN32 macro.
>=20
> Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
> ---
>  configure.ac |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
>=20

ACK!  Applied to master branches on -testing and -stable trees.


commit 31444111839f0720d6173a71f66fa3a988bcf9fb
Author: Alon Bar-Lev <alon.barlev@...277...>
Date:   Wed Mar 28 20:43:15 2012 +0200

    Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
    Acked-by: David Sommerseth <davids@...1347...>
    Signed-off-by: David Sommerseth <davids@...1347...>


kind regards,

David Sommerseth


--------------enigFE5A179B96146EA4FF558F9F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk92H+kACgkQDC186MBRfrp2xQCgqKcU1HAFg35XHcv1mohNhqUI
TvAAnjUlklMZidLjcnB0qR8iMafwCix5
=xQf+
-----END PGP SIGNATURE-----

--------------enigFE5A179B96146EA4FF558F9F--

