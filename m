Date: Wed, 27 Jul 2022 20:39:37 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <YuGGabwyTZRxE4dq@...1296...>
References: <20220726115100.31449-1-selva.nair@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="IIrgZtsZ5iEblV48"
Content-Disposition: inline
In-Reply-To: <20220726115100.31449-1-selva.nair@...277...>
Subject: Re: [Openvpn-devel] [PATCH] xkey_provider: fix building with
 --disable-management
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: selva.nair@...277...
Cc: openvpn-devel@lists.sourceforge.net

--IIrgZtsZ5iEblV48
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Jul 26, 2022 at 07:51:00AM -0400, selva.nair@...277... wrote:
> From: Selva Nair <selva.nair@...277...>
>=20
> Signed-off-by: Selva Nair <selva.nair@...277...>
> ---
>  src/openvpn/xkey_helper.c | 4 ++++
>  1 file changed, 4 insertions(+)

Close ;-)

This fixes compilation of xkey_helper.c for --disable-management, but
"make check" still fails in test_provider.c

In file included from test_provider.c:38:
test_provider.c: In function 'init_test':
test_provider.c:130:36: error: invalid application of 'sizeof' to incomplet=
e type 'struct management'
  130 |     management =3D test_calloc(sizeof(*management), 1);
      |                                    ^
test_provider.c: In function 'xkey_provider_test_mgmt_sign_cb':
test_provider.c:290:19: error: invalid use of undefined type 'struct manage=
ment'
  290 |         management->settings.flags =3D MF_EXTERNAL_KEY|MF_EXTERNAL_=
KEY_PSSPAD;
      |                   ^~
test_provider.c:290:38: error: 'MF_EXTERNAL_KEY' undeclared (first use in t=
his function)
  290 |         management->settings.flags =3D MF_EXTERNAL_KEY|MF_EXTERNAL_=
KEY_PSSPAD;
      |                                      ^~~~~~~~~~~~~~~
(and a few more)

... can I have a v2, please?

thanks ;-)

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--IIrgZtsZ5iEblV48
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJi4YZpAAoJEB2Cnv7KVigSdWcL/23V96haiQnSGU7ckshGA18J
4UlR+VBC4WWdPW0JEbHq7Qzw8QY0y3pslxYwvvld6Ww22zI+Ar4wJS2YwtYqCAVg
6+wQirITWJu0dNtUK9N342Q7wYD1r0k2nnUbWKdw7Z7Mmup58RUBtv0m8Y3ChQL2
SRg1rqzNxVSc7dm4VJVtUtsfeirlC4i3HI3T+ZxprcGwqAzxfyZuzLCXORTKFjDp
gFJnSxpZMoQWFx3Jnv27a9duiAGdQDd3pDRRdcgF7nwVVZSVowcjap7c0ulzHAIQ
ASAQh1AGFQb4xvz7xGgh9mmBxmPnnIdVBoTc6BFQMX2aVSBFuHReBirj7UhfwoGF
kBuIbueRVCzm6RT6qq8ShzcEwbWCrJsCK2AD4ui0bueO8DeaNvMVRHWpFWZxdX9x
Dn6UT0CjEx/UgnO/yP1H93mUOPuB3zx2TlX1E8PlB+/qoxsDhsxHnggrrg6f8PUY
+GJ6B+MzKNEX3Mm1fIDnwPmUPQA1qRCptB+9l2GpXg==
=0VlP
-----END PGP SIGNATURE-----

--IIrgZtsZ5iEblV48--

