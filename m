MIME-Version: 1.0
In-Reply-To: <20171202085438.2393-1-a@...2181...>
References: <20171202085438.2393-1-a@...2181...>
From: Selva Nair <selva.nair@...277...>
Date: Sat, 2 Dec 2017 15:27:52 -0500
Message-ID: <CAKuzo_hgmFaE8ygqJ18YfP+WL+gaVh8yjnNCU0P0zQ=meOPeTg@...278...>
Content-Type: multipart/alternative; boundary="94eb2c0e44e000bec4055f6153d4"
Subject: Re: [Openvpn-devel] [PATCH v2] ifconfig-ipv6(-push): allow using
 hostnames
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--94eb2c0e44e000bec4055f6153d4
Content-Type: text/plain; charset="UTF-8"

Hi,

On Sat, Dec 2, 2017 at 3:54 AM, Antonio Quartulli <a@...2181...> wrote:

> Similarly to ifconfig(-push), its IPv6 counterpart is now able to
> accept hostnames as well instead of IP addresses in numeric form.
>

If dns names currently work for ifconfig-push (I didn't know),  makes sense
to
support it for ipv6 as well.

But getaddrinfo can take a long time to timeout, so we are adding another
potentially blocking call on the server. Should not be an issue on a well
administered server, but just saying...

Otherwise looks good except for a couple of issues as below:


> Basically this means that the user is now allowed to specify
> something like this:
>
> ifconfig-ipv6-push my.hostname.cx/64
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
> v2:
> - rebased on top of master
> - style adapted to new CodingStyle
>
>  src/openvpn/options.c |  61 ------------------------
>  src/openvpn/options.h |   4 --
>  src/openvpn/socket.c  | 126 ++++++++++++++++++++++++++++++
> +++++++++++++++-----
>  src/openvpn/socket.h  |  12 +++++
>  4 files changed, 126 insertions(+), 77 deletions(-)
>
> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
> index 8e5cdf7f..767cdaeb 100644
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
> @@ -1033,67 +1033,6 @@ get_ip_addr(const char *ip_string, int msglevel,
> bool *error)
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
> -            msg(msglevel, "IPv6 prefix '%s': invalid '/bits' spec",
> prefix_str);
> -            return false;
> -        }
> -    }
> -
> -    /* temporary replace '/' in caller-provided string with '\0',
> otherwise
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
> -        msg(msglevel, "IPv6 prefix '%s': invalid IPv6 address",
> prefix_str);
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
> index 0fc91f21..4cadae23 100644
> --- a/src/openvpn/socket.c
> +++ b/src/openvpn/socket.c
> @@ -74,12 +74,102 @@ sf2gaf(const unsigned int getaddr_flags,
>  /*
>   * Functions related to the translation of DNS names to IP addresses.
>   */
> +static int
> +get_addr_generic(sa_family_t af, unsigned int flags, const char *hostname,
> +                 void *network, unsigned int *netbits,
> +                 int resolve_retry_seconds, volatile int *signal_received,
> +                 int msglevel)
> +{
> +    char *endp, *sep, *var_host;
> +    uint8_t bits, max_bits;
> +    struct addrinfo *ai;
> +    int ret = -1;
> +
> +    ASSERT(hostname);
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
> +            ASSERT(0);
> +    }
> +
> +    /* we need to modify the hostname received as input, but we don't
> want to
> +     * touch it directly as it might be a constant string.
> +     *
> +     * Therefore, we clone the string here and free it at the end of the
> +     * function */
> +    var_host = strdup(hostname);
> +    ASSERT(var_host);
>

I think ASSERT should be used only to catch errors in coding logic,
not for plausible runtime errors like this. Especially since this happens
on the server, no reason to terminate the process here.

Instead, log an error (M_NONFTAL|M_ERRNO will do nicely) and return -1
or goto out. The option parser will log a generic warning, but still useful
to log here using M_ERRNO for more specific info.

Alternatively one could use a buffer on the stack --  easy to do as good
old dns names are limited in size (255 octets max?) and the current option
parser also limits the argument passed here to < 255 bytes. But if we
support
internationalized domain names (currently we do not, do we?) and if the line
length in option parser is ever increased, a much larger buffer would be
needed.


> +
> +    /* check if this hostname has a /bits suffix */
> +    sep = strchr(var_host , '/');
> +    if (sep)
> +    {
> +        bits = strtoul(sep + 1, &endp, 10);


There are a number of such type coercions in the patch
(ulong to uint8_t, size_t  to unit8_t etc.) that some compilers (aka MSVC:)
may warn about, but I do not personally care. All are safe and deliberate
except for the nitpicking below.

+        if ((*endp != '\0') || (bits > max_bits))


That (bits > max_bits) check will not catch many input errors, as the
input is  already truncated to uint8_t. For example, /255 will be flagged
as an error, but /256 will pass as 0.

Though its not possible to catch all input errors, keeping bits as unsigned
int (instead of uint8_t) may be better here. That'll  also match netbits
in the function signature, return value of strtoul etc..

+        {
> +            msg(msglevel, "IP prefix '%s': invalid '/bits' spec",
> hostname);
> +            goto out;
> +        }
> +        /* temporary truncate string at '/'. This allows the IP
> +         * parsing routines to properly work. Will be restored later.
> +         */
>

This comment is no longer required as there is no need to restore '/'
(also see below)


> +        *sep = '\0';
> +    }
> +
> +    ret = openvpn_getaddrinfo(flags & ~GETADDR_HOST_ORDER, var_host, NULL,
> +                              resolve_retry_seconds, signal_received, af,
> &ai);
> +    if ((ret == 0) && network)
> +    {
> +        struct in6_addr *ip6;
> +        in_addr_t *ip4;
> +
> +        switch (af)
> +        {
> +            case AF_INET:
> +                ip4 = network;
> +                *ip4 = ((struct sockaddr_in *)ai->ai_addr)->sin_addr.s_
> addr;
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
> +                ASSERT(0);
> +        }
> +        freeaddrinfo(ai);
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
>

This restore is redundant as we are now working on a copy which
is going to be freed two lines below.


> +out:
> +    free(var_host);
> +
> +    return ret;
> +}
>

...

+/**
> + * Translate an IPv4 addr or hostname from string form to in_addr_t
> + *
> + * In case of resolve error, it will try again for
> + * resolve_retry_seconds seconds.
> + */
>

More docs is nice, but this is confusing. It will retry for
(resolve_retry_seconds / 5)
times will be more correct. Its as if someone thought if the caller says
try for 15
seconds its ok to try three times and wait 5 seconds in between. In reality
that
could take 90 seconds or even more in some cases as getaddrinfo may not
return
for 30 seconds or more. But that's a separate issue.

And, it will try only once if flags contain GETADDR_TRY_ONCE

 in_addr_t getaddr(unsigned int flags,
>                    const char *hostname,
>                    int resolve_retry_seconds,
>                    bool *succeeded,
>                    volatile int *signal_received);


The rest looks good though I've not tested it.

Selva

--94eb2c0e44e000bec4055f6153d4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><div class=3D"gmail_extra"><br><div class=3D"gmail=
_quote">On Sat, Dec 2, 2017 at 3:54 AM, Antonio Quartulli <span dir=3D"ltr"=
>&lt;<a href=3D"mailto:a@...2181..." target=3D"_blank">a@...2181...</a>&gt;=
</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Similar=
ly to ifconfig(-push), its IPv6 counterpart is now able to<br>
accept hostnames as well instead of IP addresses in numeric form.<br></bloc=
kquote><div><br></div><div>If dns names currently work for ifconfig-push (I=
 didn&#39;t know), =C2=A0makes sense to</div><div>support it for ipv6 as we=
ll.</div><div><br></div><div>But getaddrinfo can take a long time to timeou=
t, so we are adding another</div><div>potentially blocking call on the serv=
er. Should not be an issue on a well</div><div>administered server, but jus=
t saying...</div><div><br></div><div>Otherwise looks good except for a coup=
le of issues as below:</div><div><br></div><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex">
<br>
Basically this means that the user is now allowed to specify<br>
something like this:<br>
<br>
ifconfig-ipv6-push <a href=3D"http://my.hostname.cx/64" rel=3D"noreferrer" =
target=3D"_blank">my.hostname.cx/64</a><br>
<br>
This is exactly the same behaviour that we already have with<br>
ifconfig(-push).<br>
<br>
The generic code introduced in this patch will be later used to<br>
implement the /bits parsing support for IPv4 addresses.<br>
<br>
Trac: #808<br>
Signed-off-by: Antonio Quartulli &lt;a@...2181...&gt;<br>
---<br>
<br>
v2:<br>
- rebased on top of master<br>
- style adapted to new CodingStyle<br>
<br>
=C2=A0src/openvpn/options.c |=C2=A0 61 ------------------------<br>
=C2=A0src/openvpn/options.h |=C2=A0 =C2=A04 --<br>
=C2=A0src/openvpn/socket.c=C2=A0 | 126 ++++++++++++++++++++++++++++++<wbr>+=
++++++++++++++-----<br>
=C2=A0src/openvpn/socket.h=C2=A0 |=C2=A0 12 +++++<br>
=C2=A04 files changed, 126 insertions(+), 77 deletions(-)<br>
<br>
diff --git a/src/openvpn/options.c b/src/openvpn/options.c<br>
index 8e5cdf7f..767cdaeb 100644<br>
--- a/src/openvpn/options.c<br>
+++ b/src/openvpn/options.c<br>
@@ -1033,67 +1033,6 @@ get_ip_addr(const char *ip_string, int msglevel, boo=
l *error)<br>
=C2=A0 =C2=A0 =C2=A0return ret;<br>
=C2=A0}<br>
<br>
-/* helper: parse a text string containing an IPv6 address + netbits<br>
- * in &quot;standard format&quot; (2001:dba::/32)<br>
- * &quot;/nn&quot; is optional, default to /64 if missing<br>
- *<br>
- * return true if parsing succeeded, modify *network and *netbits<br>
- */<br>
-bool<br>
-get_ipv6_addr( const char *prefix_str, struct in6_addr *network,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int *netbi=
ts, int msglevel)<br>
-{<br>
-=C2=A0 =C2=A0 char *sep, *endp;<br>
-=C2=A0 =C2=A0 int bits;<br>
-=C2=A0 =C2=A0 struct in6_addr t_network;<br>
-<br>
-=C2=A0 =C2=A0 sep =3D strchr( prefix_str, &#39;/&#39; );<br>
-=C2=A0 =C2=A0 if (sep =3D=3D NULL)<br>
-=C2=A0 =C2=A0 {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 bits =3D 64;<br>
-=C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 else<br>
-=C2=A0 =C2=A0 {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 bits =3D strtol( sep+1, &amp;endp, 10 );<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (*endp !=3D &#39;\0&#39; || bits &lt; 0 || =
bits &gt; 128)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(msglevel, &quot;IPv6 prefix =
&#39;%s&#39;: invalid &#39;/bits&#39; spec&quot;, prefix_str);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 /* temporary replace &#39;/&#39; in caller-provided string w=
ith &#39;\0&#39;, otherwise<br>
-=C2=A0 =C2=A0 =C2=A0* inet_pton() will refuse prefix string<br>
-=C2=A0 =C2=A0 =C2=A0* (alternative would be to strncpy() the prefix to tem=
porary buffer)<br>
-=C2=A0 =C2=A0 =C2=A0*/<br>
-<br>
-=C2=A0 =C2=A0 if (sep !=3D NULL)<br>
-=C2=A0 =C2=A0 {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 *sep =3D &#39;\0&#39;;<br>
-=C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 if (inet_pton( AF_INET6, prefix_str, &amp;t_network ) !=3D 1=
)<br>
-=C2=A0 =C2=A0 {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(msglevel, &quot;IPv6 prefix &#39;%s&#39;: =
invalid IPv6 address&quot;, prefix_str);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
-=C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 if (sep !=3D NULL)<br>
-=C2=A0 =C2=A0 {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 *sep =3D &#39;/&#39;;<br>
-=C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 if (netbits !=3D NULL)<br>
-=C2=A0 =C2=A0 {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 *netbits =3D bits;<br>
-=C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 if (network !=3D NULL)<br>
-=C2=A0 =C2=A0 {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 *network =3D t_network;<br>
-=C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 return true;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 /* parsing OK, values set */<br>
-}<br>
-<br>
=C2=A0/**<br>
=C2=A0 * Returns newly allocated string containing address part without &qu=
ot;/nn&quot;.<br>
=C2=A0 *<br>
diff --git a/src/openvpn/options.h b/src/openvpn/options.h<br>
index 035c6d15..d67c2785 100644<br>
--- a/src/openvpn/options.h<br>
+++ b/src/openvpn/options.h<br>
@@ -817,8 +817,4 @@ void options_string_import(struct options *options,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 unsigned int *option_types_found,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 struct env_set *es);<br>
<br>
-bool get_ipv6_addr( const char *prefix_str, struct in6_addr *network,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsi=
gned int *netbits, int msglevel );<br>
-<br>
-<br>
=C2=A0#endif /* ifndef OPTIONS_H */<br>
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c<br>
index 0fc91f21..4cadae23 100644<br>
--- a/src/openvpn/socket.c<br>
+++ b/src/openvpn/socket.c<br>
@@ -74,12 +74,102 @@ sf2gaf(const unsigned int getaddr_flags,<br>
=C2=A0/*<br>
=C2=A0 * Functions related to the translation of DNS names to IP addresses.=
<br>
=C2=A0 */<br>
+static int<br>
+get_addr_generic(sa_family_t af, unsigned int flags, const char *hostname,=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0void *networ=
k, unsigned int *netbits,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int resolve_=
retry_seconds, volatile int *signal_received,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int msglevel=
)<br>
+{<br>
+=C2=A0 =C2=A0 char *endp, *sep, *var_host;<br>
+=C2=A0 =C2=A0 uint8_t bits, max_bits;<br>
+=C2=A0 =C2=A0 struct addrinfo *ai;<br>
+=C2=A0 =C2=A0 int ret =3D -1;<br>
+<br>
+=C2=A0 =C2=A0 ASSERT(hostname);<br>
+<br>
+=C2=A0 =C2=A0 /* assign family specific default values */<br>
+=C2=A0 =C2=A0 switch (af)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 case AF_INET:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bits =3D 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 max_bits =3D sizeof(in_addr_t) *=
 8;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 case AF_INET6:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bits =3D 64;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 max_bits =3D sizeof(struct in6_a=
ddr) * 8;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 default:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ASSERT(0);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 /* we need to modify the hostname received as input, but we =
don&#39;t want to<br>
+=C2=A0 =C2=A0 =C2=A0* touch it directly as it might be a constant string.<=
br>
+=C2=A0 =C2=A0 =C2=A0*<br>
+=C2=A0 =C2=A0 =C2=A0* Therefore, we clone the string here and free it at t=
he end of the<br>
+=C2=A0 =C2=A0 =C2=A0* function */<br>
+=C2=A0 =C2=A0 var_host =3D strdup(hostname);<br>
+=C2=A0 =C2=A0 ASSERT(var_host);<br></blockquote><div><br></div><div>I thin=
k ASSERT should be used only to catch errors in coding logic,</div><div>not=
 for plausible runtime errors like this. Especially since this happens</div=
><div>on the server, no reason to terminate the process here.</div><div><br=
></div><div>Instead, log an error (M_NONFTAL|M_ERRNO will do nicely) and re=
turn -1</div><div>or goto out. The option parser will log a generic warning=
, but still useful=C2=A0</div><div>to log here using M_ERRNO for more speci=
fic info.</div><div><br></div><div>Alternatively one could use a buffer on =
the stack -- =C2=A0easy to do as good=C2=A0</div><div>old dns names are lim=
ited in size (255 octets max?) and the current option</div><div>parser also=
 limits the argument passed here to &lt; 255 bytes. But if we support</div>=
<div>internationalized domain names (currently we do not, do we?) and if th=
e line</div><div>length in option parser is ever increased, a much larger b=
uffer would be needed.</div><div>=C2=A0</div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex">
+<br>
+=C2=A0 =C2=A0 /* check if this hostname has a /bits suffix */<br>
+=C2=A0 =C2=A0 sep =3D strchr(var_host , &#39;/&#39;);<br>
+=C2=A0 =C2=A0 if (sep)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 bits =3D strtoul(sep + 1, &amp;endp, 10);</blo=
ckquote><div><br></div><div>There are a number of such type coercions in th=
e patch=C2=A0</div><div>(ulong to uint8_t, size_t =C2=A0to unit8_t etc.) th=
at some compilers (aka MSVC:)</div><div>may warn about, but I do not person=
ally care. All are safe and deliberate</div><div>except for the nitpicking =
below.</div><div><br></div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((*endp !=3D &#39;\0&#39;) || (bits &gt; ma=
x_bits))</blockquote><div><br></div><div>That (bits &gt; max_bits) check wi=
ll not catch many input errors, as the</div><div>input is =C2=A0already tru=
ncated to uint8_t. For example, /255 will be flagged</div><div>as an error,=
 but /256 will pass as 0.</div><div><br></div><div>Though its not possible =
to catch all input errors, keeping bits as unsigned</div><div>int (instead =
of uint8_t) may be better here. That&#39;ll =C2=A0also match netbits</div><=
div>in the function signature, return value of strtoul etc..</div><div><br>=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg(msglevel, &quot;IP prefix &#=
39;%s&#39;: invalid &#39;/bits&#39; spec&quot;, hostname);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* temporary truncate string at &#39;/&#39;. T=
his allows the IP<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* parsing routines to properly work. Wil=
l be restored later.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br></blockquote><div><br></div><div>T=
his comment is no longer required as there is no need to restore &#39;/&#39=
;</div><div>(also see below)</div><div>=C2=A0</div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 *sep =3D &#39;\0&#39;;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 ret =3D openvpn_getaddrinfo(flags &amp; ~GETADDR_HOST_ORDER,=
 var_host, NULL,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 resolve_retry_seconds, signal_received, af,=
 &amp;ai);<br>
+=C2=A0 =C2=A0 if ((ret =3D=3D 0) &amp;&amp; network)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct in6_addr *ip6;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 in_addr_t *ip4;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 switch (af)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case AF_INET:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ip4 =3D network;<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *ip4 =3D ((struct =
sockaddr_in *)ai-&gt;ai_addr)-&gt;sin_addr.s_<wbr>addr;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (flags &amp; GE=
TADDR_HOST_ORDER)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *ip4=
 =3D ntohl(*ip4);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 case AF_INET6:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ip6 =3D network;<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *ip6 =3D ((struct =
sockaddr_in6 *)ai-&gt;ai_addr)-&gt;sin6_addr;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 default:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ASSERT(0);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 freeaddrinfo(ai);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 if (netbits)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 *netbits =3D bits;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 /* restore &#39;/&#39; separator, if any */<br>
+=C2=A0 =C2=A0 if (sep)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 *sep =3D &#39;/&#39;;<br>
+=C2=A0 =C2=A0 }<br>
</blockquote><div><br></div><div>This restore is redundant as we are now wo=
rking on a copy which</div><div>is going to be freed two lines below.</div>=
<div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">+out:<br>
+=C2=A0 =C2=A0 free(var_host);<br>
+<br>
+=C2=A0 =C2=A0 return ret;<br>
+}<br></blockquote><div><br></div><div>...</div><div><br></div><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px sol=
id rgb(204,204,204);padding-left:1ex"><span style=3D"font-size:12.8px">+/**=
<br></span><span style=3D"font-size:12.8px">+ * Translate an IPv4 addr or h=
ostname from string form to in_addr_t<br></span><span style=3D"font-size:12=
.8px">+ *<br></span><span style=3D"font-size:12.8px">+ * In case of resolve=
 error, it will try again for<br></span><span style=3D"font-size:12.8px">+ =
* resolve_retry_seconds seconds.<br></span><span style=3D"font-size:12.8px"=
>+ */<br></span></blockquote><div><br></div><div>More docs is nice, but thi=
s is confusing. It will retry for (resolve_retry_seconds / 5)</div><div>tim=
es will be more correct. Its as if someone thought if the caller says try f=
or 15</div><div>seconds its ok to try three times and wait 5 seconds in bet=
ween. In reality that</div><div>could take 90 seconds or even more in some =
cases as getaddrinfo may not return</div><div>for 30 seconds or more. But t=
hat&#39;s a separate issue.</div><div><br></div><div>And, it will try only =
once if flags contain GETADDR_TRY_ONCE<br></div><div><br></div><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px sol=
id rgb(204,204,204);padding-left:1ex"><span style=3D"font-size:12.8px"></sp=
an><span style=3D"font-size:12.8px">=C2=A0in_addr_t getaddr(unsigned int fl=
ags,<br></span><span style=3D"font-size:12.8px">=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *hostname,<br></span><=
span style=3D"font-size:12.8px">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0int resolve_retry_seconds,<br></span><span style=
=3D"font-size:12.8px">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0bool *succeeded,<br></span><span style=3D"font-size:12.8px=
">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vola=
tile int *signal_received);</span></blockquote><div>=C2=A0</div><div>The re=
st looks good though I&#39;ve not tested it.</div><div><br></div><div>Selva=
</div></div></div></div></div>

--94eb2c0e44e000bec4055f6153d4--

