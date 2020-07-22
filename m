References: <20200717134739.21168-1-arne@...1227...>
 <20200717134739.21168-8-arne@...1227...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <6fe3f761-ea6e-4b52-36b1-24d20a92a97b@...2080...>
Date: Wed, 22 Jul 2020 16:32:00 +0200
MIME-Version: 1.0
In-Reply-To: <20200717134739.21168-8-arne@...1227...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="fYBosd5kHvi4nRg8IZOqki23uImJP0oud"
Subject: Re: [Openvpn-devel] [PATCH 8/9] Rename ncp-ciphers to data-ciphers
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fYBosd5kHvi4nRg8IZOqki23uImJP0oud
Content-Type: multipart/mixed; boundary="sOF82zxxb4mxTUBulpNeR3UFXQrhRKuZv";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net
Message-ID: <6fe3f761-ea6e-4b52-36b1-24d20a92a97b@...2080...>
Subject: Re: [Openvpn-devel] [PATCH 8/9] Rename ncp-ciphers to data-ciphers
References: <20200717134739.21168-1-arne@...1227...>
 <20200717134739.21168-8-arne@...1227...>
In-Reply-To: <20200717134739.21168-8-arne@...1227...>

--sOF82zxxb4mxTUBulpNeR3UFXQrhRKuZv
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 17/07/2020 15:47, Arne Schwabe wrote:
> The change in name signals that data-ciphers is the preferred way to
> configure data channel (and not --cipher). The data prefix is chosen
> to avoid ambiguity and make it distinct from tls-cipher for the TLS
> ciphers.
>=20
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>  Changes.rst                            | 13 ++++++++++---
>  doc/man-sections/protocol-options.rst  | 11 +++++++----
>  doc/man-sections/server-options.rst    |  4 ++--
>  sample/sample-config-files/client.conf |  2 +-
>  src/openvpn/multi.c                    |  4 ++--
>  src/openvpn/options.c                  |  5 +++--
>  src/openvpn/ssl_ncp.c                  |  4 ++--
>  7 files changed, 27 insertions(+), 16 deletions(-)
>=20
[...snip...]
> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
> index 31e33ae3..896abcde 100644
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
> @@ -536,7 +536,7 @@ static const char usage_message[] =3D
>      "--cipher alg    : Encrypt packets with cipher algorithm alg\n"
>      "                  (default=3D%s).\n"
>      "                  Set alg=3Dnone to disable encryption.\n"
> -    "--ncp-ciphers list : List of ciphers that are allowed to be negotia=
ted.\n"
> +    "--data-ciphers list : List of ciphers that are allowed to be negoti=
ated.\n"
>      "--ncp-disable   : (DEPRECATED) Disable cipher negotiation.\n"
>      "--prng alg [nsl] : For PRNG, use digest algorithm alg, and\n"
>      "                   nonce_secret_len=3Dnsl.  Set alg=3Dnone to disab=
le PRNG.\n"
> @@ -7866,7 +7866,8 @@ add_option(struct options *options,
>          VERIFY_PERMISSION(OPT_P_NCP|OPT_P_INSTANCE);
>          options->ciphername =3D p[1];
>      }
> -    else if (streq(p[0], "ncp-ciphers") && p[1] && !p[2])
> +    else if ((streq(p[0], "data-ciphers") || streq(p[0], "ncp-ciphers"))
> +            && p[1] && !p[2])

I do agree to using --data-ciphers instead of --ncp-ciphers, that is far mo=
re
user-friendly naming of this feature.  NCP is a more technical
"under-the-hood" terminology which users don't really need to relate to, wh=
ere
--data-ciphers better explains what it is used for.

But I do reject NOT adding a deprecation path for --ncp-ciphers.  We should
support --ncp-ciphers for 1-2 major releases, but after that it should be
removed.  We have too many options and we certainly should avoid duplicating
options with the exact same functionality.


--=20
kind regards,

David Sommerseth
OpenVPN Inc



--sOF82zxxb4mxTUBulpNeR3UFXQrhRKuZv--

--fYBosd5kHvi4nRg8IZOqki23uImJP0oud
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJfGE3hAAoJEIbPlEyWcf3y1zcQAMfI5v44bIRAqL8PQTEmVy2j
7Mn1Nd+hwUvCZiSz+UeKAhnfo9rJ+Sf2kjJlbO6A/tviUR1BcjPv6y1lcJUDnj5+
cR3P00Y4045bfj6F9cReJwX7tUVqqzUZh8pbs6duqsMUpeQc95ec2dtBkn23/MCe
zPvfSjk6R8xjGWGVQik0+iEhV3BrLxomaAdWY8/jIgpUFDK5fX/9tdg7mkwSgCyM
nKQpUiW1Jq/biwOmFnGSc7IJ6E7mv5Nn067AMDeF5P2QoNzlAWigPUHqF4VeWPL3
9io3HAWOqz+tp7n+mf7toggHfKGn7h7iCnac3s6a1S67gVpLuv+sjNams4adWIYI
O67RdiZighzthyd0jSXrZy+mPPGqobdT/iR2m+8SlgZtZhol67L0iAIAWdoZQgGr
jMUwpuoGkaAF44gABuFqkSqt2OtecdZsOKpmEfELs4Dd90FSPnVesxA4CEKHzPU9
RnHNY/ZWw8opfZY9ZTRaqPU2lcPIxilSgG68OkLywlbMoJswRuUka+Fky01BB7Cg
dW5QqeBz+TsB4Mb7cXnNXwjdSDqCdLGYgbikxYsDhYqKksbNmCsKaPyuWrVJZd8H
TpkBHHWRXMT6ZIN+QMSRfb2Gkm1NWvm/Wu0AWyxh+Syor8lMl6Y65E4zbgmedT8m
hhyQ28CT2IIKYbFutD/Y
=5xd4
-----END PGP SIGNATURE-----

--fYBosd5kHvi4nRg8IZOqki23uImJP0oud--

