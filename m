Message-ID: <4FE445E4.10600@...1114...>
Date: Fri, 22 Jun 2012 12:16:04 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1340040904-23950-1-git-send-email-alon.barlev@...277...>
In-Reply-To: <1340040904-23950-1-git-send-email-alon.barlev@...277...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigD60268D6B86F18063B71FB31"
Subject: Re: [Openvpn-devel] [PATCH] cleanup: pkcs11.c: resolve wanings
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
--------------enigD60268D6B86F18063B71FB31
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 18/06/12 19:35, Alon Bar-Lev wrote:
> src/openvpn/pkcs11.c:794:2: warning: passing argument 1 of =E2=80=98pkcs1=
1h_setPINPromptHook=E2=80=99 from incompatible pointer type
>=20
> Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
> ---
>  src/openvpn/pkcs11.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>=20

ACK.  Applied to master.

commit befd6c2b98a65dbc968185a60fb4f9ecdee839b2
Author: Alon Bar-Lev <alon.barlev@...277...>
Date:   Mon Jun 18 20:35:04 2012 +0300

    cleanup: pkcs11.c: resolve wanings
=20=20=20=20
    src/openvpn/pkcs11.c:794:2: warning: passing argument 1 of
    =E2=80=98pkcs11h_setPINPromptHook=E2=80=99 from incompatible pointer ty=
pe
=20=20=20=20
    Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
    Acked-by: David Sommerseth <davids@...1347...>
    Message-Id: 1340040904-23950-1-git-send-email-alon.barlev@...277...
    URL: http://article.gmane.org/gmane.network.openvpn.devel/6738
    Signed-off-by: David Sommerseth <davids@...1347...>


kind regards,

David Sommerseth


--------------enigD60268D6B86F18063B71FB31
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk/kReQACgkQDC186MBRfrqnJQCgjH3K6c+wjFxHQNmXfIbhi9Ol
MwUAoLGoCgHczxxDE/+PAwea12sx9uk1
=aSlk
-----END PGP SIGNATURE-----

--------------enigD60268D6B86F18063B71FB31--

