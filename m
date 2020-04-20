References: <20191127134258.9162-1-l@...2534...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <d21e5944-44c9-9fd0-ab77-b47c65c93663@...1227...>
Date: Mon, 20 Apr 2020 14:28:28 +0200
MIME-Version: 1.0
In-Reply-To: <20191127134258.9162-1-l@...2534...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="f74F9Jk1ZBRJa6iqDCW7kSWIwHh8wud4R"
Subject: Re: [Openvpn-devel] [PATCH] Fix IPv6 configuration on Windows using
 netsh
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Laurent Fasnacht <l@...2534...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--f74F9Jk1ZBRJa6iqDCW7kSWIwHh8wud4R
Content-Type: multipart/mixed; boundary="EWheMi76rX6C5UXRaMnYVy4hnW66n7x36"

--EWheMi76rX6C5UXRaMnYVy4hnW66n7x36
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 27.11.19 um 14:43 schrieb Laurent Fasnacht:
> Apparently, `netsh interface ipv6 set address ...` defaults to using
> a subnet of /64, and therefore adds an onlink route of that size.
>=20
> When using a tun tunnel, the tap adapter only replies to neighbor
> discovery packets for fe80::8. This leads to the unfortunate situation
> where all the hosts in the /64 are not reachable.
>=20
> This patch fixes that situation by specifying a /128 netmask, as the real
> route is added afterwards, via the gateway.
> ---
>  src/openvpn/tun.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
> index 599fd817..8b054c80 100644
> --- a/src/openvpn/tun.c
> +++ b/src/openvpn/tun.c
> @@ -982,15 +982,15 @@ do_ifconfig_ipv6(struct tuntap *tt, const char *ifn=
ame, int tun_mtu,
>      else
>      {
>          /* example: netsh interface ipv6 set address interface=3D42
> -         *                  2001:608:8003::d store=3Dactive
> +         *                  2001:608:8003::d/128 store=3Dactive
>           */
>          char iface[64];
>=20=20
>          openvpn_snprintf(iface, sizeof(iface), "interface=3D%lu",
>                           tt->adapter_index);
> -        argv_printf(&argv, "%s%sc interface ipv6 set address %s %s store=
=3Dactive",
> +        argv_printf(&argv, "%s%sc interface ipv6 set address %s %s/%d st=
ore=3Dactive",
>                      get_win_sys_path(), NETSH_PATH_SUFFIX, iface,
> -                    ifconfig_ipv6_local);
> +                    ifconfig_ipv6_local, 128);
>          netsh_command(&argv, 4, M_FATAL);
>          /* set ipv6 dns servers if any are specified */
>          netsh_set_dns6_servers(tt->options.dns6, tt->options.dns6_len, i=
fname);

Instead changing the implicit /64 to an explicit /128, wouldn't it be
better to use the correct tt->netbits_ipv6 like on other platforms?

Arne



--EWheMi76rX6C5UXRaMnYVy4hnW66n7x36--

--f74F9Jk1ZBRJa6iqDCW7kSWIwHh8wud4R
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl6dlWwACgkQFRhsZwKx
RFQgahAAhq25i7vlgm2epjLmeou0uuJ7SHrgVxrD4BUThDKpOtRIHEMymCXcuA3t
cgxO8NR1aFLkajza7vJ9in6KU5MnUpPUBezMiPmPg1vbt/neS282L+CJxdaqReIx
gxx3CZ0C94ZPAx7Gwp2qdqYDol+Kdqf9I1FjKNSA1wo+/yT0Aswl6kZHNdI68VN3
nUd0Lbb8qT8TcN83JaPX7zRdcu6xHNFrJNdH7PPR8YuhvLwkKB+i8wtA22X/PK5F
mz2jwt5xeZeOWAr62oZCZi8EWdHxt+BSCatsGjH81r7s0AaW65Jhm3yQy149gQC5
TYBQkj+KDGxD6HSaayttecYUzgAD3HRHqKG5VMQsEDzmlOe67EVHhN8JkrjHMqRi
zX5M1rEkFrlBH2A2exmcNNHol02Infgb40hewnOk7DRUdQ3+QoaGzQD/+i6vYBFA
lhoA62lvSqNGmIhd3UJaVjyvUF6z0x2fvojIy9YxDPRd3dn9uPRU7+rTopy/ILFy
/4KcYTqc4xe0d8Tax55oBje+bARvj3VbY+Q0pQ420612CVGUwqe9guU4vLFH7xNt
/KA2h+GwaiH77Qtv34H8nE82Z2eXUNFa75Y8Ql811rHmB3qEYIGRFQX8YUz9K6Eq
w1WWTqE72PXzMZKnbAz23WOZ8SbfdfzL5SWWvkDssbm/Gmcn1sk=
=RsMj
-----END PGP SIGNATURE-----

--f74F9Jk1ZBRJa6iqDCW7kSWIwHh8wud4R--

