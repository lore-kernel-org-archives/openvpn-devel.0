MIME-Version: 1.0
In-Reply-To: <20171203041426.25316-1-a@...2181...>
References: <20171203041426.25316-1-a@...2181...>
From: Selva Nair <selva.nair@...277...>
Date: Mon, 4 Dec 2017 11:17:24 -0500
Message-ID: <CAKuzo_i3pDk4jcppvwv-AcBMzmZthyc87tP2eoz=m8NjSsFRgg@...278...>
Subject: Re: [Openvpn-devel] [PATCH v4] ifconfig-ipv6(-push): allow using
 hostnames
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: Antonio Quartulli <a@...2181...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi,

Back to the patch I hijacked... :)

On Sat, Dec 2, 2017 at 11:14 PM, Antonio Quartulli <a@...2181...> wrote:
>
> Similarly to ifconfig(-push), its IPv6 counterpart is now able to
> accept hostnames as well instead of IP addresses in numeric form.
>
> Basically this means that the user is now allowed to specify
> something like this:
>
> ifconfig-ipv6-push my.hostname.cx/64

FYI, at some point we had decided to use example.com variants
(see man page examples) instead of randomly made up hostnames.
However, this being only a commit message, its ok as is.

As for docs, the current description of ifconfig-ipv6-push in
the man page refers to ifconfig-push indirectly implying that dns
names will work.

So a man page edit is not essential, and I leave it to you to amend
this with an explicit statement in man or not.

>
> This is exactly the same behaviour that we already have with
> ifconfig(-push).
>
> The generic code introduced in this patch will be later used to
> implement the /bits parsing support for IPv4 addresses.
>
> Trac: #808
> Signed-off-by: Antonio Quartulli <a@...2181...>
> ---
>
> v4:
> - fix variable order in debug message
> - fix typo in loglevel name
>
> v3:
> - declare 'bits' as unsigned long (will store result of strtoul())
> - convert ASSERTs to plain error handling in get_addr_generic()
> - remove useless comment about '/' overwriting
> - improve debug message by printing hostname
>
> v2:
> - rebased on top of master
> - style adapted to new CodingStyle
>
>
>  src/openvpn/options.c |  61 ----------------------
>  src/openvpn/options.h |   4 --
>  src/openvpn/socket.c  | 140 +++++++++++++++++++++++++++++++++++++++++++++-----
>  src/openvpn/socket.h  |  12 +++++
>  4 files changed, 140 insertions(+), 77 deletions(-)
>
> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
> index 8e5cdf7f..767cdaeb 100644
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
> @@ -1033,67 +1033,6 @@ get_ip_addr(const char *ip_string, int msglevel, bool *error)
>      return ret;
>  }
>
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
> -    sep = strchr( prefix_str, '/' );
> -    if (sep == NULL)
> -    {
> -        bits = 64;
> -    }
> -    else
> -    {
> -        bits = strtol( sep+1, &endp, 10 );
> -        if (*endp != '\0' || bits < 0 || bits > 128)
> -        {
> -            msg(msglevel, "IPv6 prefix '%s': invalid '/bits' spec", prefix_str);
> -            return false;
> -        }
> -    }
> -
> -    /* temporary replace '/' in caller-provided string with '\0', otherwise
> -     * inet_pton() will refuse prefix string
> -     * (alternative would be to strncpy() the prefix to temporary buffer)
> -     */
> -
> -    if (sep != NULL)
> -    {
> -        *sep = '\0';
> -    }
> -
> -    if (inet_pton( AF_INET6, prefix_str, &t_network ) != 1)
> -    {
> -        msg(msglevel, "IPv6 prefix '%s': invalid IPv6 address", prefix_str);
> -        return false;
> -    }
> -
> -    if (sep != NULL)
> -    {
> -        *sep = '/';
> -    }
> -
> -    if (netbits != NULL)
> -    {
> -        *netbits = bits;
> -    }
> -    if (network != NULL)
> -    {
> -        *network = t_network;
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
>
> -bool get_ipv6_addr( const char *prefix_str, struct in6_addr *network,
> -                    unsigned int *netbits, int msglevel );
> -
> -
>  #endif /* ifndef OPTIONS_H */
> diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
> index 0fc91f21..7f3842da 100644
> --- a/src/openvpn/socket.c
> +++ b/src/openvpn/socket.c
> @@ -74,12 +74,116 @@ sf2gaf(const unsigned int getaddr_flags,
>  /*
>   * Functions related to the translation of DNS names to IP addresses.
>   */
> +static int
> +get_addr_generic(sa_family_t af, unsigned int flags, const char *hostname,
> +                 void *network, unsigned int *netbits,
> +                 int resolve_retry_seconds, volatile int *signal_received,
> +                 int msglevel)
> +{
> +    char *endp, *sep, *var_host = NULL;
> +    struct addrinfo *ai = NULL;
> +    unsigned long bits;
> +    uint8_t max_bits;
> +    int ret = -1;
> +
> +    if (!hostname)
> +    {
> +        msg(M_NONFATAL, "Can't resolve null hostname!");

I didn't mean to banish ASSERT: it does have some legitimate
uses. IMO, if the invalid input is due to programmer error, say, null
hostname, ASSERT is good and useful to catch it during tests.
But if its a user input error, say, empty hostname, or some runtime
error, use of ASSERT calls for a very strong justification.

Just expressing an opinion, I respect your choice here and below.

>
> +        goto out;
> +    }
> +
> +    /* assign family specific default values */
> +    switch (af)
> +    {
> +        case AF_INET:
> +            bits = 0;
> +            max_bits = sizeof(in_addr_t) * 8;
> +            break;
> +        case AF_INET6:
> +            bits = 64;
> +            max_bits = sizeof(struct in6_addr) * 8;
> +            break;
> +        default:
> +            msg(M_WARN,
> +                "Unsupported AF family passed to getaddrinfo for %s (%d)",
> +                hostname, af);
> +            goto out;
> +    }
> +
> +    /* we need to modify the hostname received as input, but we don't want to
> +     * touch it directly as it might be a constant string.
> +     *
> +     * Therefore, we clone the string here and free it at the end of the
> +     * function */
> +    var_host = strdup(hostname);
> +    if (!var_host)
> +    {
> +        msg(M_NONFATAL | M_ERRNO,
> +            "Can't allocate hostname buffer for getaddrinfo");
> +        goto out;
> +    }
> +
> +    /* check if this hostname has a /bits suffix */
> +    sep = strchr(var_host , '/');
> +    if (sep)
> +    {
> +        bits = strtoul(sep + 1, &endp, 10);
> +        if ((*endp != '\0') || (bits > max_bits))
> +        {
> +            msg(msglevel, "IP prefix '%s': invalid '/bits' spec (%s)", hostname,
> +                sep + 1);
> +            goto out;
> +        }
> +        *sep = '\0';
> +    }
> +
> +    ret = openvpn_getaddrinfo(flags & ~GETADDR_HOST_ORDER, var_host, NULL,
> +                              resolve_retry_seconds, signal_received, af, &ai);
> +    if ((ret == 0) && network)
> +    {
> +        struct in6_addr *ip6;
> +        in_addr_t *ip4;
> +
> +        switch (af)
> +        {
> +            case AF_INET:
> +                ip4 = network;
> +                *ip4 = ((struct sockaddr_in *)ai->ai_addr)->sin_addr.s_addr;
> +
> +                if (flags & GETADDR_HOST_ORDER)
> +                {
> +                    *ip4 = ntohl(*ip4);
> +                }
> +                break;
> +            case AF_INET6:
> +                ip6 = network;
> +                *ip6 = ((struct sockaddr_in6 *)ai->ai_addr)->sin6_addr;
> +                break;
> +            default:
> +                /* can't get here because 'af' was previously checked */
> +                msg(M_WARN,
> +                    "Unsupported AF family for %s (%d)", var_host, af);
> +                goto out;
> +        }
> +    }
> +
> +    if (netbits)
> +    {
> +        *netbits = bits;
> +    }
> +
> +    /* restore '/' separator, if any */
> +    if (sep)
> +    {
> +        *sep = '/';
> +    }
> +out:
> +    freeaddrinfo(ai);
> +    free(var_host);
> +
> +    return ret;
> +}
>
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
> -    status = openvpn_getaddrinfo(flags & ~GETADDR_HOST_ORDER, hostname, NULL,
> -                                 resolve_retry_seconds, signal_received, AF_INET, &ai);
> +
> +    status = get_addr_generic(AF_INET, flags, hostname, &addr, NULL,
> +                              resolve_retry_seconds, signal_received,
> +                              M_WARN);
>      if (status==0)
>      {
> -        struct in_addr ia;
>          if (succeeded)
>          {
>              *succeeded = true;
>          }
> -        ia = ((struct sockaddr_in *)ai->ai_addr)->sin_addr;
> -        freeaddrinfo(ai);
> -        return (flags & GETADDR_HOST_ORDER) ? ntohl(ia.s_addr) : ia.s_addr;
> +        return addr;
>      }
>      else
>      {
> @@ -112,6 +215,19 @@ getaddr(unsigned int flags,
>      }
>  }
>
> +bool
> +get_ipv6_addr(const char *hostname, struct in6_addr *network,
> +              unsigned int *netbits, int msglevel)
> +{
> +    if (get_addr_generic(AF_INET6, GETADDR_RESOLVE, hostname, network, netbits,
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
> @@ -532,12 +532,24 @@ bool unix_socket_get_peer_uid_gid(const socket_descriptor_t sd, int *uid, int *g
>
>  #define GETADDR_CACHE_MASK              (GETADDR_DATAGRAM|GETADDR_PASSIVE)
>
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
>
> +/**
> + * Translate an IPv6 addr or hostname from string form to in6_addr
> + */
> +bool get_ipv6_addr(const char *hostname, struct in6_addr *network,
> +                   unsigned int *netbits, int msglevel);
> +
>  int openvpn_getaddrinfo(unsigned int flags,
>                          const char *hostname,
>                          const char *servname,

Looks good and works as advertised. Thanks.

Reviewed-by: Selva Nair <selva.nair@...277...>
Tested-by:  Selva Nair <selva.nair@...277...>
Acked-by: Selva Nair <selva.nair@...277...>

