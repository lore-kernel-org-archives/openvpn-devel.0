Date: Mon, 10 Jan 2022 10:37:07 +0100 (CET)
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <422890884.1201150.1641807427760@...2642...>
In-Reply-To: <20211229102924.8901-1-gert@...1296...>
References: <20211229102924.8901-1-gert@...1296...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH] Removed error message for an option
 flag not supported with --server-ipv6
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net
Cc: =?UTF-8?Q?Camille_Gu=C3=A9rin?= <guerincamille56@...277...>

Looks good to me.

Acked-by: Frank Lichtenheld <frank@...2641...>

> Gert Doering <gert@...1296...> hat am 29.12.2021 11:29 geschrieben:
>=20
>=20=20
> From: Camille Gu=C3=A9rin <guerincamille56@...277...>
>=20
> Signed-off-by: Camille Guerin <guerincamille56@...277...>
>=20
> Closes: OpenVPN/openvpn#164
> ---
>  src/openvpn/options.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
>=20
> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
> index ac13412a..f59d89cb 100644
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
> @@ -6870,7 +6870,7 @@ add_option(struct options *options,
>              }
>          }
>      }
> -    else if (streq(p[0], "server-ipv6") && p[1] && !p[3])
> +    else if (streq(p[0], "server-ipv6") && p[1] && !p[2])
>      {
>          const int lev =3D M_WARN;
>          struct in6_addr network;
> @@ -6893,12 +6893,6 @@ add_option(struct options *options,
>          options->server_ipv6_defined =3D true;
>          options->server_network_ipv6 =3D network;
>          options->server_netbits_ipv6 =3D netbits;
> -
> -        if (p[2])       /* no "nopool" options or similar for IPv6 */
> -        {
> -            msg(msglevel, "error parsing --server-ipv6: %s is not a reco=
gnized flag", p[3]);
> -            goto err;
> -        }
>      }
>      else if (streq(p[0], "server-bridge") && p[1] && p[2] && p[3] && p[4=
] && !p[5])
>      {
> --=20
> 2.26.3
>=20
>=20
>=20
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--
Frank Lichtenheld

