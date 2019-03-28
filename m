References: <20190328122701.7396-1-cschenk@...2502...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <1363f761-21e4-f5e6-8c49-234e1339bc3d@...1227...>
Date: Thu, 28 Mar 2019 14:12:30 +0100
MIME-Version: 1.0
In-Reply-To: <20190328122701.7396-1-cschenk@...2502...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Rv0C3YGwSvzDf3VQDIbYQUNPlGuYim5NP"
Subject: Re: [Openvpn-devel] [PATCH] Setting adapter mtu on windows systems
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Christopher Schenk <cschenk@...2502...>, openvpn-devel@lists.sourceforge.net
Cc: Christopher Schenk <Christopher.Schenk@...160...>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Rv0C3YGwSvzDf3VQDIbYQUNPlGuYim5NP
Content-Type: multipart/mixed; boundary="xJB4wII1bnhrYSTYPFBqJzotC8U2O80zo";
 protected-headers="v1"
From: Arne Schwabe <arne@...1227...>
To: Christopher Schenk <cschenk@...2502...>,
 openvpn-devel@lists.sourceforge.net
Cc: Christopher Schenk <Christopher.Schenk@...160...>
Message-ID: <1363f761-21e4-f5e6-8c49-234e1339bc3d@...1227...>
Subject: Re: [Openvpn-devel] [PATCH] Setting adapter mtu on windows systems
References: <20190328122701.7396-1-cschenk@...2502...>
In-Reply-To: <20190328122701.7396-1-cschenk@...2502...>

--xJB4wII1bnhrYSTYPFBqJzotC8U2O80zo
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 28.03.19 um 13:27 schrieb Christopher Schenk:
> From: Christopher Schenk <Christopher.Schenk@...160...>
>=20
> ---
>  src/openvpn/tun.c | 39 ++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 38 insertions(+), 1 deletion(-)
>=20
> diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
> index 48a8fdf7..93d028c8 100644
> --- a/src/openvpn/tun.c
> +++ b/src/openvpn/tun.c
> @@ -69,6 +69,12 @@ static void netsh_ifconfig(const struct tuntap_options=
 *to,
>                             const in_addr_t netmask,
>                             const unsigned int flags);
>=20=20
> +static void netsh_set_mtu_ipv4(const char *flex_name,
> +                               const int mtu);
> +
> +static void netsh_set_mtu_ipv6(const char *flex_name,
> +                               const int mtu);
> +
>  static void netsh_set_dns6_servers(const struct in6_addr *addr_list,
>                                     const int addr_len,
>                                     const char *flex_name);
> @@ -1000,6 +1006,7 @@ do_ifconfig_ipv6(struct tuntap *tt, const char *ifn=
ame, int tun_mtu,
>          netsh_command(&argv, 4, M_FATAL);
>          /* set ipv6 dns servers if any are specified */
>          netsh_set_dns6_servers(tt->options.dns6, tt->options.dns6_len, i=
fname);
> +        netsh_set_mtu_ipv6(ifname, tun_mtu);
>      }
>=20=20
>      /* explicit route needed */
> @@ -1391,9 +1398,9 @@ do_ifconfig_ipv4(struct tuntap *tt, const char *ifn=
ame, int tun_mtu,
>              case IPW32_SET_NETSH:
>                  netsh_ifconfig(&tt->options, ifname, tt->local,
>                                 tt->adapter_netmask, NI_IP_NETMASK|NI_OPT=
IONS);
> -
>                  break;
>          }
> +		netsh_set_mtu_ipv4(ifname, tun_mtu);
>      }
>=20=20
>  #else  /* if defined(TARGET_LINUX) */
> @@ -5236,6 +5243,36 @@ out:
>      return ret;
>  }
>=20=20
> +static void
> +netsh_set_mtu_ipv4(const char *flex_name,
> +                   const int mtu)
> +{
> +	struct argv argv =3D argv_new();
> +	argv_printf(&argv, "%s%sc interface ipv4 set subinterface %s mtu =3D %d=
 store=3Dactive",

The spacing here looks a bit odd. I would have expected mtu=3D%d instead.
Is this necessary or was there a reason for doing this?

Patch looks okay enough to ACK but:

In general, this patch adds a missing feature (setting MTU) with one
windows interface only (netsh). And more commonly used interface
(interactive service)would be different then leading to harder to debug
problems.

Are you planning on adding MTU setting to the interactive service as
well? If we have patches for MTU setting for both, I have problem to ACK
both.

Arne


--xJB4wII1bnhrYSTYPFBqJzotC8U2O80zo--

--Rv0C3YGwSvzDf3VQDIbYQUNPlGuYim5NP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAlycyD4ACgkQFRhsZwKx
RFRiVg//Tvua5J8ZB2QFDv2zh8E8RVYKm+D86befT3kfgwvsCAibAD7HFidxJAy2
EOsIZAaUdqeFkXcmEty+l+XwguSLpHTVLveeTlfDPM4lZPpoS+dfM73EN2Q5q7tE
oWoetNtLceRF6Bx9bgsnyBtlec8RpyTaBfVYt8bP9DpttRxCcLJigogqXXhSWR4z
/EsRIzRxrFjywwAdn8OkepeEUDA4xM+yzQN39FmIzeSLoH5uFg6JySujD1EQ1Ztx
AiQB8Do1NSXuEHHiOeeRkiwNiOBr75f2JUoGZQehz58AILeUN3wg0hVFTPRHuVEL
RQvrxlynIXooIAP21mRgVpU2AAUTqR4jMa52ybXO+RYpSFI4reoNQmIpcDoaOm+k
hJ+vKgxWwwJ27Smc3Pj/vwsjCU5NSnE6sQMPpPOpucKBPQtTqRgaVMMupJ/a29dI
B/mpxP3a8cXzq41z03ngVOCoMPEj/L4CY6qn/4YlePCxoEMfwIcZBMEx1ehwWNEJ
+8XtkjlvVeB6y6gfa9CNzKYGUI3czlYHKJg2iXXGKacd7IUbI+aVEZSIaMmF96+C
zeyG4pKA6kaXePYWCr+hTErgAGWsiThLyIYFkoKUrMNw5CYF4NJ5cpJhSX9+zuO8
VbQ52sRp8yDXnVGXgOkKFznS4uXuh/Rsus2jLZCoaecOm+82SlE=
=RVkc
-----END PGP SIGNATURE-----

--Rv0C3YGwSvzDf3VQDIbYQUNPlGuYim5NP--

