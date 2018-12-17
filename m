References: <20181205212453.GR962@...1296...>
 <20181205214037.70783-1-gert@...1296...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <6eb1df8d-9047-8357-a64b-674284d30403@...2181...>
Date: Mon, 17 Dec 2018 16:53:45 +1000
MIME-Version: 1.0
In-Reply-To: <20181205214037.70783-1-gert@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="MTy7aqP73LTrtknGu6XmYaTyZkTbeEfxO"
Subject: Re: [Openvpn-devel] [PATCH v2] Stop complaining about IPv6 routes
 without gateway address.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--MTy7aqP73LTrtknGu6XmYaTyZkTbeEfxO
Content-Type: multipart/mixed; boundary="WpiIbUHn6m6jXa4VatrjEmf4DYDHU1Yd3";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: openvpn-devel@lists.sourceforge.net
Message-ID: <6eb1df8d-9047-8357-a64b-674284d30403@...2181...>
Subject: Re: [Openvpn-devel] [PATCH v2] Stop complaining about IPv6 routes
 without gateway address.
References: <20181205212453.GR962@...1296...>
 <20181205214037.70783-1-gert@...1296...>
In-Reply-To: <20181205214037.70783-1-gert@...1296...>

--WpiIbUHn6m6jXa4VatrjEmf4DYDHU1Yd3
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On 06/12/2018 07:40, Gert Doering wrote:
> The IPv6 routing code inherited assumptions and the message
>=20
>    "OpenVPN ROUTE6: OpenVPN needs a gateway parameter for a --route-ipv6
>     option and no default was specified by either --route-ipv6-gateway or
>     --ifconfig-ipv6 options"
>=20
> from the IPv4 routing code.
>=20
> This was never really correct, as no gateway is needed for "into tun
> device" IPv6 routes, and the "--route-ipv6-gateway" option it refers
> to also never existed.  (Routes on tap interfaces *do* need a gateway
> due to neighbour discovery being involved.  As do routes on Windows,
> but there we fake the gateway in tun mode anyway).
>=20
> While commit d24e1b179b95 introduces support for "--route-ipv6-gateway",
> the message is still falsely triggered for IPv6 routes in tun mode.
>=20
> Change the code to generally accept IPv6 routes with no gateway
> specification (so "--block-ipv6 --redirect-gateway ipv6" can work
> without additional config).  When installing IPv6 routes, check
> if a gateway is needed (tap mode) but missing, and if yes, print
> correct message.
>=20

Thanks for this commit message. It was very clear as of what the patch
is addressing, how and why,

> Trac: #1143
>=20
> Signed-off-by: Gert Doering <gert@...1296...>
> ---
>  src/openvpn/route.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
>=20
> diff --git a/src/openvpn/route.c b/src/openvpn/route.c
> index d97e8dba..ac38bf15 100644
> --- a/src/openvpn/route.c
> +++ b/src/openvpn/route.c
> @@ -448,11 +448,6 @@ init_route_ipv6(struct route_ipv6 *r6,
>      {
>          r6->gateway =3D rl6->remote_endpoint_ipv6;
>      }
> -    else
> -    {
> -        msg(M_WARN, PACKAGE_NAME " ROUTE6: " PACKAGE_NAME " needs a gate=
way parameter for a --route-ipv6 option and no default was specified by eit=
her --route-ipv6-gateway or --ifconfig-ipv6 options");
> -        goto fail;
> -    }
>=20=20
>      /* metric */
>=20=20
> @@ -1917,6 +1912,16 @@ add_route_ipv6(struct route_ipv6 *r6, const struct=
 tuntap *tt, unsigned int flag
>          gateway_needed =3D true;
>      }
>=20=20
> +    if (gateway_needed && IN6_IS_ADDR_UNSPECIFIED(&r6->gateway) )

please remove the space before the last ')'

> +    {
> +        msg(M_WARN, "ROUTE6 WARNING: " PACKAGE_NAME " needs a gateway "
> +            "parameter for a --route-ipv6 option and no default was set =
via "
> +            "--ifconfig-ipv6 or --route-ipv6-gateway option.  Not instal=
ling "
> +            "IPv6 route to %s/%d.", network, r6->netbits );

please remove the space before the last ')'

As quickly discussed during the meeting, it might be better to have the
string all on one line to make it easier to grep. You could go on a new
line after M_WARN, and then right after the long string.

One dis-advantage I have seen while testing this patch is that we now
get one message for each route we try to install.

However, I think it is ok because the message explicitly mentions each
failing route.

> +        status =3D false;
> +        goto done;
> +    }
> +
>  #if defined(TARGET_LINUX)
>  #ifdef ENABLE_IPROUTE
>      argv_printf(&argv, "%s -6 route add %s/%d dev %s",
> @@ -2114,6 +2119,7 @@ add_route_ipv6(struct route_ipv6 *r6, const struct =
tuntap *tt, unsigned int flag
>      msg(M_FATAL, "Sorry, but I don't know how to do 'route ipv6' command=
s on this operating system.  Try putting your routes in a --route-up script=
");
>  #endif /* if defined(TARGET_LINUX) */
>=20=20
> +done:
>      if (status)
>      {
>          r6->flags |=3D RT_ADDED;
>=20

Other than those comments above, the patch looks good and my tests did
not reveal any issue.

Acked-by: Antonio Quartulli <antonio@...515...>


Regards,

--=20
Antonio Quartulli


--WpiIbUHn6m6jXa4VatrjEmf4DYDHU1Yd3--

--MTy7aqP73LTrtknGu6XmYaTyZkTbeEfxO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE3o8ejP0lUW4GTX3J9FVsWUWDDm0FAlwXR/kACgkQ9FVsWUWD
Dm1KQA//bOV3Ya9xQKhvUTsxTfGuLmNwHCnLbZqPSp5QqYtHMPN/tXl/QqYvVW+R
MM6ZYeMBBIoTruqgmqTgal+Y0UPjRNzx5H7x01zIP/C7dpQaT6WEJ5HgXyMDg+yU
Sn0wRolkYy2lHc8pl2ikzpJYAytfad+wMedvmAd4j1Lnk3TZXtlGj4v4VS28sjwc
VBqpsZtFRLjvmXMY+zRlx6H4LNUvysBQDeQs23+XkW+R8MA6I/kPcxnG7w3rBmw0
yC36AKp8vBtoaf1pR+3tSJb5x6hYQSS9Nzv6aH5XKlGnXXX/AlOWxyP9CxlzE203
QpdQHu0k0HmSwiDSsldZijZFZggXW3ZSJ1NXFzlql/nVxTd2TnuZSwUMYjPhdkrX
73QGf6GOKicaHYlQXUIUOruivUrmNzkkG66rTwK1goCphAOJdw67RCKe+fBoX96P
Ha9lKEMQ9srDkIRotygRrCKw+yqUtyTGUyuG06ZPmad+4aiv+dhRRtNw7Lin+dxh
FJ4dsIAFlnzO1pqnIRPBwWMwLRRWF4abTJsBeMpQKnE666M5u8usxISyZ1C6/ZOB
BorQ31sM/n5TlEJzmgBRXJjjo9WaMF+ewUZPE/nqbulCqJaMSPREtsZ5J4HzFm9R
KNAPK2Ch6TzqN0oSg6pYczp9oJWAsvcSXPc6/q4cqkt89LwFAMQ=
=JCd7
-----END PGP SIGNATURE-----

--MTy7aqP73LTrtknGu6XmYaTyZkTbeEfxO--

