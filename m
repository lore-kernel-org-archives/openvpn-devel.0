References: <20171203040907.13423-1-a@...2181...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <9db919d1-991e-4322-6f11-c67c3cd8383c@...2181...>
Date: Sun, 3 Dec 2017 12:12:13 +0800
MIME-Version: 1.0
In-Reply-To: <20171203040907.13423-1-a@...2181...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="7SBj6TPW5HCXesGWm5b8nCXaA962ttI3O"
Subject: Re: [Openvpn-devel] [PATCH v3] ifconfig-ipv6(-push): allow using
 hostnames
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
--7SBj6TPW5HCXesGWm5b8nCXaA962ttI3O
Content-Type: multipart/mixed; boundary="FeRbTBWJBwUX7esiNUa0eMpKofwi7sgQK";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: openvpn-devel@lists.sourceforge.net
Message-ID: <9db919d1-991e-4322-6f11-c67c3cd8383c@...2181...>
Subject: Re: [Openvpn-devel] [PATCH v3] ifconfig-ipv6(-push): allow using
 hostnames
References: <20171203040907.13423-1-a@...2181...>
In-Reply-To: <20171203040907.13423-1-a@...2181...>

--FeRbTBWJBwUX7esiNUa0eMpKofwi7sgQK
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Sorry, I did some mistake on my own. Will send v4.

On 03/12/17 12:09, Antonio Quartulli wrote:
> Similarly to ifconfig(-push), its IPv6 counterpart is now able to
> accept hostnames as well instead of IP addresses in numeric form.
>=20
> Basically this means that the user is now allowed to specify
> something like this:
>=20
> ifconfig-ipv6-push my.hostname.cx/64
>=20
> This is exactly the same behaviour that we already have with
> ifconfig(-push).
>=20
> The generic code introduced in this patch will be later used to
> implement the /bits parsing support for IPv4 addresses.
>=20
> Trac: #808
> Signed-off-by: Antonio Quartulli <a@...2181...>
> ---
>=20
> v3:
> - declare 'bits' as unsigned long (will store result of strtoul())
> - convert ASSERTs to plain error handling in get_addr_generic()
> - remove useless comment about '/' overwriting
> - improve debug message by printing hostname
>=20
> v2:
> - rebased on top of master
> - style adapted to new CodingStyle
>=20
>  src/openvpn/options.c |  61 ----------------------
>  src/openvpn/options.h |   4 --
>  src/openvpn/socket.c  | 140 ++++++++++++++++++++++++++++++++++++++++++++=
+-----
>  src/openvpn/socket.h  |  12 +++++
>  4 files changed, 140 insertions(+), 77 deletions(-)
>=20
> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
> index 8e5cdf7f..767cdaeb 100644
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
> @@ -1033,67 +1033,6 @@ get_ip_addr(const char *ip_string, int msglevel, b=
ool *error)
>      return ret;
>  }
>=20=20
> -/* helper: parse a text string containing an IPv6 address + netbits
> - * in "standard format" (2001:dba::/32)
> - * "/nn" is optional, default to /64 if missing
> - *
> - * return true if parsing succeeded, modify *network and *netbits
> - */
> -bool
> -get_ipv6_addr( const char *prefix_str, struct in6_addr *network,
> -               unsigned int *netbits, int msglevel)
> -{
> -    char *sep, *endp;
> -    int bits;
> -    struct in6_addr t_network;
> -
> -    sep =3D strchr( prefix_str, '/' );
> -    if (sep =3D=3D NULL)
> -    {
> -        bits =3D 64;
> -    }
> -    else
> -    {
> -        bits =3D strtol( sep+1, &endp, 10 );
> -        if (*endp !=3D '\0' || bits < 0 || bits > 128)
> -        {
> -            msg(msglevel, "IPv6 prefix '%s': invalid '/bits' spec", pref=
ix_str);
> -            return false;
> -        }
> -    }
> -
> -    /* temporary replace '/' in caller-provided string with '\0', otherw=
ise
> -     * inet_pton() will refuse prefix string
> -     * (alternative would be to strncpy() the prefix to temporary buffer)
> -     */
> -
> -    if (sep !=3D NULL)
> -    {
> -        *sep =3D '\0';
> -    }
> -
> -    if (inet_pton( AF_INET6, prefix_str, &t_network ) !=3D 1)
> -    {
> -        msg(msglevel, "IPv6 prefix '%s': invalid IPv6 address", prefix_s=
tr);
> -        return false;
> -    }
> -
> -    if (sep !=3D NULL)
> -    {
> -        *sep =3D '/';
> -    }
> -
> -    if (netbits !=3D NULL)
> -    {
> -        *netbits =3D bits;
> -    }
> -    if (network !=3D NULL)
> -    {
> -        *network =3D t_network;
> -    }
> -    return true;                /* parsing OK, values set */
> -}
> -
>  /**
>   * Returns newly allocated string containing address part without "/nn".
>   *
> diff --git a/src/openvpn/options.h b/src/openvpn/options.h
> index 035c6d15..d67c2785 100644
> --- a/src/openvpn/options.h
> +++ b/src/openvpn/options.h
> @@ -817,8 +817,4 @@ void options_string_import(struct options *options,
>                             unsigned int *option_types_found,
>                             struct env_set *es);
>=20=20
> -bool get_ipv6_addr( const char *prefix_str, struct in6_addr *network,
> -                    unsigned int *netbits, int msglevel );
> -
> -
>  #endif /* ifndef OPTIONS_H */
> diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
> index 0fc91f21..0cb5662c 100644
> --- a/src/openvpn/socket.c
> +++ b/src/openvpn/socket.c
> @@ -74,12 +74,116 @@ sf2gaf(const unsigned int getaddr_flags,
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
> +    char *endp, *sep, *var_host =3D NULL;
> +    struct addrinfo *ai =3D NULL;
> +    unsigned long bits;
> +    uint8_t max_bits;
> +    int ret =3D -1;
> +
> +    if (!hostname)
> +    {
> +        msg(M_NONFTAL, "Can't resolve null hostname!");
> +        goto out;
> +    }
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
> +            msg(M_WARN,
> +                "Unsupported AF family passed to getaddrinfo for %s (%d)=
",
> +                hostname, af);
> +            goto out;
> +    }
> +
> +    /* we need to modify the hostname received as input, but we don't wa=
nt to
> +     * touch it directly as it might be a constant string.
> +     *
> +     * Therefore, we clone the string here and free it at the end of the
> +     * function */
> +    var_host =3D strdup(hostname);
> +    if (!var_host)
> +    {
> +        msg(M_NONFTAL | M_ERRNO,
> +            "Can't allocate hostname buffer for getaddrinfo");
> +        goto out;
> +    }
> +
> +    /* check if this hostname has a /bits suffix */
> +    sep =3D strchr(var_host , '/');
> +    if (sep)
> +    {
> +        bits =3D strtoul(sep + 1, &endp, 10);
> +        if ((*endp !=3D '\0') || (bits > max_bits))
> +        {
> +            msg(msglevel, "IP prefix '%s': invalid '/bits' spec (%s)", h=
ostname,
> +                sep + 1);
> +            goto out;
> +        }
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
> +                /* can't get here because 'af' was previously checked */
> +                msg(M_WARN,
> +                    "Unsupported AF family for %s (%d)", af, var_host);
> +                goto out;
> +        }
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
> +out:
> +    freeaddrinfo(ai);
> +    free(var_host);
> +
> +    return ret;
> +}
>=20=20
> -/*
> - * Translate IP addr or hostname to in_addr_t.
> - * If resolve error, try again for
> - * resolve_retry_seconds seconds.
> - */
>  in_addr_t
>  getaddr(unsigned int flags,
>          const char *hostname,
> @@ -87,20 +191,19 @@ getaddr(unsigned int flags,
>          bool *succeeded,
>          volatile int *signal_received)
>  {
> -    struct addrinfo *ai;
> +    in_addr_t addr;
>      int status;
> -    status =3D openvpn_getaddrinfo(flags & ~GETADDR_HOST_ORDER, hostname=
, NULL,
> -                                 resolve_retry_seconds, signal_received,=
 AF_INET, &ai);
> +
> +    status =3D get_addr_generic(AF_INET, flags, hostname, &addr, NULL,
> +                              resolve_retry_seconds, signal_received,
> +                              M_WARN);
>      if (status=3D=3D0)
>      {
> -        struct in_addr ia;
>          if (succeeded)
>          {
>              *succeeded =3D true;
>          }
> -        ia =3D ((struct sockaddr_in *)ai->ai_addr)->sin_addr;
> -        freeaddrinfo(ai);
> -        return (flags & GETADDR_HOST_ORDER) ? ntohl(ia.s_addr) : ia.s_ad=
dr;
> +        return addr;
>      }
>      else
>      {
> @@ -112,6 +215,19 @@ getaddr(unsigned int flags,
>      }
>  }
>=20=20
> +bool
> +get_ipv6_addr(const char *hostname, struct in6_addr *network,
> +              unsigned int *netbits, int msglevel)
> +{
> +    if (get_addr_generic(AF_INET6, GETADDR_RESOLVE, hostname, network, n=
etbits,
> +                         0, NULL, msglevel) < 0)
> +    {
> +        return false;
> +    }
> +
> +    return true;                /* parsing OK, values set */
> +}
> +
>  static inline bool
>  streqnull(const char *a, const char *b)
>  {
> diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
> index 2d7f2187..81e9e9ae 100644
> --- a/src/openvpn/socket.h
> +++ b/src/openvpn/socket.h
> @@ -532,12 +532,24 @@ bool unix_socket_get_peer_uid_gid(const socket_desc=
riptor_t sd, int *uid, int *g
>=20=20
>  #define GETADDR_CACHE_MASK              (GETADDR_DATAGRAM|GETADDR_PASSIV=
E)
>=20=20
> +/**
> + * Translate an IPv4 addr or hostname from string form to in_addr_t
> + *
> + * In case of resolve error, it will try again for
> + * resolve_retry_seconds seconds.
> + */
>  in_addr_t getaddr(unsigned int flags,
>                    const char *hostname,
>                    int resolve_retry_seconds,
>                    bool *succeeded,
>                    volatile int *signal_received);
>=20=20
> +/**
> + * Translate an IPv6 addr or hostname from string form to in6_addr
> + */
> +bool get_ipv6_addr(const char *hostname, struct in6_addr *network,
> +                   unsigned int *netbits, int msglevel);
> +
>  int openvpn_getaddrinfo(unsigned int flags,
>                          const char *hostname,
>                          const char *servname,
>=20

--=20
Antonio Quartulli


--FeRbTBWJBwUX7esiNUa0eMpKofwi7sgQK--

--7SBj6TPW5HCXesGWm5b8nCXaA962ttI3O
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAlojeZ0ACgkQB6U8WA7y
zXRNIQ/5AToNiClt+whtmF4pmKs9KLTDkz5LaUSEay+6407VcgrXH7QJrFmfIyEw
ZL1kSGQHhrZ7c5JACyKtvO88ijFEczkVs+/X2YOScSFZD2wzPmvV4px1/whR2Hyl
98NsgeaczJzrGojJfK6KoQEotCXFbMED7oNFBhvnwkcnlDlq9YFXvbXZ6k/7qn8g
Xc9K92qPYYpl9kisGG165Mfm8dpkGoLPzMIkuIGXS63I1jyNR6z8tCNXB0rS9gsQ
rD0WfXlOI8jYlxsCe1dKtt/bZKf9Eop/PsbdN0PPKgPxv32Mr7CzrPlgGPNR1yhO
b9A75DFj0luB9/cjt51fzzEXid22j2S8yIBbGrVCq7snl5SIZQgF/C5PKKEhDLk9
tcZrBDPl4GmudjHYoKLOV4MMfNZeB63O++mVNpAeL2e2A4HvoOwDvRhnIwsU2PCQ
4xManUcTEuzBJwRGXCOKg4EFQECYS2s9KdQ1qI0BifeSoUeHnLGITPEu2rnNgvDS
mBfxcwd0Kwcfz8SWxR1DCQEE9Yj6ZKVJUzpV1IpMi7CMxe+fPZWbnKtnUo5tgb/Y
0MiFyOFKubAiIauqmFtzWATyNoeCHpay4VcFVi4fJQAcRtRxeekNe2qZLMqHl0I7
H5Gx5WxoLo+yjtpeO9lKs8vF+oUqBOWSZZODpAMAiMaXhd04QXw=
=brgn
-----END PGP SIGNATURE-----

--7SBj6TPW5HCXesGWm5b8nCXaA962ttI3O--

