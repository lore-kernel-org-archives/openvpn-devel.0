Date: Sat, 11 Feb 2017 12:07:13 +0800
From: Antonio Quartulli <a@...2181...>
Message-ID: <20170211040713.GJ11922@...2182...>
References: <20170210143607.19454-1-a@...2181...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="W/D3X8sky0X3AmG5"
Content-Disposition: inline
In-Reply-To: <20170210143607.19454-1-a@...2181...>
Subject: Re: [Openvpn-devel] [PATCH] ifconfig-ipv6(-push): allow using
	hostnames
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--W/D3X8sky0X3AmG5
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Fri, Feb 10, 2017 at 10:36:07PM +0800, Antonio Quartulli wrote:
> diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
> index 82d0967d..55ff7737 100644
> --- a/src/openvpn/socket.c
> +++ b/src/openvpn/socket.c
> @@ -75,12 +75,102 @@ sf2gaf(const unsigned int getaddr_flags,
>  /*
>   * Functions related to the translation of DNS names to IP addresses.
>   */
> +static int
> +get_addr_generic(sa_family_t af, unsigned int flags, const char *hostnam=
e,
> +                 void *network, unsigned int *netbits,
> +                 int resolve_retry_seconds, volatile int *signal_receive=
d,
> +                 int msglevel)
> +{
> +    char *endp, *sep, *var_host;
> +    uint8_t bits, max_bits;
> +    struct addrinfo *ai;
> +    int ret =3D -1;
> +
> +    ASSERT(hostname);
> +
> +    /* assign family specific default values */
> +    switch (af)
> +    {
> +        case AF_INET:
> +            bits =3D 0;
> +            max_bits =3D sizeof(in_addr_t) * 8;
> +            break;
> +        case AF_INET6:
> +            bits =3D 64;
> +            max_bits =3D sizeof(struct in6_addr) * 8;
> +            break;
> +        default:
> +            ASSERT(0);
> +    }
> +
> +    /* we need to modify the hostname received as input, but we don't wa=
nt to
> +     * touch it directly as it might be a constant string.
> +     *
> +     * Therefore, we clone the string here and free it at the end of the
> +     * function */
> +    var_host =3D strdup(hostname);
> +    ASSERT(var_host);
> +
> +    /* check if this hostname has a /bits suffix */
> +    sep =3D strchr(var_host , '/');
> +    if (sep)
> +    {
> +        bits =3D strtoul(sep + 1, &endp, 10);
> +        if ((*endp !=3D '\0') || (bits > max_bits))
> +        {
> +            msg(msglevel, "IP prefix '%s': invalid '/bits' spec", hostna=
me);
> +            goto out;
> +        }
> +        /* temporary truncate string at '/'. This allows the IP
> +         * parsing routines to properly work. Will be restored later.
> +         */
> +        *sep =3D '\0';
> +    }
> +
> +    ret =3D openvpn_getaddrinfo(flags & ~GETADDR_HOST_ORDER, var_host, N=
ULL,
> +                              resolve_retry_seconds, signal_received, af=
, &ai);
> +    if ((ret =3D=3D 0) && network)
> +    {
> +        struct in6_addr *ip6;
> +        in_addr_t *ip4;
> +
> +        switch (af)
> +        {
> +            case AF_INET:
> +                ip4 =3D network;
> +                *ip4 =3D ((struct sockaddr_in *)ai->ai_addr)->sin_addr.s=
_addr;
> +
> +                if (flags & GETADDR_HOST_ORDER)
> +                {
> +                    *ip4 =3D ntohl(*ip4);
> +                }
> +                break;
> +            case AF_INET6:
> +                ip6 =3D network;
> +                *ip6 =3D ((struct sockaddr_in6 *)ai->ai_addr)->sin6_addr;
> +                break;
> +            default:
> +                ASSERT(0);
> +        }
> +        freeaddrinfo(ai);
> +    }
> +
> +    if (netbits)
> +    {
> +        *netbits =3D bits;
> +    }
> +
> +    /* restore '/' separator, if any */
> +    if (sep)
> +    {
> +        *sep =3D '/';
> +    }

Actually this part is useless. sep points somewhere inside var_host, but
var_host is going to be free'd at the next line, therefore the block above =
can
be removed.


Cheers,

--=20
Antonio Quartulli

--W/D3X8sky0X3AmG5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYno3uAAoJEJ6F1zG2JyOsPQMP+wSo9lyaNSFEGjmJMaObOjTu
D1T/qK1QheVtvm6mn8Rgm+JQiTd3iKojJh2/3nXZ0H6NRcfGHKE3PHB9N4K5uQRi
FaUnvt+HpHwPHcAWbOo7MFnDhFTrlObhQaLUL8njvfzoT4rY1M+K3nakdw1DTiLu
/KEZ5d4Xbv1HgEFNHcAyrn3R72wnTTaFDSIHfsq7ah9z93R1mWbFm7jmQqgvrhT6
IkDFmfqxqUU+3PA1ZD5MIBNyOf9Rr0HBDveU/k1ckdBVWQ47ZevmcJ2wznzScAQ0
3XRHNEnPahoqiJXBblo3ZDF66v49LXUkr4BxeJZ27No40OyLP8c7YH6NQRXU2s+W
Mfcdl/vXvkGlUwZpw9i6oqn52g0o/O3jvLvlQUvzxPiNd1yvQ+tBKHyWfJl9hELo
/DU5bYYq4oe7touVfrQ+Mxl1A7cSMlbIA6swcSE2X7htjrd76x/yVnHmf0Is1TTC
3tdQ6tu4XSWXa6k5wauaT57pofri17wv5O34IVHg3dxOdLDyoQo5CHAZy529Rotc
c940QptPGWy/poQemoonRFVAZSKvQK5Nx/01xAhHa2ToZ/fYXhEnjGxeLcZWFOvW
0TsJOn6+T9wa8F1hbVT7GS1wsJFgJN3bo77I2gcRrAR0kf0Y4pcOwhmIGK90OhPY
O6akMiBiP1wr4Ul1icqa
=wfl2
-----END PGP SIGNATURE-----

--W/D3X8sky0X3AmG5--

