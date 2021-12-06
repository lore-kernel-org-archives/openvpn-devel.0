Date: Mon, 6 Dec 2021 08:06:09 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <Ya22Yc1Z85eJ6u55@...1296...>
References: <20211201180727.2496903-1-arne@...1227...>
 <20211206005740.3072232-1-arne@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="r390sa7DqEY80bru"
Content-Disposition: inline
In-Reply-To: <20211206005740.3072232-1-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH v2 1/9] Implement optional cipher in
 --data-ciphers prefixed with ?
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

--r390sa7DqEY80bru
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Dec 06, 2021 at 01:57:40AM +0100, Arne Schwabe wrote:
> This allows to use the same configuration multiple platforms/ssl libraries
> and include optional algorithms that are not available on all platforms
>=20
> For example "AES-256-GCM:AES-128-GCM:?CHACHA20-POLY1305" can be used to
> emulate the default behaviour of OpenVPN 2.6.
>=20
> Patch v2: fix error_found reset by optional cipher, fix typo in Changes.r=
st
>=20
> Signed-off-by: Arne Schwabe <arne@...1227...>
[..]
> diff --git a/src/openvpn/ssl_ncp.c b/src/openvpn/ssl_ncp.c
> index 2f1df1c52..2561daab2 100644
> --- a/src/openvpn/ssl_ncp.c
> +++ b/src/openvpn/ssl_ncp.c
> @@ -134,7 +134,7 @@ mutate_ncp_cipher_list(const char *list, struct gc_ar=
ena *gc)
>          {
>              const char* optstr =3D optional ? "optional ": "";
>              msg(M_WARN, "Unsupported %scipher in --data-ciphers: %s", op=
tstr, token);
> -            error_found =3D !optional;
> +            error_found =3D error_found || !optional;
>          }

This looks good now, but the rest of the patch got merge-conflicted
to death, I'm afraid.  The actual "optional" part got lost (token++)...

>          else
>          {
> @@ -448,6 +448,10 @@ p2p_ncp_set_options(struct tls_multi *multi, struct =
tls_session *session)
>=20=20
>          }
>      }
> +    if (iv_proto_peer & IV_PROTO_RENOG_DYN_TLSCRYPT)
> +    {
> +        session->opt->crypto_flags |=3D CO_USE_DYN_TLSCRYPT_RENOG;
> +    }
>  #endif
>  }

... and this is unrelated...

> @@ -491,4 +495,4 @@ p2p_mode_ncp(struct tls_multi *multi, struct tls_sess=
ion *session)
>          multi->use_peer_id, multi->peer_id, common_cipher);
>=20=20
>      gc_free(&gc);
> -}
> \ No newline at end of file
> +}

As is this.

> diff --git a/tests/unit_tests/openvpn/test_ncp.c b/tests/unit_tests/openv=
pn/test_ncp.c
> index faf09a36c..6702133ad 100644
> --- a/tests/unit_tests/openvpn/test_ncp.c
> +++ b/tests/unit_tests/openvpn/test_ncp.c
> @@ -95,6 +95,9 @@ test_check_ncp_ciphers_list(void **state)
>      /* All unsupported should still yield an empty list */
>      assert_ptr_equal(mutate_ncp_cipher_list("?kugelfisch:?grasshopper", =
&gc), NULL);
>=20=20
> +    /* If the last is optional, previous invalid ciphers should be ignor=
ed */
> +    assert_ptr_equal(mutate_ncp_cipher_list("Vollbit:Littlebit:AES-256-C=
BC:BF-CBC:?nixbit", &gc), NULL);
> +
>      /* For testing that with OpenSSL 1.1.0+ that also accepts ciphers in
>       * a different spelling the normalised cipher output is the same */
>      bool have_chacha_mixed_case =3D cipher_kt_get("ChaCha20-Poly1305");

This one also seems to be "an extra change on top of 1/9 v1" (grasshopper),
not "1/9 v2".

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--r390sa7DqEY80bru
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJhrbZhAAoJEB2Cnv7KVigS7hQMAJmnj1tCYxXgh4IG+S5xy8VO
Jn7Ffy4MksUzrpeGIghlslMUWW1cglqMaflm96Cw1hab63CjGQ2RdTSpiHzxN5it
+RlybC3HY3sRxEm3Zfu1EidcICB/l3xMgNx726Zg36M+o+12kpEJeIN1lshR4nxA
2gcjkvPUvWwVh+IcoHqf870PTwDxqSvgRjLbTT/cqfb5kBqJgb07CBmomtUN+oYc
JohFEP8wNFG+OV7r6o+xqT2G4IciY+GFl/oewbLhmzpGnWfTmvxz+7+F488LTPla
c+xBaGCIhvgfdnVWPmSNxdwob9PNZbznQT0MymGJYg7VhIbbjteDcRkRfOp9VICV
JgcptwYpMEzWezBnpQy2+F20pGQN3GOWMgC0KKan6cJgVXSa7U6Oqt3sHniW4X6U
XjsovrpHHUwHkC4lgiZYnK/vI2NojHexMmCTIWWVId43eWdEMIVhKr9n7q0DrAbf
GrM8M9ZZqmm8ilRItxnBn+K6qU4QxNoA8hCOcdimFg==
=JNbx
-----END PGP SIGNATURE-----

--r390sa7DqEY80bru--

