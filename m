Date: Sun, 5 Dec 2021 18:11:14 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <YazysuRMayAaxCwo@...1296...>
References: <20211201180727.2496903-1-arne@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="7m2G/r8yc1o56YyC"
Content-Disposition: inline
In-Reply-To: <20211201180727.2496903-1-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH 1/9] Implement optional cipher in
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

--7m2G/r8yc1o56YyC
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Dec 01, 2021 at 07:07:19PM +0100, Arne Schwabe wrote:
> This allows to use the same configuration multiple platforms/ssl libraries
> and include optional algorithms that are not available on all platforms
>=20
> For example "AES-256-GCM:AES-128-GCM:?CHACHA20-POLY1305" can be used to
> emulate the default behaviour of OpenVPN 2.6.

NAK on this, for two small and one big reason...

> diff --git a/Changes.rst b/Changes.rst
> index 7cceffcdb..c1a04deed 100644
> --- a/Changes.rst
> +++ b/Changes.rst
> @@ -58,6 +58,10 @@ OpenSSL 3.0 support
>      (and other deprecated) algorithm by default and the new option ``--p=
roviders``
>      allows loading the legacy provider to renable these algorithms.
>=20=20
> +Optional ciphers in ``--data-ciphers``
> +    Ciphers in ``--data-ciphers`` can now be prefixes with a ``?`` to ma=
rk
> +    those as optional and only use them if the SSL library supports them.

Typo, "prefixed"

> +
>  Deprecated features
>  -------------------
>  ``inetd`` has been removed
> diff --git a/doc/man-sections/protocol-options.rst b/doc/man-sections/pro=
tocol-options.rst
> index c7aa6b0e3..7095b6f4d 100644
> diff --git a/src/openvpn/ssl_ncp.c b/src/openvpn/ssl_ncp.c
> index 022a9dc3b..b0b248aae 100644
> --- a/src/openvpn/ssl_ncp.c
> +++ b/src/openvpn/ssl_ncp.c
> @@ -109,7 +109,18 @@ mutate_ncp_cipher_list(const char *list, struct gc_a=
rena *gc)
>           * (and translate_cipher_name_from_openvpn/
>           * translate_cipher_name_to_openvpn) also normalises the cipher =
name,
>           * e.g. replacing AeS-128-gCm with AES-128-GCM
> +         *
> +         * ciphers that have ? in front of them are considered optional =
and
> +         * OpenVPN will only warn if they are not found (and remove them=
 from
> +         * the list)
>           */
> +
> +        bool optional =3D false;
> +        if (token[0] =3D=3D '?')
> +        {
> +            token=3D token + 1;

The whitespace dragon says this should be "token++;"

(These are small, and I could fix that on the fly).


The problem is here:

> @@ -121,8 +132,9 @@ mutate_ncp_cipher_list(const char *list, struct gc_ar=
ena *gc)
>          }
>          if (!ktc && strcmp(token, "none") !=3D 0)
>          {
> -            msg(M_WARN, "Unsupported cipher in --data-ciphers: %s", toke=
n);
> -            error_found =3D true;
> +            const char* optstr =3D optional ? "optional ": "";
> +            msg(M_WARN, "Unsupported %scipher in --data-ciphers: %s", op=
tstr, token);
> +            error_found =3D !optional;
>          }

This only works if the last cipher in the list is "borken or optional".

If you do

  openvpn --data-ciphers Vollbit:Littlebit:AES-256-CBC:BF-CBC:?nixbit

it will log

2021-12-05 18:09:27 Unsupported cipher in --data-ciphers: Vollbit
2021-12-05 18:09:27 Unsupported cipher in --data-ciphers: Littlebit
2021-12-05 18:09:27 Unsupported optional cipher in --data-ciphers: nixbit

... and go ahead...

Dec  5 18:09:28 gentoo tap-tcp-p2p[26765]: peer info: IV_CIPHERS=3DAES-256-=
CBC:BF-CBC

without flagging "Vollbit" and "Littlebit" as hard errors.

If the "nixbit" cipher is removed

  openvpn --data-ciphers Vollbit:Littlebit:AES-256-CBC:BF-CBC

will lead to

2021-12-05 18:10:29 Unsupported cipher in --data-ciphers: Vollbit
2021-12-05 18:10:29 Unsupported cipher in --data-ciphers: Littlebit
Options error: --data-ciphers list contains unsupported ciphers or is too l=
ong.


Sorry for excercising my special ability of breaking everything :-)

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--7m2G/r8yc1o56YyC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJhrPKyAAoJEB2Cnv7KVigSvCoL/3PLXR9+vlzLS78M+HJiA+4c
AnNUzaj/DvkOoMTAlHukPF5H5M0kkQfkg2bLY4o1SAg71v5446dCqZhSgJwfl3av
a6pj/iNRrnpHWyTBwLHJHwSjlGjEkOXit3UMDjDvuWZ3gz26r+1Ce+5rCaWjeyMA
Ym1gLj/Pz5K7RRO4T8ICmwY5cjxYnnOryB7+7ksJhkLe6vX+8PFeJt4lep7Q+s9J
1faVzs2tAi+VV9YAZ/mTHk5sg2TmHFuMGwU4D6lPFuGWA0InBIRcuDI5eISS2CZR
1MB9c06nyN8MpSDQ7tLMDUxstSJ80oYmgFfj78WklzBpBrQDQwXv1A06Egf26QSc
eEl7Pcxnuf0GXXR3zwKdWMmL9zxWTutFPNgMVF80u8zWwp9/QyRY9eW3G3bbphxS
QOl/06kLbBB3IikV7mey7sNvUwWG8Bpl/YnJW0t0XPcFCVUuUQI0P1OVO7SByGrd
f/S/Ppd0ER/9/LcpQdabAXXq7zqehiv069J5lU9hzw==
=ahIl
-----END PGP SIGNATURE-----

--7m2G/r8yc1o56YyC--

