References: <20181121101019.1801-1-arne@...1227...>
 <20181121101019.1801-4-arne@...1227...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <9bacefd8-e8cf-b15d-0a29-b03b37c27186@...2181...>
Date: Tue, 3 Dec 2019 15:29:20 +0100
MIME-Version: 1.0
In-Reply-To: <20181121101019.1801-4-arne@...1227...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="e3YTgJ7W5DWjWzbC05BIZeibCV3Qa4Beb"
Subject: Re: [Openvpn-devel] [PATCH v4 03/13] client-connect: Move
 multi_client_connect_setenv into early_setup
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
--e3YTgJ7W5DWjWzbC05BIZeibCV3Qa4Beb
Content-Type: multipart/mixed; boundary="JzOhzXY2TUMkbwEGXXrabYj9Ae9qTjdvV"

--JzOhzXY2TUMkbwEGXXrabYj9Ae9qTjdvV
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On 21/11/2018 11:10, Arne Schwabe wrote:
> From: Fabian Knittel <fabian.knittel@...1547...>
>=20
> This patch moves multi_client_connect_setenv into
> multi_client_connect_early_setup and makes sure that every client-connect
> handling function updates the virtual address selection.
>=20

Can you elaborate a bit more please? IT sounds like this patch is fixing
some inconsistent behaviour, but I Don't grasp what exactly.

Can you please spend a few more words to describe what would not work
now and how this patch is fixing it?

> Background: This unifies how the client-connect handling functions work.
>=20
> Signed-off-by: Fabian Knittel <fabian.knittel@...1547...>
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>  src/openvpn/multi.c | 23 ++++++++++++++---------
>  1 file changed, 14 insertions(+), 9 deletions(-)
>=20
> diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
> index 8fc69a07..bc9fddce 100644
> --- a/src/openvpn/multi.c
> +++ b/src/openvpn/multi.c
> @@ -2041,6 +2041,12 @@ multi_client_connect_early_setup(struct multi_cont=
ext *m,
>=20=20
>      /* reset pool handle to null */
>      mi->vaddr_handle =3D -1;
> +
> +    /* do --client-connect setenvs */
> +    multi_select_virtual_addr(m, mi);
> +
> +    multi_client_connect_setenv(m, mi);
> +
>  }
>=20=20
>  /**
> @@ -2086,6 +2092,13 @@ multi_client_connect_source_ccd(struct multi_conte=
xt *m,
>                                    CLIENT_CONNECT_OPT_MASK,
>                                    option_types_found,
>                                    mi->context.c2.es);
> +            /*
> +             * Select a virtual address from either --ifconfig-push in
> +             * --client-config-dir file or --ifconfig-pool.
> +             */
> +            multi_select_virtual_addr(m, mi);
> +
> +            multi_client_connect_setenv(m, mi);
>          }
>          gc_free(&gc);
>      }
> @@ -2115,19 +2128,11 @@ multi_connection_established(struct multi_context=
 *m, struct multi_instance *mi)
>=20=20
>          multi_client_connect_source_ccd(m, mi, &option_types_found);
>=20=20
> -        /*
> -         * Select a virtual address from either --ifconfig-push in
> -         * --client-config-dir file or --ifconfig-pool.
> -         */
> -        multi_select_virtual_addr(m, mi);
> -
> -        /* do --client-connect setenvs */
> -        multi_client_connect_setenv(m, mi);
> -
>          multi_client_connect_call_plugin_v1(m, mi, &option_types_found,
>                                              &cc_succeeded,
>                                              &cc_succeeded_count);
>=20=20
> +

random whiteline ?

>          multi_client_connect_call_plugin_v2(m, mi, &option_types_found,
>                                              &cc_succeeded,
>                                              &cc_succeeded_count);
>=20

--=20
Antonio Quartulli


--JzOhzXY2TUMkbwEGXXrabYj9Ae9qTjdvV--

--e3YTgJ7W5DWjWzbC05BIZeibCV3Qa4Beb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEOj/Eejms5Fxtp0v4pNfqZUlHtXIFAl3mcUAACgkQpNfqZUlH
tXKP5g/+JvDprewOBSLxHi/kPjL+JosQGhaHlrll/tXwIT4rG8wpM6qIjK80RhUT
u/3hnpDa1fmGrKlh2GGkh7yc/dn9xdf6TVTkv4LNBxn3SKkRXRFLKctTfpjxOv6c
mNYDUOfQPoLX6QpOUBHeLSKjFJxqfcJ8bnw3fyGbbowJPiyH/IfsYEND2vvMDqMd
jlcKjxru0VauItJVVMUDvuvIddJN7vsEmFAIky8UV5M9EZ46/TCY9EST4jdzD1eQ
MmM+gs6rZeOdOAKGJHKuvFSP7YuDbI9ly+X4bbVy9Ojn3rp+Uz9is/+xqG/blvcV
/uK3CmbQ+jfO36bKYtv/PWxTwIQTyuVNAAgT5xlhj2bWtZ7v77oHW6r9OLsrZCB2
vvjJedfoVGMpmSdyzyId62CFhWdlF9fB9ZnmWBoucv6UFGCzaMgXzSTw50zNS0hn
xP5Ixa4ESHqc1NukBHJjqpn2ATUzW0fgYy0iJJv0pMUhNbZs0+kDcScJbV84CQ9W
+DIsUTH2IZs46tGmVik2F7jJldnSmTGoMwh+/7lmaq94beCf9sEcCi3g+W2vBYn/
XwfiuPPgaC0TXOVtAXzG9oMbAPAiMIqfAQEkGFAV2TeEaPq1sZlvvkyoZnfkk8/1
q9bUhYZrwhWMQQbAdbtHNkyMvz0vkf1rbPB+59serUfcW449TmQ=
=r4TF
-----END PGP SIGNATURE-----

--e3YTgJ7W5DWjWzbC05BIZeibCV3Qa4Beb--

