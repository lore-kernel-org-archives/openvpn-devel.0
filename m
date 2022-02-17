Date: Thu, 17 Feb 2022 17:05:08 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <Yg5yNBEMmt4VIgsc@...1296...>
References: <20220217142306.8108-1-a@...2181...>
 <20220217143241.18766-1-a@...2181...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="rGvFOIDYDjFNsU2+"
Content-Disposition: inline
In-Reply-To: <20220217143241.18766-1-a@...2181...>
Subject: Re: [Openvpn-devel] [PATCH v2] crypto: unify key_type creation code
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net

--rGvFOIDYDjFNsU2+
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Feb 17, 2022 at 03:32:41PM +0100, Antonio Quartulli wrote:
> At the moment we have tls_crypt_kt() and auth_token_kt that basically do
> the same thing, but with different algorithms used to inizialise the
> structure.
>=20
> In order to avoid code duplication and copy/paste errors, unify code and
> make it parametric, so that it can be re-used in various places.
>=20
> Signed-off-by: Antonio Quartulli <a@...2181...>

NAK.  Please run "make check" on your patches :-)

../../../../openvpn/tests/unit_tests/openvpn/test_auth_token.c:95:15: warni=
ng: implicit declaration of
      function 'auth_token_kt' is invalid in C99 [-Wimplicit-function-decla=
ration]
    ctx->kt =3D auth_token_kt();
              ^
../../../../openvpn/tests/unit_tests/openvpn/test_auth_token.c:95:13: error=
: assigning to 'struct key_type'
      from incompatible type 'int'
    ctx->kt =3D auth_token_kt();
            ^ ~~~~~~~~~~~~~~~

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--rGvFOIDYDjFNsU2+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJiDnI0AAoJEB2Cnv7KVigSm1oL/R41d8B7q46Rlh547CQDljzC
gaHF+AwqY15Id8qSzkkTkEaW+hK5HJMziZT7mHja9Kyb1H5zl3EJ7O0Vlawpok+b
CLreKORx4XIBlqi+zteH2/Yx3lTG2OmpJyv9PQXwlHA+EM01HZeEjZ4eFagithUR
AAUsWLeLZDHdhYZ/bqecKqUi4sNu4Pbp1589rClBzHXrJC/pps9M671SG/xzZXd/
jgNlKwfDAqrHxXlhfLvt5G3gqMWFDlJ0TEvc9YEJthitvm1TymGm+MBm/D7B6lV9
CY1N49Bq7vfuD5qoxGLhXWuEQT3BnfcjBnjreiO9r1skVE4L0Pbk6raKprlXwwYs
f5vvHuxhElnM8YxaMA8pjflHbMMh6CKpsAFTB6oDCrMBrX04HJ2DdzA0aCSivlf6
dK12q5pU8KScjZ13DTT505xMBLnotGesUhiFlVbwYcQzZbdZCqEx6ly4TuUAPeag
B7Ajn/eQM8zqypBJ3y9pXVQrfYLOXj22SwlJ0OPh9g==
=Rqst
-----END PGP SIGNATURE-----

--rGvFOIDYDjFNsU2+--

