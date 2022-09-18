Date: Sun, 18 Sep 2022 18:25:33 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <YydGffOjq1jROPN2@...1296...>
References: <20220520213250.3126372-1-arne@...1227...>
 <20220914170134.2659433-1-arne@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="joUg3bTtlC5Zduh8"
Content-Disposition: inline
In-Reply-To: <20220914170134.2659433-1-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH v4] Implement AUTH_FAIL,
 TEMP message support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

--joUg3bTtlC5Zduh8
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Sep 14, 2022 at 07:01:34PM +0200, Arne Schwabe wrote:
>  src/openvpn/openvpn.vcxproj          |   2 +

This file is still gone, so the hunk also needs to go.  But I can=20
ignore this.

> diff --git a/doc/man-sections/script-options.rst b/doc/man-sections/scrip=
t-options.rst
> index 61c89b0ad..2a2e70fca 100644
> --- a/doc/man-sections/script-options.rst
> +++ b/doc/man-sections/script-options.rst
> @@ -102,6 +102,42 @@ SCRIPT HOOKS
>    the authentication, a :code:`1` or :code:`0` must be written to the
>    file specified by the :code:`auth_control_file`.
>=20=20
> +  If the file specified by :code:`auth_failed_reason` exists and has non=
-empty

If this is referring to the environment variable, it needs to be
"auth_failed_reason_file".  If you agree, I'll change that on merge.

[..]

> diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
> index 71648ef18..79a3f9574 100644
> --- a/src/openvpn/Makefile.am
> +++ b/src/openvpn/Makefile.am
> @@ -101,6 +101,7 @@ openvpn_SOURCES =3D \
>  	pkcs11_mbedtls.c \
>  	openvpn.c openvpn.h \
>  	options.c options.h \
> +    options_util.c options_util.h \

Makefile wants a real TAB here, which I'll fix on commit.

More detailed stare-at-code and test to follow.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--joUg3bTtlC5Zduh8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJjJ0Z9AAoJEB2Cnv7KVigS4VoL/Rv95Euy5qJjC/kdT2QC1up3
AZbX3sR+WL0ZAA0oG+QaVU35t/nCrMrEqRof5FgZ9n/0cFCoGGjk+UQuPltMZKg0
8lExT5YgCPwpsYV0cRgt//YlI1liYhpFA74pPkxDwmmKwr1uABftwKMuZhhrNLwU
rt5KjXa5e4HQMf+h0WROTU0c/EmXTOvWVaS9fXYt3W2TGUEkFTNmNEVyz3T5fzMy
9EZJvYdYPk6qUH5FWcnMS1HGxvdfQk/RLOqABb3tccbE027EDzYyPtnVOZcnd+eX
aKEPqvfTS7zBEQ6BZ4ooZOfzNy1l6Fv0abxId9S+KEngkpWKgJ0tQ4LpCy5sKGn5
yaBT1g+78XxomJcG7dw5skdyfYK8TZarZUXXo6YTSf3XGmWCWyyZLzyNuvi1owsE
LuwIPvkt/eT8Xg8KgplK4Mrt9uKCSucAIH0ygM/cdJ0TwktzluUHjT0K4J9PSbtu
8z5d1F5x9h2pCMheQGi8N7B8BJrkK8iaDLA5fv7u5w==
=E7D2
-----END PGP SIGNATURE-----

--joUg3bTtlC5Zduh8--

