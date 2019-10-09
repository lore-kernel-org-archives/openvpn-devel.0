References: <20191009095200.9337-1-gert@...1296...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <154fac8b-7749-ac93-4ea0-5eb01b405478@...2181...>
Date: Wed, 9 Oct 2019 13:07:42 +0200
MIME-Version: 1.0
In-Reply-To: <20191009095200.9337-1-gert@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="SXoDboNzFypVCgqURJoZRCRc7uuQfprGD"
Subject: Re: [Openvpn-devel] [PATCH 1/2] repair tap mode on
 OpenSolaris/OpenIndiana
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SXoDboNzFypVCgqURJoZRCRc7uuQfprGD
Content-Type: multipart/mixed; boundary="6Lp6NEuabkkNYcYnTKRZQl1UPKLmUdTOk";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net
Message-ID: <154fac8b-7749-ac93-4ea0-5eb01b405478@...2181...>
Subject: Re: [Openvpn-devel] [PATCH 1/2] repair tap mode on
 OpenSolaris/OpenIndiana
References: <20191009095200.9337-1-gert@...1296...>
In-Reply-To: <20191009095200.9337-1-gert@...1296...>

--6Lp6NEuabkkNYcYnTKRZQl1UPKLmUdTOk
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On 09/10/2019 11:51, Gert Doering wrote:
> commit 611fcbc48 joined the two distinct calls for "add ipv6 address
> to tap interface" and "set MTU" for Solaris - but due to peculiarities
> on how this platform handles IPv6 addresses ("ifconfig addif" creates
> a new "tap0:1" subinterface with the new address - which does not have
> a distinct MTU) this does not work.
>=20
> un-join calls again.

Thanks for fixing my change.
The patch makes sense as it simply restores the original flow.

I have only reviewed the code and compile-tested it, but I trust Gert
who said to have performed a t_client test on his OpenIndiana2019 host
(which is where the problem was found in the first place).

Acked-by: Antonio Quartulli <antonio@...515...>

>=20
> Signed-off-by: Gert Doering <gert@...1296...>
> ---
>  src/openvpn/tun.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
>=20
> diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
> index 0591df65..ce23eb6a 100644
> --- a/src/openvpn/tun.c
> +++ b/src/openvpn/tun.c
> @@ -937,9 +937,11 @@ do_ifconfig_ipv6(struct tuntap *tt, const char *ifna=
me, int tun_mtu,
>           * server will ignore the DHCPv6 packets anyway.  So we don't.
>           */
>=20=20
> -        /* static IPv6 addresses need to go to a subinterface (tap0:1) */
> -        argv_printf(&argv, "%s %s inet6 addif %s/%d mtu %d up", IFCONFIG=
_PATH,
> -                    ifname, ifconfig_ipv6_local, tt->netbits_ipv6, tun_m=
tu);
> +        /* static IPv6 addresses need to go to a subinterface (tap0:1)
> +         * and we cannot set an mtu here (must go to the "parent")
> +         */
> +        argv_printf(&argv, "%s %s inet6 addif %s/%d up", IFCONFIG_PATH,
> +                    ifname, ifconfig_ipv6_local, tt->netbits_ipv6 );
>      }
>      argv_msg(M_INFO, &argv);
>=20=20
> @@ -947,6 +949,14 @@ do_ifconfig_ipv6(struct tuntap *tt, const char *ifna=
me, int tun_mtu,
>      {
>          solaris_error_close(tt, es, ifname, true);
>      }
> +
> +    if (tt->type !=3D DEV_TYPE_TUN)
> +    {
> +        argv_printf(&argv, "%s %s inet6 mtu %d", IFCONFIG_PATH,
> +                    ifname, tun_mtu);
> +        argv_msg(M_INFO, &argv);
> +        openvpn_execve_check(&argv, es, 0, "Solaris ifconfig IPv6 mtu fa=
iled");
> +    }
>  #elif defined(TARGET_OPENBSD) || defined(TARGET_NETBSD) \
>      || defined(TARGET_DARWIN) || defined(TARGET_FREEBSD) \
>      || defined(TARGET_DRAGONFLY)
>=20

--=20
Antonio Quartulli


--6Lp6NEuabkkNYcYnTKRZQl1UPKLmUdTOk--

--SXoDboNzFypVCgqURJoZRCRc7uuQfprGD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEOj/Eejms5Fxtp0v4pNfqZUlHtXIFAl2dv34ACgkQpNfqZUlH
tXLD0g//dTZo1CLHzhh+s9bKc0FKhWrU6leBFGLjvK+Uo3566DGhS867yLKYL8H1
dgGYMCV+/hlxB6tjpOGJfffuGKM/mU2gUSgzw5FaErx9wmc0bH8nF4/0Ykk+h561
to5VXHPqeOzYvXjQNMa0BY+78rQHT6Pkui6W0X9vsTGBQ/yfZ/MWY8A9xVSuC02R
DjH4UAQfHJW+CeeR1H+EA9PGeIPN6itVe5ni/aC7XoZjNMJyZ7EYb2ymsUz94vMP
BVoWBP7q5z5mzDMHa5hrJJjx9Rjz1Op+VaBfz2JPkISRA5+c9h4MBa3QKRJZB2nX
z631jfrKp6P2EeTbYam1IYtOOWX5cUhMOozsYC9UD5iDuPOPuzlkVUxRvr1td1Xl
cvWDQxuQ3Lj/uijP1ZmgxPs7ekvkEgOdeId5Z8bPGnzLCQ4UXsfXWS/QYEp45ps3
ICnEvkWQ2CayPH2hB095qemF0+lb+3+zoiloa1XeRG6Ku1nJjLnGrzcIykpFfc2q
joZKL7YO0MekztqmeRh51ELGJAXwiK3Zb8NQ5/rZWZWOl84f+SfCka3DJplkM1s7
5lnT0W40mjJ28PhmLeXvoYhIA5GwKfg8e0H/Q+WKaV7g1OFIFzNyGjAANA38BnMh
JKoW+jrT5jB1pi2rbMa5MFK0dHX7LmkwXpxMUp3zKtbAySQyLII=
=hs3d
-----END PGP SIGNATURE-----

--SXoDboNzFypVCgqURJoZRCRc7uuQfprGD--

