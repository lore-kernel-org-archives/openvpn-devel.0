References: <20171202085438.2393-1-a@...2181...>
 <CAKuzo_hgmFaE8ygqJ18YfP+WL+gaVh8yjnNCU0P0zQ=meOPeTg@...278...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <e0935209-c578-aa2c-a236-e1fee8452345@...2181...>
Date: Sun, 3 Dec 2017 10:25:04 +0800
MIME-Version: 1.0
In-Reply-To: <CAKuzo_hgmFaE8ygqJ18YfP+WL+gaVh8yjnNCU0P0zQ=meOPeTg@...278...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="T2OjoaxKFaLn4Bj89eD2qJvpCUwbU2bUG"
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
To: Selva Nair <selva.nair@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--T2OjoaxKFaLn4Bj89eD2qJvpCUwbU2bUG
Content-Type: multipart/mixed; boundary="LXI5qb3AmrNBuAvUFUN0KreRdiePEPAoF";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: Selva Nair <selva.nair@...277...>
Cc: "openvpn-devel@lists.sourceforge.net"
 <openvpn-devel@lists.sourceforge.net>
Message-ID: <e0935209-c578-aa2c-a236-e1fee8452345@...2181...>
Subject: Re: [Openvpn-devel] [PATCH v2] ifconfig-ipv6(-push): allow using
 hostnames
References: <20171202085438.2393-1-a@...2181...>
 <CAKuzo_hgmFaE8ygqJ18YfP+WL+gaVh8yjnNCU0P0zQ=meOPeTg@...278...>
In-Reply-To: <CAKuzo_hgmFaE8ygqJ18YfP+WL+gaVh8yjnNCU0P0zQ=meOPeTg@...278...>

--LXI5qb3AmrNBuAvUFUN0KreRdiePEPAoF
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On 03/12/17 04:27, Selva Nair wrote:
> Hi,
>=20
> On Sat, Dec 2, 2017 at 3:54 AM, Antonio Quartulli <a@...2181...> wrote:
>=20
>> Similarly to ifconfig(-push), its IPv6 counterpart is now able to
>> accept hostnames as well instead of IP addresses in numeric form.
>>
>=20
> If dns names currently work for ifconfig-push (I didn't know),  makes sen=
se
> to
> support it for ipv6 as well.
>=20
> But getaddrinfo can take a long time to timeout, so we are adding another
> potentially blocking call on the server. Should not be an issue on a well
> administered server, but just saying...

Yeah, I think this the 'drawback' that the admin has to consider if you
want hostnames in the config.


>=20
> Otherwise looks good except for a couple of issues as below:
>=20
>=20
>> Basically this means that the user is now allowed to specify
>> something like this:
>>
>> ifconfig-ipv6-push my.hostname.cx/64
>>
>> This is exactly the same behaviour that we already have with
>> ifconfig(-push).
>>
>> The generic code introduced in this patch will be later used to
>> implement the /bits parsing support for IPv4 addresses.
>>
>> Trac: #808
>> Signed-off-by: Antonio Quartulli <a@...2181...>
>> ---
>>
>> v2:
>> - rebased on top of master
>> - style adapted to new CodingStyle
>>
>>  src/openvpn/options.c |  61 ------------------------
>>  src/openvpn/options.h |   4 --
>>  src/openvpn/socket.c  | 126 ++++++++++++++++++++++++++++++
>> +++++++++++++++-----
>>  src/openvpn/socket.h  |  12 +++++
>>  4 files changed, 126 insertions(+), 77 deletions(-)
>>
>> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
>> index 8e5cdf7f..767cdaeb 100644
>> --- a/src/openvpn/options.c
>> +++ b/src/openvpn/options.c
>> @@ -1033,67 +1033,6 @@ get_ip_addr(const char *ip_string, int msglevel,
>> bool *error)
>>      return ret;
>>  }
>>
>> -/* helper: parse a text string containing an IPv6 address + netbits
>> - * in "standard format" (2001:dba::/32)
>> - * "/nn" is optional, default to /64 if missing
>> - *
>> - * return true if parsing succeeded, modify *network and *netbits
>> - */
>> -bool
>> -get_ipv6_addr( const char *prefix_str, struct in6_addr *network,
>> -               unsigned int *netbits, int msglevel)
>> -{
>> -    char *sep, *endp;
>> -    int bits;
>> -    struct in6_addr t_network;
>> -
>> -    sep =3D strchr( prefix_str, '/' );
>> -    if (sep =3D=3D NULL)
>> -    {
>> -        bits =3D 64;
>> -    }
>> -    else
>> -    {
>> -        bits =3D strtol( sep+1, &endp, 10 );
>> -        if (*endp !=3D '\0' || bits < 0 || bits > 128)
>> -        {
>> -            msg(msglevel, "IPv6 prefix '%s': invalid '/bits' spec",
>> prefix_str);
>> -            return false;
>> -        }
>> -    }
>> -
>> -    /* temporary replace '/' in caller-provided string with '\0',
>> otherwise
>> -     * inet_pton() will refuse prefix string
>> -     * (alternative would be to strncpy() the prefix to temporary buffe=
r)
>> -     */
>> -
>> -    if (sep !=3D NULL)
>> -    {
>> -        *sep =3D '\0';
>> -    }
>> -
>> -    if (inet_pton( AF_INET6, prefix_str, &t_network ) !=3D 1)
>> -    {
>> -        msg(msglevel, "IPv6 prefix '%s': invalid IPv6 address",
>> prefix_str);
>> -        return false;
>> -    }
>> -
>> -    if (sep !=3D NULL)
>> -    {
>> -        *sep =3D '/';
>> -    }
>> -
>> -    if (netbits !=3D NULL)
>> -    {
>> -        *netbits =3D bits;
>> -    }
>> -    if (network !=3D NULL)
>> -    {
>> -        *network =3D t_network;
>> -    }
>> -    return true;                /* parsing OK, values set */
>> -}
>> -
>>  /**
>>   * Returns newly allocated string containing address part without "/nn".
>>   *
>> diff --git a/src/openvpn/options.h b/src/openvpn/options.h
>> index 035c6d15..d67c2785 100644
>> --- a/src/openvpn/options.h
>> +++ b/src/openvpn/options.h
>> @@ -817,8 +817,4 @@ void options_string_import(struct options *options,
>>                             unsigned int *option_types_found,
>>                             struct env_set *es);
>>
>> -bool get_ipv6_addr( const char *prefix_str, struct in6_addr *network,
>> -                    unsigned int *netbits, int msglevel );
>> -
>> -
>>  #endif /* ifndef OPTIONS_H */
>> diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
>> index 0fc91f21..4cadae23 100644
>> --- a/src/openvpn/socket.c
>> +++ b/src/openvpn/socket.c
>> @@ -74,12 +74,102 @@ sf2gaf(const unsigned int getaddr_flags,
>>  /*
>>   * Functions related to the translation of DNS names to IP addresses.
>>   */
>> +static int
>> +get_addr_generic(sa_family_t af, unsigned int flags, const char *hostna=
me,
>> +                 void *network, unsigned int *netbits,
>> +                 int resolve_retry_seconds, volatile int *signal_receiv=
ed,
>> +                 int msglevel)
>> +{
>> +    char *endp, *sep, *var_host;
>> +    uint8_t bits, max_bits;
>> +    struct addrinfo *ai;
>> +    int ret =3D -1;
>> +
>> +    ASSERT(hostname);
>> +
>> +    /* assign family specific default values */
>> +    switch (af)
>> +    {
>> +        case AF_INET:
>> +            bits =3D 0;
>> +            max_bits =3D sizeof(in_addr_t) * 8;
>> +            break;
>> +        case AF_INET6:
>> +            bits =3D 64;
>> +            max_bits =3D sizeof(struct in6_addr) * 8;
>> +            break;
>> +        default:
>> +            ASSERT(0);
>> +    }
>> +
>> +    /* we need to modify the hostname received as input, but we don't
>> want to
>> +     * touch it directly as it might be a constant string.
>> +     *
>> +     * Therefore, we clone the string here and free it at the end of the
>> +     * function */
>> +    var_host =3D strdup(hostname);
>> +    ASSERT(var_host);
>>
>=20
> I think ASSERT should be used only to catch errors in coding logic,
> not for plausible runtime errors like this. Especially since this happens
> on the server, no reason to terminate the process here.
>=20
> Instead, log an error (M_NONFTAL|M_ERRNO will do nicely) and return -1
> or goto out. The option parser will log a generic warning, but still usef=
ul
> to log here using M_ERRNO for more specific info.
>=20

I agree. I am also not a big fan of ASSERT(). I think I had copy/pasted
this chunk of code from somewhere else (and consider that this patch is
quite old even though I have re-sent it now).

I will get rid of the ASSERTs.

> Alternatively one could use a buffer on the stack --  easy to do as good
> old dns names are limited in size (255 octets max?) and the current option
> parser also limits the argument passed here to < 255 bytes. But if we
> support
> internationalized domain names (currently we do not, do we?) and if the l=
ine
> length in option parser is ever increased, a much larger buffer would be
> needed.

Are you sure we have a limit of 255 octects? I am not so sure. Anyway,
this is not extremely important for now.

>=20
>=20
>> +
>> +    /* check if this hostname has a /bits suffix */
>> +    sep =3D strchr(var_host , '/');
>> +    if (sep)
>> +    {
>> +        bits =3D strtoul(sep + 1, &endp, 10);
>=20
>=20
> There are a number of such type coercions in the patch
> (ulong to uint8_t, size_t  to unit8_t etc.) that some compilers (aka MSVC=
:)
> may warn about, but I do not personally care. All are safe and deliberate
> except for the nitpicking below.
>=20
> +        if ((*endp !=3D '\0') || (bits > max_bits))
>=20
>=20
> That (bits > max_bits) check will not catch many input errors, as the
> input is  already truncated to uint8_t. For example, /255 will be flagged
> as an error, but /256 will pass as 0.
>=20

These are probably all copy/paste from other parts of the code. So the
logic here is also used in other parts of the code. If we believe this
is not the proper way to handle these cases, I'd suggest to take a note
and fix these behaviors with a dedicated patch.

> Though its not possible to catch all input errors, keeping bits as unsign=
ed
> int (instead of uint8_t) may be better here. That'll  also match netbits
> in the function signature, return value of strtoul etc..
>=20
> +        {
>> +            msg(msglevel, "IP prefix '%s': invalid '/bits' spec",
>> hostname);
>> +            goto out;
>> +        }
>> +        /* temporary truncate string at '/'. This allows the IP
>> +         * parsing routines to properly work. Will be restored later.
>> +         */
>>
>=20
> This comment is no longer required as there is no need to restore '/'
> (also see below)
>=20
>=20
>> +        *sep =3D '\0';
>> +    }
>> +
>> +    ret =3D openvpn_getaddrinfo(flags & ~GETADDR_HOST_ORDER, var_host, =
NULL,
>> +                              resolve_retry_seconds, signal_received, a=
f,
>> &ai);
>> +    if ((ret =3D=3D 0) && network)
>> +    {
>> +        struct in6_addr *ip6;
>> +        in_addr_t *ip4;
>> +
>> +        switch (af)
>> +        {
>> +            case AF_INET:
>> +                ip4 =3D network;
>> +                *ip4 =3D ((struct sockaddr_in *)ai->ai_addr)->sin_addr.=
s_
>> addr;
>> +
>> +                if (flags & GETADDR_HOST_ORDER)
>> +                {
>> +                    *ip4 =3D ntohl(*ip4);
>> +                }
>> +                break;
>> +            case AF_INET6:
>> +                ip6 =3D network;
>> +                *ip6 =3D ((struct sockaddr_in6 *)ai->ai_addr)->sin6_add=
r;
>> +                break;
>> +            default:
>> +                ASSERT(0);
>> +        }
>> +        freeaddrinfo(ai);
>> +    }
>> +
>> +    if (netbits)
>> +    {
>> +        *netbits =3D bits;
>> +    }
>> +
>> +    /* restore '/' separator, if any */
>> +    if (sep)
>> +    {
>> +        *sep =3D '/';
>> +    }
>>
>=20
> This restore is redundant as we are now working on a copy which
> is going to be freed two lines below.

Absolutely right. I thought I had removed this though....thanks for
catching it!


>=20
>=20
>> +out:
>> +    free(var_host);
>> +
>> +    return ret;
>> +}
>>
>=20
> ...
>=20
> +/**
>> + * Translate an IPv4 addr or hostname from string form to in_addr_t
>> + *
>> + * In case of resolve error, it will try again for
>> + * resolve_retry_seconds seconds.
>> + */
>>
>=20
> More docs is nice, but this is confusing. It will retry for
> (resolve_retry_seconds / 5)
> times will be more correct. Its as if someone thought if the caller says
> try for 15
> seconds its ok to try three times and wait 5 seconds in between. In reali=
ty
> that
> could take 90 seconds or even more in some cases as getaddrinfo may not
> return
> for 30 seconds or more. But that's a separate issue.
>=20
> And, it will try only once if flags contain GETADDR_TRY_ONCE
>=20
>  in_addr_t getaddr(unsigned int flags,
>>                    const char *hostname,
>>                    int resolve_retry_seconds,
>>                    bool *succeeded,
>>                    volatile int *signal_received);
>=20
>=20
> The rest looks good though I've not tested it.

Thanks a lot for your review!

I'll address the issues you raised and send v3.

Cheers,



--=20
Antonio Quartulli


--LXI5qb3AmrNBuAvUFUN0KreRdiePEPAoF--

--T2OjoaxKFaLn4Bj89eD2qJvpCUwbU2bUG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAlojYIAACgkQB6U8WA7y
zXQgzw/+LuPouUs6e+u3nfjUMMIAMLUBkvY4Pzn5j3cp2wPW2rO+YiDBZSJEvbYC
uosCjbzCNP7X/hklWNB/gBS9L99chEwWgrSlmp39Rv72IaLcsR9fG5aUhmqzEL+5
Xx5P8rl/Cp2pDsURf/X69CO58CsdWqQWgFtRkRtO/GHWwUP6hN6xFuk4+xUIaUcV
SRnbbAY6WAQ7r8m+nDMzkp0ZqzeP2U/hUEAQI7sfcuHo2RyicxxxX+7o+dsCntBO
cRtTqJIId1gzGgbEsHvAj0pCe9eFwJKp3hDSCSwf6KqwiSZ6gm53+m99QUS3VAfy
ieyVCP37DIg95tOpkbmMzMubs0q21Ug2ATbXPGK26wqTozHEjQfT90c29ZfhDSdb
joq/V+MG9DJIN4BJDHiqiNlEPtNXI1E7lwwyYsoub163Pily7izy+tmA2Px0OUCg
6h7QF9nQ0vYpLjQMHGivb/vmS5LQQ5ZEhyJ/srLjn4LNu3bDSxO9s36AqQtb/E8A
T4oyojFlH2hXNd3xXyGw5WsgS1YvSiKPES7vhYLp3leJG0pScey/THof6uceRmh4
EchOt7bkILp6feNmcm/9jVPDeIGuJCVMO/1CwiE0Mmuzce2slAnAqoNYetyXRFyv
quArIoMe2vb4GDCZXBGOuzJAh4Cg3oRThsbEuNoKji8FbP/ziw0=
=d9Kg
-----END PGP SIGNATURE-----

--T2OjoaxKFaLn4Bj89eD2qJvpCUwbU2bUG--

