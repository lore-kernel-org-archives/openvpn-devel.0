References: <1481827955-18896-1-git-send-email-steffan@...1856...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <bbc21eb4-67bb-cd2c-b01f-55ad730d7db0@...2080...>
Date: Thu, 15 Dec 2016 20:49:23 +0100
MIME-Version: 1.0
In-Reply-To: <1481827955-18896-1-git-send-email-steffan@...1856...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="t9xvXjvCg6hxPA708Pxe0Vb0wO9mfXKNn"
Subject: Re: [Openvpn-devel] [PATCH] Don't reopen tun if cipher changes
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--t9xvXjvCg6hxPA708Pxe0Vb0wO9mfXKNn
Content-Type: multipart/mixed; boundary="TmXI34WsxliEFgvXfo5scAgmBkh1pJwC6";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net
Message-ID: <bbc21eb4-67bb-cd2c-b01f-55ad730d7db0@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] Don't reopen tun if cipher changes
References: <1481827955-18896-1-git-send-email-steffan@...1856...>
In-Reply-To: <1481827955-18896-1-git-send-email-steffan@...1856...>

--TmXI34WsxliEFgvXfo5scAgmBkh1pJwC6
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 15/12/16 19:52, Steffan Karger wrote:
> When the pulled options change, OpenVPN will attempt to reopen the tun
> device.  That might fail if the process has already dropper privileges,
> and is not needed unless the tun MTU is changed.  This patch therefore
> ignores the cipher value for the digest if a fixed tun-mtu is used.
>=20
> Additionally, this patch changes the md_ctx_update() call to include the
> trailing zero byte of each option, to make sure that parsing "foo,bar"
> results in a different hash than "foobar".  (Sorry for not catching that
> during the review...)
>=20
> Trac: #761
>=20
> Signed-off-by: Steffan Karger <steffan@...1856...>
> ---
>  src/openvpn/push.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
>=20
> diff --git a/src/openvpn/push.c b/src/openvpn/push.c
> index 34c65c4..674efeb 100644
> --- a/src/openvpn/push.c
> +++ b/src/openvpn/push.c
> @@ -677,17 +677,22 @@ process_incoming_push_request(struct context *c)
>  #endif /* if P2MP_SERVER */
>=20=20
>  static void
> -push_update_digest(md_ctx_t *ctx, struct buffer *buf)
> +push_update_digest(md_ctx_t *ctx, struct buffer *buf, const struct optio=
ns *opt)
>  {
>      char line[OPTION_PARM_SIZE];
>      while (buf_parse(buf, ',', line, sizeof(line)))
>      {
>          /* peer-id might change on restart and this should not trigger r=
eopening tun */
> -        if (strstr(line, "peer-id ") !=3D line)
> +        if (strcmp(line, "peer-id ") =3D=3D 0)

Are you sure about this strcmp()?  I'd expect line to contain
"peer-id 1" or something like that ... so the result would be 49 (or
anything not 0) .... strncmp(line, "peer-id ", 8) would provide a match
though.

>          {
> -            md_ctx_update(ctx, (const uint8_t *) line, strlen(line));
> +            continue;
>          }
> -    }
> +        if (strcmp(line, "cipher ") =3D=3D 0 && !opt->ce.tun_mtu_defined)

Same as above.


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--TmXI34WsxliEFgvXfo5scAgmBkh1pJwC6--

--t9xvXjvCg6hxPA708Pxe0Vb0wO9mfXKNn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYUvPDAAoJEIbPlEyWcf3y1bUQAMGnrkY84dXY03T5Ow5pNYC3
ZaE/R0FzQhbpPDc3BvetYa6LBTJ3aRj++zr+he3wxM8WbZBZpzsNkGneAYMA08hA
XddrypWixd2+Fco072FgN/m11TyIhNIrYjz/PpDtN3Ci4TXV3GuNaM9Lw9wVoOWr
6rCe1ez3RJd+RDrgKsHGnYyvDW+qV/2JGyzX+AUXaLUwLiKOL3MYJdg7gWJKmHEn
jfX7nj5/VuhMqR2K2Siopmtg9kc960AGUGS4I3HxfXe1bmsipH3CLsz2ZqVFI0z2
dxlDe6pQt1/clgTnSF4kwEYWqERr31ZsaPrQ7k3hm9dJ9JdYPlL8s8rg0cIGOZ5A
9Dz9fNsbhfumstWJgtTmmnCatjDjHCi0xbCFYCvX453DubHK6oYajfHDBI6WU5er
sH20Xs1fExuShl6hxUGwzgpGApjqB95HEUjg0/3sat/6E6dt7b22GpBdi06N2NRO
cA6JgHwtuDHZkY1ZRgd3CjUHTSaUfAnmO8O4+2JqH2EbiJz7okKwZI6mXDQhaZYI
vAAgnjPdRBWSTGzEkfpgb7o2V0bmOX25wbCulD3vHIA7bAFQhZSvHRlAV6r5P6Ux
YUs18QUpKVjHaJn15W1qVi00xLFfWwYcx2dQPeB793zuXGZ98ZPzPzuDhE8hFsLO
1KfxrOyKyccxG/5wJi/r
=0PA6
-----END PGP SIGNATURE-----

--t9xvXjvCg6hxPA708Pxe0Vb0wO9mfXKNn--

