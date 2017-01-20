References: <1482079255-15159-1-git-send-email-steffan@...1856...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <aaf4595a-1a8c-67f0-690c-9f6743066b0d@...2080...>
Date: Fri, 20 Jan 2017 23:01:42 +0100
MIME-Version: 1.0
In-Reply-To: <1482079255-15159-1-git-send-email-steffan@...1856...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="HTncJc9gO5hMvaRoXgHrPWXUd1Kk1Nc8B"
Subject: Re: [Openvpn-devel] [PATCH] Use SHA256 for the internal digest,
 instead of MD5
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HTncJc9gO5hMvaRoXgHrPWXUd1Kk1Nc8B
Content-Type: multipart/mixed; boundary="QJAbfdjrGseX66oo85ptgKPxISR3GrkQI";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Steffan Karger <steffan@...1856...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>
Message-ID: <aaf4595a-1a8c-67f0-690c-9f6743066b0d@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] Use SHA256 for the internal digest,
	instead of MD5
References: <1482079255-15159-1-git-send-email-steffan@...1856...>
In-Reply-To: <1482079255-15159-1-git-send-email-steffan@...1856...>

--QJAbfdjrGseX66oo85ptgKPxISR3GrkQI
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 18/12/16 17:40, Steffan Karger wrote:
> Our internal options digest uses MD5 hashes to store the state, instead of
> storing the full options string.  There's nothing wrong with that, but it
> would still be better to use SHA256 because:
>  * That makes it easier to make OpenVPN "FIPS-compliant" (forbids MD5)
>  * We don't have to explain anymore that MD5 is fine too
>=20
> The slightly less bytes for the digest (16 instead of 32) and operations
> per connection setup are not worth sticking to MD5.
>=20
> Signed-off-by: Steffan Karger <steffan@...1856...>
> ---
>=20
> This patch is meant for the master branch only.

I started looking at this patch .... and I think it needs some rework,
as it does a couple of unexpected things ...

[...snip...]
> diff --git a/src/openvpn/push.c b/src/openvpn/push.c
> index b6e12e1..a1733b0 100644
> --- a/src/openvpn/push.c
> +++ b/src/openvpn/push.c
> @@ -677,23 +677,17 @@ process_incoming_push_request(struct context *c)
>  #endif /* if P2MP_SERVER */
>=20=20
>  static void
> -push_update_digest(md_ctx_t *ctx, struct buffer *buf, const struct optio=
ns *opt)
> +push_update_digest(md_ctx_t *ctx, struct buffer *buf)
>  {
>      char line[OPTION_PARM_SIZE];
>      while (buf_parse(buf, ',', line, sizeof(line)))
>      {
>          /* peer-id might change on restart and this should not trigger r=
eopening tun */
> -        if (strprefix(line, "peer-id "))
> +        if (strstr(line, "peer-id ") !=3D line)
>          {
> -            continue;
> -        }
> -        /* tun reopen only needed if cipher change can change tun MTU */
> -        if (strprefix(line, "cipher ") && !opt->ce.tun_mtu_defined)
> -        {
> -            continue;
> +            md_ctx_update(ctx, (const uint8_t *) line, strlen(line));
>          }
>      }
> -    md_ctx_update(ctx, (const uint8_t *) line, strlen(line)+1);
>  }

This actually tries to revert commit ec4dff3bbdcc9fedf7844 ... which is
quite surprising.

[...snip...]
> @@ -736,15 +730,14 @@ process_incoming_push_msg(struct context *c,
>                                     option_types_found,
>                                     c->c2.es))
>              {
> -                push_update_digest(&c->c2.pulled_options_state, &buf_ori=
g,
> -                                   &c->options);
> +                push_update_digest(&c->c2.pulled_options_state, &buf_ori=
g);

And this too is also a revert of the same commit as above.

Had it been just a simple rebase, I'd be willing to tackle that
on-the-fly.  But as it tries to do some really unexpected reverts, there
might be a few other issues I'm not able to spot instantly.


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--QJAbfdjrGseX66oo85ptgKPxISR3GrkQI--

--HTncJc9gO5hMvaRoXgHrPWXUd1Kk1Nc8B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYgojGAAoJEIbPlEyWcf3yJ6IQAKU8GGNGzlOuDrS86Q7Hiwhj
1Qm24iGxCKO0//yctx8BcNDrBchoKqbK+xFaq6Epk0h0xdk7SwbXZ6f+8d8lEKgD
tAGpCI2iC/jomh0eEEs5iHO+BjRzlelCNFE9lI0b9e1s4J8N5XsNfBt21az2tuB8
P7blDKLG6ulEf2lLyQaRwRODyZR2pqu6aaQ4rmMRl6X7SSxM0tslazwwNNtz+aho
HLlpo/nxcvP7XqgEA8RBLB5xQ4iLv8cckL097UsR2ahB3NsPextBNXiaObO8KNjL
VyHa40pnw8cHjtXllWeQkjvpRfuKXuyArLw6QfV0RpNU/lNVE3HULfTrrX9SmIvT
M3Gv2bAtlxIzMXii1+SbYkyMMvrFegMeExFnjYY2o8maMZdVcHG8eq2vy+PoVdci
PhsRvuSt4GtUYVQE41NV9f0FdJ4EfWu4Tv1KdU6ekeKQmODGVpkSuKtcdXKdT2zD
VJ0L0jlLlknE4NqSF2RJhXoWBeiVTUu5UBVcdkyKSofPVEogvZEbiKqx9KP4n60e
yI/8lSOOhsC+psxHCBEnpw4AVCeTyuF62h293VhXe35f9PSsWFNyyTmPVg0yVcFW
Hc8eiFJkb6RuECGoF0UiJHqNmWik/vU27lH324NWDspV3JOU9JJOjmmWRI1SMH4C
0j2MY390YG9L1oMO5SEN
=BsR8
-----END PGP SIGNATURE-----

--HTncJc9gO5hMvaRoXgHrPWXUd1Kk1Nc8B--

