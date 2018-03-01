Date: Thu, 1 Mar 2018 18:51:48 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20180301175147.GB69387@...1296...>
References: <1480022363-24222-1-git-send-email-selva.nair@...277...>
 <1480051264-30193-1-git-send-email-selva.nair@...277...>
 <CAKuzo_hThVb9Gozz_T0sn0iZoyfNNzR5JnLEtxSrP8x2xTDy0A@...278...>
 <CAKuzo_gBWiY==v8bjuaOgq8F2R=gq0a5RNN28VvXphj1p2e2vA@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="m4dDEz192B/qme3Z"
Content-Disposition: inline
In-Reply-To: <CAKuzo_gBWiY==v8bjuaOgq8F2R=gq0a5RNN28VvXphj1p2e2vA@...278...>
Subject: Re: [Openvpn-devel] Fwd: [PATCH] Delete the IPv6 route to the
 "connected" network on tun close
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--m4dDEz192B/qme3Z
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Mar 01, 2018 at 11:09:32AM -0500, Selva Nair wrote:
> This one is too old to cleanly apply, but still sending again
> just to get it into patchwork.

Oh, completely fell of my radar.  But now that you mention it, yes,=20
there was something about clearing bits :-)

> (For some reason bouncing to patchwork somehow never works for me, else
> this could have beaten the oldest pending patch record :)

Bouncing my own usually works, bouncing others "sometimes".  Might be
related to SPF records and/or DKIM/DMARC checks...

[..]
> This was missing on Windows when interactive service is in use.
>=20
> - Added route_ipv6_clear_host_bits(r6) to delete_route_ipv6: this is
>   required for Windows IP-helper API. Won't hurt other platforms (?)
>=20
> Signed-off-by: Selva Nair <selva.nair@...277...>
> ---
>  src/openvpn/route.c | 2 ++
>  src/openvpn/tun.c   | 3 +++
>  2 files changed, 5 insertions(+)
>=20
> diff --git a/src/openvpn/route.c b/src/openvpn/route.c
> index fec12c1..85f969e 100644
> --- a/src/openvpn/route.c
> +++ b/src/openvpn/route.c
> @@ -2124,6 +2124,8 @@ delete_route_ipv6 (const struct route_ipv6 *r6,
> const struct tuntap *tt, unsigne
>=20
>    gc_init (&gc);
>=20
> +  route_ipv6_clear_host_bits (r6);
> +

This is no longer needed, as the clearing is done in

  delete_route_connected_v6_net()

now (2cea72005cb5a825c).

> diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
> index 560b1a8..40ce202 100644
> --- a/src/openvpn/tun.c
> +++ b/src/openvpn/tun.c
> @@ -5663,6 +5663,9 @@ close_tun (struct tuntap *tt)
>          {
>            if (tt->options.msg_channel)
>              {
> +              /* remove route pointing to interface */
> +              delete_route_connected_v6_net(tt, NULL);
> +
>                do_address_service (false, AF_INET6, tt);
>               if (tt->options.dns6_len > 0)
>                   do_dns6_service (false, tt);

So this part remains, but to avoid code duplication I'd move the
"delete_route_connected_v6_net()" call from the else() branch up=20
and before the if (tt->options.msg_channel) clause.

(I'm not adamant on it, though - leaving it there is "all we do is=20
in one place").

Looking at the context, this patch is amazingly old... "before the
code reorganization", so it somehow missed 2.4.0...

thanks for bringing it back :-)

gert

--=20
now what should I write here...

Gert Doering - Munich, Germany                             gert@...1296...

--m4dDEz192B/qme3Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJamD2zAAoJEB2Cnv7KVigSI4AL/RvsRDEawzya5hODu6QXdtFm
InobXKOkO58DnPnUlYFfVwsrR23ieg/9e+vE4U+VSTyAOloXaaBDHFiJxDTUZc8/
JNOcP+u4tfQJ/zXJcC0UwMZf4JOvlSXOVa5jy9kTzb81yTWDh/B6NP6WcSsgDm8W
VeCEQiLPvQn4hzPVv0BrUofPlSKwx6UvfNxOoBS/Nwj7FDdxo0PQ30p0IbsfMt+F
6YgSTucYgbhqUePLDe+UneTMJSsGS18KcD/lA6I9fO6zhhmyC7zjL6/aB01Tke6/
D3io8hOeLqlp77+Mn8Xzu5Wtk+MpeSP2zIm1F9RzegQnmQf1hQLJfp3y4zhSDmmr
s25FVtlitQjTQ0o+UEIOCXekPRAB0c0mA85zeYeWYRGqkupkbqU+xwt4wpNe9pVz
N53dqU9MgRz+pAfj475hmp/R8R38PqPEM7t7f9rY7PW1T0loNqRu+5D6F+pJl0gG
xyw9R9hnmL8gk5f+Xqz8Sjimds2UM0yTIM2ykKyBNQ==
=v5/D
-----END PGP SIGNATURE-----

--m4dDEz192B/qme3Z--

