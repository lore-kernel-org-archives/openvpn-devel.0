References: <1601232360-14096-1-git-send-email-selva.nair@...277...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <cfb9e9a2-9aeb-9973-83fc-e71e3f34985c@...2080...>
Date: Mon, 28 Sep 2020 23:36:59 +0200
MIME-Version: 1.0
In-Reply-To: <1601232360-14096-1-git-send-email-selva.nair@...277...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="dx2brcRnbec0OY1l0pLgu1yMeKvUJODXM"
Subject: Re: [Openvpn-devel] [PATCH] Improve documentation of
 --username-as-common-name
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: selva.nair@...277..., openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--dx2brcRnbec0OY1l0pLgu1yMeKvUJODXM
Content-Type: multipart/mixed; boundary="r6piIozj2XXAdAnrbezUwxnkMYZTzU4cm";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
To: selva.nair@...277..., openvpn-devel@lists.sourceforge.net
Message-ID: <cfb9e9a2-9aeb-9973-83fc-e71e3f34985c@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] Improve documentation of
 --username-as-common-name
References: <1601232360-14096-1-git-send-email-selva.nair@...277...>
In-Reply-To: <1601232360-14096-1-git-send-email-selva.nair@...277...>

--r6piIozj2XXAdAnrbezUwxnkMYZTzU4cm
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 27/09/2020 20:46, selva.nair@...277... wrote:
> From: Selva Nair <selva.nair@...277...>
>=20
> Trac #1079
>=20
> Signed-off-by: Selva Nair <selva.nair@...277...>
> ---
>  doc/man-sections/server-options.rst | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>=20
> diff --git a/doc/man-sections/server-options.rst b/doc/man-sections/serve=
r-options.rst
> index c0b22a5..4b649b1 100644
> --- a/doc/man-sections/server-options.rst
> +++ b/doc/man-sections/server-options.rst
> @@ -668,9 +668,15 @@ fast hardware. SSL/TLS authentication must be used i=
n this mode.
>    ``--max-routes-per-client``
>=20=20
>  --username-as-common-name
> -  For ``--auth-user-pass-verify`` authentication, use the authenticated
> -  username as the common name, rather than the common name from the clie=
nt
> -  cert.
> +  Use the authenticated username as the common-name, rather than the
> +  common-name from the client certificate. Requires that some form of
> +  auth-user-pass verification is in effect. As the replacement happens a=
fter
> +  auth-user-pass verification, the verification script or plugin will st=
ill

The two occurrences of "auth-user-pass" should be: ``--auth-user-pass`` (wi=
th
"double-backwards-single-quotes" in both ends)

> +  receive the common-name from the certificate.
> +
> +  The common_name environment variable passed to scripts and plugins inv=
oked
> +  after authentication (e.g, client-connect script) and file names parse=
d in
> +  client-config directory will match the username.

I have not verified the behavior described, but I trust Selva's understandi=
ng
and testing.  The extension of this part is valuable and makes both the man
entry and behavior clearer.

The fix I've touched above can be handled at commit-time, unless Gert objec=
ts.

Acked-By: David Sommerseth <davids@...515...>

--=20
kind regards,

David Sommerseth
OpenVPN Inc



--r6piIozj2XXAdAnrbezUwxnkMYZTzU4cm--

--dx2brcRnbec0OY1l0pLgu1yMeKvUJODXM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJfcld/AAoJEIbPlEyWcf3yvHwQAJUuBuHR/p1/KjB7TCm5CdJd
qfvvwr8RtcYGswDpzPeIuKmMMHACyYNhGBfEVNs1HOSZHp8zee537f7c1FL4jut6
99+dJJdEAFZDD3qvLHiZEk8/4YqJ5UxHnm+7XmsoE9osFXYUkhqsx5NT6t9MN+Tf
kQvPhIJ0TH4Z6Vf5iGhM0lvkvLfDSyEhPPJttorAfbFuLq8JcSyVH0oWU/X5OBGx
BEDCzTwsuLM6W2t3wMGKFO5jICpnRnFC7Um2H7Rnt2NE6msV8bxhKd0Uv1DJvNyj
XkFEJZ7KjiBsprVFXHQgP6u4qYnLjYz3/ToGhX3ZI1UaMS5o8BqzfypY+chDZOck
DtdKyq+mxhbNPnGviZaXOVodTJaaiy6oYwZ9b8FFiULQ8tQEr/qoPOy4+yywRtjG
/Q6GvT9f4Wr21JOPtfg/lTNCF2EQzNNpOYdwAkEABTZqbko57VbSwCo+vM2frP4X
UTgB3oKMfLYis+8H5nYrpQJhWXNvnPPtC3mUDwINZ205G5EW6DK+6LfKtRPLH8VY
jvbEIe46L6OPM6Ed21gxHf0aeqcTiPTVLRItb4dSEVshIk8wAIqd1aoeBbcuinMz
8cjSKTrk7uVRrOUQlZ9+i/Br9e4JaWUoGB3V31S/emYYiLxVLIPa4SbQDycvmwjS
OyRcBAhCJCG6wQ+P3L+j
=jDo0
-----END PGP SIGNATURE-----

--dx2brcRnbec0OY1l0pLgu1yMeKvUJODXM--

