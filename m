Reply-To: openvpn-devel@lists.sourceforge.net
References: <1528020718-12721-1-git-send-email-steffan@...1856...>
 <1528020718-12721-3-git-send-email-steffan@...1856...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <7c00ba21-c4c5-fb0a-8865-1d6a52e8f2fd@...2080...>
Date: Mon, 4 Jun 2018 19:57:38 +0200
MIME-Version: 1.0
In-Reply-To: <1528020718-12721-3-git-send-email-steffan@...1856...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="OhOYB1L5CJYO5A1do4NtXR6kcOVEq33JR"
Subject: Re: [Openvpn-devel] [PATCH 3/3] Print a --verb 1 warning when a
 connection uses compression
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--OhOYB1L5CJYO5A1do4NtXR6kcOVEq33JR
Content-Type: multipart/mixed; boundary="k4FS2D70FrF7crzvhV17Sd0iwA3m8hDqX";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net
Message-ID: <7c00ba21-c4c5-fb0a-8865-1d6a52e8f2fd@...2080...>
Subject: Re: [Openvpn-devel] [PATCH 3/3] Print a --verb 1 warning when a
 connection uses compression
References: <1528020718-12721-1-git-send-email-steffan@...1856...>
 <1528020718-12721-3-git-send-email-steffan@...1856...>
In-Reply-To: <1528020718-12721-3-git-send-email-steffan@...1856...>

--k4FS2D70FrF7crzvhV17Sd0iwA3m8hDqX
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 03/06/18 12:11, Steffan Karger wrote:
> Can be suppressed by adding a "nowarn" flag to the compress options, for
> those that are really sure that compression is fine for their use case.
>=20
> Signed-off-by: Steffan Karger <steffan@...1856...>
> ---
> This patch is also meant to discuss how far we want to go in warning
> users about using compression.  I think this approach is reasonable,
> but I'm not sure everyone agrees.
>=20
>  doc/openvpn.8      | 11 +++++++++--
>  src/openvpn/comp.c | 14 ++++++++++++++
>  src/openvpn/comp.h |  1 +
>  3 files changed, 24 insertions(+), 2 deletions(-)
>=20
> diff --git a/doc/openvpn.8 b/doc/openvpn.8
> index 9e988b3..21a3c42 100644
> diff --git a/src/openvpn/comp.c b/src/openvpn/comp.c
> index a945913..a34e64a 100644
> --- a/src/openvpn/comp.c
> +++ b/src/openvpn/comp.c
> @@ -40,6 +40,20 @@
>  struct compress_context *
>  comp_init(const struct compress_options *opt)
>  {
> +    switch (opt->alg)
> +    {
> +        case COMP_ALG_UNDEF:
> +        case COMP_ALG_STUB:
> +        case COMP_ALGV2_UNCOMPRESSED:
> +            break;
> +        default:
> +            if (!(opt->flags & COMP_F_NOWARN))
> +            {
> +                msg(M_INFO, "WARNING: Compression enabled, might be insu=
re. "

Did you mean /insecure/?


--=20
kind regards,

David Sommerseth
OpenVPN Inc



--k4FS2D70FrF7crzvhV17Sd0iwA3m8hDqX--

--OhOYB1L5CJYO5A1do4NtXR6kcOVEq33JR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJbFX2TAAoJEIbPlEyWcf3y2hMQAID2fSbzAnQEEZGAet9qh7Yl
uT/tbvDVnhEBFnYbOSQSrAUU8fUxm/C1yV79dZJQr5S47DUqLpj6Rh8vDxzYuoAL
XhRV1/+8BYvfQ+vimMywFvAPJesPLwk0Bp/nU7PNwQH+KOni9ZNRr5NyXv0JTTYm
2udf1cWuRYhRtucncm/kCgfJGh7Vu0gx8wj7Tdb23T/iQN7+tFIu2QQF6D6uIDqS
OgDNdqNdiXLGmVYDn3ipGURJvYQdmslStlLTNwkKNTNsVlnF4qfps6Kln4bLTxbu
n1eXB5mwFee0UVywvu/1E6zZbPMVORfhJ5cR/JJZIcGO9zd0PN5aRGJ7IkyOvcVY
QBEzooztBN4CjmQDfa6G1m2B5IDxrmaBXnQfz/XhFdPGS+aArHelrIRaJY9CuLPi
EBrfCfrnSM7GcyuCLvWkn7kwul+GjTH0A6VDc/z9ZLuy9Tc+bUK/2lTGhwapiyse
5rweNtcrryKL/pQVy9EtbbGM5bAG711DogPMuuPhfNNTbwWoTWu4u4I8ZMyN6O/d
p605B59XoAd3IifkH41A9wPBK80BhJTNr1bT+C0jNQAfA0qS4JH5PvDcWrWpS8tS
BUKI2NVNZjR7Vig4V0/KH9LtBsSQNnNOcLJgJRMpHtx/bDggCX9oRm1rnWXwBEss
hJh55wVCzohSs3M9TjGV
=us3l
-----END PGP SIGNATURE-----

--OhOYB1L5CJYO5A1do4NtXR6kcOVEq33JR--

