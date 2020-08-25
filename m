References: <20200824221559.9553-1-themiron@...2010...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <de9db75e-98de-6a56-6f3c-6ba66f475cca@...1227...>
Date: Tue, 25 Aug 2020 11:10:13 +0200
MIME-Version: 1.0
In-Reply-To: <20200824221559.9553-1-themiron@...2010...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="BuMv24cAhyp5d5JEUza4UDTERnV95gOs9"
Subject: Re: [Openvpn-devel] [PATCH] Add DNS SRV host discovery support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Vladislav Grishenko <themiron@...2010...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--BuMv24cAhyp5d5JEUza4UDTERnV95gOs9
Content-Type: multipart/mixed; boundary="hdMTJIXsB4r0RgtiqqwBfI2NhWsf8F4f9"

--hdMTJIXsB4r0RgtiqqwBfI2NhWsf8F4f9
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 25.08.20 um 00:15 schrieb Vladislav Grishenko:
> DNS SRV (rfc2782) support allows to use several OpenVPN servers for a sin=
gle
> domain w/o explicit profile enumerating, to move services from host to ho=
st
> with little fuss, and to designate some hosts as primary servers for a se=
rvice
> and others as backups.
> OpenVPN client ask for a specific service/protocol for a specific domain =
and
> get back the names & ports of available servers to connect to, ordered by
> priority and relative weight. Note, implemented server selection is inten=
ded
> to express static information such as "this server has a faster CPU than =
that
> one" or "this server has a much better network connection than that one" =
at
> the moment client asks for a records.
> Feature has been asked several times already, can be useful in case of fo=
r huge
> ammounts of client & servers deployed.=20

Hu? You are talking here about loading balancing by a weight, right?

> For example, instead of multiple remotes in profile:
>     remote server.example.com 1194 udp
>     remote server1.example.com 1195 udp
>     remote server2.example.org 1196 udp
>     remote server.example.com 443 tcp
>     remote server1.example.tld 8443 tcp
>=20
> Now it's possible to specify just static domain(s) and enable discovery:
>     remote server.example.com 1194 udp
>     remote server.example.com 443 tcp
>     remote-discovery
>=20
> When discovery is enabled,=20

I wonder if we should enable this by default. But this still fixes the
order of UDP and TCP in the config. Ideally I want just to say:

remote vpn.mycorp.com and then it should resolve to all UDP+TCP options.
And it should be possible to point the client to try
udp/1194/primary.vpn.corp.com and then 443/tcp/primary.vpn.corp.com and
only after that try 1194/backup.vpn.corp.com. With this syntax it looks
like that is not possible.


> OpenVPN will first try to resolve
> _openvpn._udp.server.example.com SRV records and use resolved targets (see
> example below) as servers for the subsequent connection attempts. If ther=
e's
> no records or resolve error, OpenVPN will fallback to direct connection
> using specified server.example.com host and 1194 port. Next connection
> attempt will be done with next configures connection/remote entry - using
> _openvpn._tcp.server.example.com records (if any) and server.example.com:=
443
> as last resort.
>=20
> DNS zone can look like below (arbitrary prio & weight values):

What/how are prio and weight used?

>     _openvpn._udp.server.example.com IN SRV 10 70 1194 server.example.com
>     _openvpn._udp.server.example.com IN SRV 10 30 1195 server1.example.com
>     _openvpn._udp.server.example.com IN SRV 20 0 1196 server2.example.org
>     _openvpn._tcp.server.example.com IN SRV 10 10 443 server.example.com
>     _openvpn._tcp.server.example.com IN SRV 10 200 443 server.example.com
>=20
> Currently only "openvpn" service is supported, usage of per-connection
> service names is up to syntax decision (either intead of fallback port, or
                                                 ^^^^ typo

> as remote-discovery argument, etc), almost all the required mechanics
> is implemented for that.

Almost all? What is missing?

>=20
> References:
>  https://tools.ietf.org/html/rfc2782
>  https://en.wikipedia.org/wiki/SRV_record
>  https://sourceforge.net/p/openvpn/mailman/message/34364911/
>  https://forums.openvpn.net/viewtopic.php?f=3D10&t=3D13660
>=20
> Signed-off-by: Vladislav Grishenko <themiron@...2010...>
> ---
>  configure.ac                        |   2 +-
>  doc/man-sections/client-options.rst |  26 ++
>  src/openvpn/Makefile.am             |   2 +-
>  src/openvpn/buffer.h                |   5 -
>  src/openvpn/init.c                  |   9 +-
>  src/openvpn/manage.c                |   2 +-
>  src/openvpn/openvpn.vcxproj         |   8 +-
>  src/openvpn/options.c               |  11 +
>  src/openvpn/options.h               |   1 +
>  src/openvpn/ps.c                    |   2 +-
>  src/openvpn/socket.c                | 530 ++++++++++++++++++++++++++--
>  src/openvpn/socket.h                |  15 +
>  src/openvpn/syshead.h               |   5 +
>  13 files changed, 580 insertions(+), 38 deletions(-)
>=20
> diff --git a/configure.ac b/configure.ac
> index f8279924..67251bed 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -477,7 +477,7 @@ SOCKET_INCLUDES=3D"
>  "
>=20=20
>  AC_CHECK_HEADERS(
> -	[net/if.h netinet/ip.h resolv.h sys/un.h net/if_utun.h sys/kern_control=
.h],
> +	[net/if.h netinet/ip.h arpa/nameser.h resolv.h sys/un.h net/if_utun.h s=
ys/kern_control.h],
>  	,
>  	,
>  	[[${SOCKET_INCLUDES}]]
> diff --git a/doc/man-sections/client-options.rst b/doc/man-sections/clien=
t-options.rst
> index ec1e3b11..53e6580e 100644
> --- a/doc/man-sections/client-options.rst
> +++ b/doc/man-sections/client-options.rst
> @@ -299,6 +299,32 @@ configuration.
>    specification (4/6 suffix), OpenVPN will try both IPv4 and IPv6
>    addresses, in the order getaddrinfo() returns them.
>=20=20
> +--remote-discovery

discovery is a bit ambigious. Maybe rather use --remote-service-discovery?

> +  Perform rfc2782 remote host discovery using specified ``host`` and
> +  ``proto`` values.


Spelling, RFC 2782. But RFC numbers are not user friendly when used
alone. I would at least add DNS SRV somewhere in there.

> +  OpenVPN will try to resolve `` _openvpn._proto.host`` name via DNS
> +  and use returned DNS SRV target and port records as OpenVPN servers
> +  addresses in the order specified by Priority and Weight of that
> +  records. If one record resolves to multiple IP addresses, OpenVPN
> +  will try them in the order that the system getaddrinfo() presents
> +  them. If discovery is failed, usual ``host`` and ``port`` connection
> +  will be tried as a fallback.
> +
> +  Example:
> +  ::
> +
> +     remote example.net 1194 udp
> +     remote example.net 443 tcp
> +     remote-discovery
> +
> +  DNS zone:
> +  ::
> +
> +     _openvpn._udp.example.net IN SRV 10 60 1194 server1.example.net
> +     _openvpn._udp.example.net IN SRV 10 40 1194 server2.example.net
> +     _openvpn._udp.example.net IN SRV 20  0 1194 server3.example.net
> +     _openvpn._tcp.example.net IN SRV 10  0  443 server4.example.net
> +


The man page is completely missing how the weight/priority is
interpreted by OpenVPN.


> +++ b/src/openvpn/options.c
> @@ -123,6 +123,7 @@ static const char usage_message[] =3D
>      "--remote host [port] : Remote host name or ip address.\n"
>      "--remote-random : If multiple --remote options specified, choose on=
e randomly.\n"
>      "--remote-random-hostname : Add a random string to remote DNS name.\=
n"
> +    "--remote-discovery : Perform rfc2782 remote host discovery.\n"

See other comment.


>      else if (streq(p[0], "setenv") && p[1] && !p[3])
>      {
>          VERIFY_PERMISSION(OPT_P_GENERAL);
> @@ -6679,6 +6686,10 @@ add_option(struct options *options,
>          {
>              options->sockflags |=3D SF_HOST_RANDOMIZE;
>          }
> +        if (streq(p[1], "REMOTE_DISCOVERY"))
> +        {
> +            options->ce.remote_discovery =3D true;
> +        }

I don't think we should add this. We already have ignore-unknown-options
and setenv opt to write backwards compatible configs.


> @@ -416,7 +424,7 @@ do_preresolve(struct context *c)
>          if (ce->bind_local)
>          {
>              flags |=3D GETADDR_PASSIVE;
> -            flags &=3D ~GETADDR_RANDOMIZE;
> +            flags &=3D ~(GETADDR_RANDOMIZE|GETADDR_DISCOVERY);
>              status =3D do_preresolve_host(c, ce->local, ce->local_port, =
ce->af, flags);


Hm does this do a DNS SRV discovery for the local bind address? That
seems odd.

>              if (status !=3D 0)
>              {
> @@ -432,6 +440,363 @@ err:
>      throw_signal_soft(SIGHUP, "Preresolving failed");
>  }
>=20=20
> +/* Struct to hold resolved srv records */
> +struct srvinfo
> +{
> +    const char *hostname;
> +    const char *servname;
> +    unsigned short prio;
> +    unsigned short weight;
> +    int order;
> +    struct srvinfo *next;
> +};



> +static int
> +rfc2782_cmp(const void *a, const void *b)

It does compare srvinfo structs and should be named accordingly. Also
please add a doxygen comment, say how it compares them.

> +{
> +    const struct srvinfo *ae =3D *(struct srvinfo **)a;
> +    const struct srvinfo *be =3D *(struct srvinfo **)b;
> +
> +    /* lowest-numbered priority first */
> +    if (ae->prio !=3D be->prio)
> +    {
> +        return ae->prio < be->prio ? -1 : 1;
> +    }
> +
> +    /* zero-weighted first */
> +    if ((ae->weight =3D=3D 0 && be->weight)
> +        || (ae->weight && be->weight =3D=3D 0))
> +    {
> +        return ae->weight < be->weight ? -1 : 1;
> +    }
> +
> +    /* keep received order */
> +    return ae->order < be->order ? -1 : 1;
> +}


> +static struct srvinfo *
> +rfc2782_sort(struct srvinfo *list, int count)
> +{

Doxygen, sorting by what etc.

> +    struct srvinfo head, *tail, **sorted;
> +    struct gc_arena gc =3D gc_new();
> +
> +    ASSERT(list);
> +    ASSERT(count);
> +
> +    head.next =3D NULL;
> +    tail =3D &head;
> +
> +    /* sort records by priority and zero weight */
> +    ALLOC_ARRAY_CLEAR_GC(sorted, struct srvinfo *, count, &gc);
> +    for (struct srvinfo *e =3D list; e; e =3D e->next)
> +    {
> +        ASSERT(e->order < count);
> +        sorted[e->order] =3D e;
> +    }
> +    qsort(sorted, count, sizeof(sorted[0]), rfc2782_cmp);
> +
> +    /* apply weighted selection mechanism */
> +    for (int i =3D 0; i < count;)
> +    {
> +        struct srvinfo unordered;
> +
> +        /* compute the sum of the weights of records of the same
> +         * priority and put them in the unordered list */
> +        unordered.prio =3D sorted[i]->prio;
> +        unordered.weight =3D 0;
> +        unordered.next =3D NULL;

unordered.weight, unordered.prio seems just used as variables in this
algorithm.

> +        for (struct srvinfo *prev =3D &unordered; i < count && sorted[i]=
->prio =3D=3D unordered.prio; i++)
> +        {
> +            struct srvinfo *e =3D sorted[i];
> +
> +            unordered.weight +=3D e->weight;
> +
> +            /* add entry to the tail of unordered list */
> +            e->next =3D NULL;
> +            prev->next =3D e, prev =3D e;
> +        }
> +
> +        /* process the unordered list */
> +        while (unordered.next)
> +        {
> +            /* choose a uniform random number between 0 and the sum
> +             * computed (inclusive) */
> +            int weight =3D unordered.weight ? get_random() % unordered.w=
eight : 0;

This line is hard to parse.

> +
> +            /* select the entries whose running sum value is the first
> +             * in the selected order which is greater than or equal
> +             * to the random number selected */
> +            for (struct srvinfo *e =3D unordered.next, *prev =3D &unorde=
red; e; prev =3D e, e =3D e->next)
> +            {
> +                /* selected entry is the next one to be contacted */
> +                if (e->weight >=3D weight)
> +                {
> +                    unordered.weight -=3D e->weight;
> +
> +                    /* move entry to the ordered list */
> +                    prev->next =3D e->next;
> +                    e->next =3D NULL;
> +                    tail->next =3D e, tail =3D e;
> +
> +                    /* in the presence of records containing weights gre=
ater
> +                     * than 0, records with weight 0 should have a very =
small
> +                     * chance of being selected, so skip them all after =
the
> +                     * last weighted */
> +                    if (unordered.weight =3D=3D 0 && e->weight)
> +                    {
> +                        unordered.next =3D NULL;
> +                    }
> +                    break;

This behaviour needs to be documented in the man page.



> +/*
> + * Translated hostname, service and protocol into struct srvinfo.
> + * Multiple records are ordered per rfc2782.
> + */
> +static int
> +openvpn_getsrvinfo(unsigned int flags,
> +                   const char *hostname,
> +                   const char *servname,
> +                   struct srvinfo **res,
> +                   struct gc_arena *gc)
> +{
> +    struct srvinfo *list =3D NULL;
> +#ifdef _WIN32
> +    char qname[DNS_MAX_NAME_BUFFER_LENGTH];
> +#else
> +    char qname[NS_MAXDNAME];
> +#endif
> +    int status;
> +    int count =3D 0;
> +
> +    ASSERT(res);
> +
> +    ASSERT(hostname && servname);
> +    ASSERT(!(flags & GETADDR_HOST_ORDER));
> +
> +    if (!openvpn_snprintf(qname, sizeof(qname), "_%s._%s.%s", servname,
> +                          (flags & GETADDR_DATAGRAM) ? "udp" : "tcp", ho=
stname))
> +    {
> +        return EAI_MEMORY;
> +    }
> +
> +#ifdef _WIN32
> +    PDNS_RECORD pDnsRecord;
> +    DNS_STATUS DnsStatus =3D DnsQuery(qname, DNS_TYPE_SRV, DNS_QUERY_STA=
NDARD, NULL, &pDnsRecord, NULL);
> +    dmsg(D_SOCKET_DEBUG, "DNSQUERY type=3D%d dname=3D%s result=3D%d",
> +         DNS_TYPE_SRV, qname, DnsStatus);
> +    switch (DnsStatus)
> +    {
> +        case ERROR_SUCCESS:
> +            break;
> +
> +        case DNS_ERROR_RCODE_NAME_ERROR:
> +            return EAI_NONAME; /* HOST_NOT_FOUND */
> +
> +        case DNS_INFO_NO_RECORDS:
> +            return EAI_NODATA; /* NO_DATA */
> +
> +        case DNS_ERROR_NO_DNS_SERVERS:
> +        case DNS_ERROR_RCODE_FORMAT_ERROR:
> +        case DNS_ERROR_RCODE_NOT_IMPLEMENTED:
> +        case DNS_ERROR_RCODE_REFUSED:
> +            return EAI_FAIL; /* NO_RECOVERY */
> +
> +        case ERROR_TIMEOUT:
> +        case DNS_ERROR_RCODE_SERVER_FAILURE:
> +        case DNS_ERROR_TRY_AGAIN_LATER:
> +            return EAI_AGAIN; /* TRY_AGAIN */
> +
> +        default:
> +            return EAI_NODATA;
> +    }
> +
> +    for (PDNS_RECORD rr =3D pDnsRecord; rr; rr =3D rr->pNext)
> +    {
> +        if (rr->wType =3D=3D DNS_TYPE_SRV)
> +        {
> +            PDNS_SRV_DATA rdata =3D &rr->Data.Srv;
> +
> +            if (rr->wDataLength >=3D sizeof(DNS_SRV_DATA) && *rdata->pNa=
meTarget)
> +            {
> +                char port[sizeof("65535")];
> +                openvpn_snprintf(port, sizeof(port), "%u", rdata->wPort);
> +
> +                struct srvinfo *e;
> +                ALLOC_OBJ_CLEAR_GC(e, struct srvinfo, gc);
> +                e->hostname =3D string_alloc(rdata->pNameTarget, gc);
> +                e->servname =3D string_alloc(port, gc);
> +                e->prio =3D rdata->wPriority;
> +                e->weight =3D rdata->wWeight;
> +                e->order =3D count++;
> +                e->next =3D list, list =3D e;
> +            }
> +        }
> +    }
> +    DnsRecordListFree(pDnsRecord, DnsFreeParsedMessageFields);
> +#else
> +    unsigned char answer[NS_MAXMSG];
> +    int n =3D res_query(qname, ns_c_in, ns_t_srv, answer, NS_MAXMSG);
> +    dmsg(D_SOCKET_DEBUG, "RES_QUERY class=3D%d type=3D%d dname=3D%s resu=
lt=3D%d",
> +         ns_c_in, ns_t_srv, qname, n);
> +    if (n < 0)
> +    {
> +        switch (h_errno)
> +        {
> +            case HOST_NOT_FOUND:
> +                return EAI_NONAME;
> +
> +            case NO_ADDRESS:
> +#if NO_ADDRESS !=3D NO_DATA
> +            case NO_DATA:
> +#endif
> +                return EAI_NODATA;
> +
> +            case NO_RECOVERY:
> +                return EAI_FAIL;
> +
> +            case TRY_AGAIN:
> +                return EAI_AGAIN;
> +        }
> +        return EAI_SYSTEM;
> +    }
> +
> +    ns_msg msg;
> +    if (ns_initparse(answer, n, &msg) < 0)
> +    {
> +        return EAI_FAIL;
> +    }
> +
> +    for (int i =3D 0; i < ns_msg_count(msg, ns_s_an); i++)
> +    {
> +        ns_rr rr;
> +
> +        if (ns_parserr(&msg, ns_s_an, i, &rr) =3D=3D 0 && ns_rr_type(rr)=
 =3D=3D ns_t_srv)
> +        {
> +            const unsigned char *rdata =3D ns_rr_rdata(rr);
> +
> +            if (ns_rr_rdlen(rr) > 6
> +                && dn_expand(ns_msg_base(msg), ns_msg_end(msg),
> +                             rdata + 6, qname, sizeof(qname)) > 0 && *qn=
ame)
> +            {
> +                char port[sizeof("65535")];
> +                openvpn_snprintf(port, sizeof(port), "%u", ns_get16(rdat=
a + 4));
> +
> +                struct srvinfo *e;
> +                ALLOC_OBJ_CLEAR_GC(e, struct srvinfo, gc);
> +                e->hostname =3D string_alloc(qname, gc);
> +                e->servname =3D string_alloc(port, gc);
> +                e->prio =3D ns_get16(rdata);
> +                e->weight =3D ns_get16(rdata + 2);
> +                e->order =3D count++;
> +                e->next =3D list, list =3D e;
> +            }
> +        }
> +    }
> +#endif

Can we have the platform specifc part in an extra function? This ifdef
makes the function hard to read.



> +/*=20
> + * Struct to hold chainable copy of struct addinfo.
> + * Must be binary compatible (except size) with original.
> + */

What is binary compatible expect size? The first member needs to be a
addrinfo since this might be cast to addrinfo? And if yes, why are we
doing a hack like that?

> +struct addrinfo_chained
> +{
> +    struct addrinfo ai;
> +    struct openvpn_sockaddr addr;
> +    char canonname[0];
> +};
> +
> +/*
> + * System getaddrinfo() returns one or more addrinfo structures.
> + * openvpn_getaddinfo() chains them into one in case DNS SRV
> + * resolve is performed, but unfortunately it can't be safely done
> + * (freed) with musl libc, refer
> + * https://git.musl-libc.org/cgit/musl/commit/?id=3Dd1395c43c019aec6b855=
cf3c656bf47c8a719e7f
> + * Use own copy of each addrinfo to workaround this and possibly
> + * other getaddrinfo()/freeaddrinfo() implementations.
> + */

This looks like a comment describing the function but it does not
desribe the function.

Also wouldn't it be easier to just add a gc special free function for
your srvinfo struct that also free the associated addrinfo record
instead of doing this strange dance?

> +int
> +getaddrinfo_chained(const char *node, const char *service,
> +                    const struct addrinfo *hints,
> +                    struct addrinfo **res)
> +{
> +    int status =3D getaddrinfo(node, service, hints, res);
> +    if (status =3D=3D 0 && res && *res)
> +    {
> +        struct addrinfo_chained head, *tail =3D &head;
> +
> +        head.ai.ai_next =3D NULL;
> +        for (struct addrinfo *ai =3D *res; ai; ai =3D ai->ai_next)
> +        {
> +            socklen_t addrlen =3D ai->ai_addr ? ai->ai_addrlen : 0;
> +            size_t namelen =3D ai->ai_canonname ? strlen(ai->ai_canonnam=
e) + 1 : 0;
> +
> +            /* allocate self-contained struct with enough space for opti=
onal data */
> +            struct addrinfo_chained *ac =3D calloc(1, sizeof(*ac) + addr=
len + namelen);
> +            if (!ac)
> +            {
> +                openvpn_freeaddrinfo(head.ai.ai_next);
> +                head.ai.ai_next =3D NULL;
> +                status =3D EAI_MEMORY;
> +                break;
> +            }
> +
> +            /* deep clone the structure and its members */
> +            memcpy(&ac->ai, ai, sizeof(ac->ai));
> +            if (ai->ai_addr)
> +            {
> +                memcpy(&ac->addr.addr.sa, ai->ai_addr, addrlen);
> +                ac->ai.ai_addr =3D &ac->addr.addr.sa;
> +            }
> +            if (ai->ai_canonname)
> +            {
> +                memcpy(ac->canonname, ai->ai_canonname, namelen);
> +                ac->ai.ai_canonname =3D ac->canonname;
> +            }
> +
> +            /* add clone to the tail */
> +            ac->ai.ai_next =3D NULL;
> +            tail->ai.ai_next =3D &ac->ai, tail =3D ac;
> +        }
> +
> +        /* original list is cloned, can be freed now */
> +        freeaddrinfo(*res);
> +        *res =3D head.ai.ai_next;
> +    }
> +    return status;
> +}
> +
> +void
> +openvpn_freeaddrinfo(struct addrinfo *res)
> +{
> +    while (res)
> +    {
> +        struct addrinfo_chained *ac =3D (struct addrinfo_chained *)res;
> +        res =3D res->ai_next;
> +        free(ac);
> +    }
> +}
> +
>  /*
>   * Translate IPv4/IPv6 addr or hostname into struct addrinfo
>   * If resolve error, try again for resolve_retry_seconds seconds.
> @@ -497,7 +862,7 @@ openvpn_getaddrinfo(unsigned int flags,
>          hints.ai_socktype =3D SOCK_STREAM;
>      }
>=20=20
> -    status =3D getaddrinfo(hostname, servname, &hints, res);
> +    status =3D getaddrinfo_chained(hostname, servname, &hints, res);
>=20=20
>      if (status !=3D 0) /* parse as numeric address failed? */
>      {
> @@ -555,16 +920,17 @@ openvpn_getaddrinfo(unsigned int flags,
>          /*
>           * Resolve hostname
>           */
> -        while (true)
> -        {
> +        struct srvinfo *targets =3D NULL;
>  #ifndef _WIN32
> -            res_init();
> +        res_init();
>  #endif
> -            /* try hostname lookup */
> -            hints.ai_flags &=3D ~AI_NUMERICHOST;
> -            dmsg(D_SOCKET_DEBUG, "GETADDRINFO flags=3D0x%04x ai_family=
=3D%d ai_socktype=3D%d",
> -                 flags, hints.ai_family, hints.ai_socktype);
> -            status =3D getaddrinfo(hostname, servname, &hints, res);
> +
> +        /* try srv lookup */
> +        while (flags & GETADDR_DISCOVERY)
> +        {
> +            dmsg(D_SOCKET_DEBUG, "GETSRVINFO flags=3D0x%04x hostname=3D%=
s",
> +                 flags, np(hostname));
> +            status =3D openvpn_getsrvinfo(flags, hostname, OPENVPN_SERVI=
CE, &targets, &gc);
>=20=20
>              if (signal_received)
>              {
> @@ -581,9 +947,6 @@ openvpn_getaddrinfo(unsigned int flags,
>                          /* turn success into failure (interrupted syscal=
l) */
>                          if (0 =3D=3D status)
>                          {
> -                            ASSERT(res);
> -                            freeaddrinfo(*res);
> -                            *res =3D NULL;
>                              status =3D EAI_AGAIN; /* =3D temporary failu=
re */
>                              errno =3D EINTR;
>                          }
> @@ -592,8 +955,8 @@ openvpn_getaddrinfo(unsigned int flags,
>                  }
>              }
>=20=20
> -            /* success? */
> -            if (0 =3D=3D status)
> +            /* success and fails are expected, fallback to usual resolve=
 */
> +            if (EAI_AGAIN !=3D status)
>              {
>                  break;
>              }
> @@ -614,10 +977,127 @@ openvpn_getaddrinfo(unsigned int flags,
>=20=20
>              if (--resolve_retries <=3D 0)
>              {
> -                goto done;
> +                /* can't retry, fallback to usual resolve */
> +                break;
>              }
>=20=20
>              management_sleep(fail_wait_interval);
> +#ifndef _WIN32
> +            res_init();
> +#endif

Add a comment why we do that res_init again. It is not obvious for me.


This is not full review. But I feel this emulating addrinfo for remote
is a bit hacky. I feel refactoring the current_remote code to be a bit
more agnostic and then always use the srvinfo meta struct and iterates
through that one to set addrinfo or something in that is a much cleaner
solution.

(This might be already in patch) Also if srv records are returned and
verb level is high enough, something like 3 or 4, we should log
something like whole result of the service discovery.

Arne


--hdMTJIXsB4r0RgtiqqwBfI2NhWsf8F4f9--

--BuMv24cAhyp5d5JEUza4UDTERnV95gOs9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl9E1XUACgkQFRhsZwKx
RFSXKBAAk5JfaLol5YA3xizQoaCmYrwNZXCp7FbktFUwDRIXtNXGqINfTv+KCKun
DOz/kImUlVgSU3XkXR20qeYtlDYTBjCoLIvFtkSFDGWEl4eedklCXk/EX9kMVGqH
pLTWIPdQJIhOeVNFqb2/bHGmA6Mj4+JDXeQyDNhBU8CfrdRWYwGry9LzMaZ5Pyjv
Nx8p/7kvpgxfzqJIbatBL6dTSLrGk1njn2L3lIToa9OS9M7UQHyjWaxlx7RP+Uo8
yEvTfkfzrsPvpx+9aDmsH+tzeNF46OffM2dAKgkQRxZParqKER3Jux+nw/2F2nyK
ZYUzvadzgWMGhCuQqtlAJHqiFrtBISJepkQY8n8Obmfyf00PMMh2svpb7KK6uajq
KChH741B5ikWXJmY2o/+cQV5j24W/jjEN/j9WYoFAzN4vsZFr9uD0ZU7NjZpar7V
syc3ssMvixrsB+SKUX23vbFHg2K9eFbOuNn6hnm+lojteNnvc+VnPkWCt+/CqD9Q
ucAP6ackRcbexCfCzeBx7Re+TW/PVnxEJnWSwQo7vaApKKMVJOLo4scRnQ1CYe8A
O3bFZsaHELBNBxzTyiVffGSzRk0u3W4ailzRnQyFUIM8OrtbrfyfGhBQ0aFbXJK5
bphfeuSFKsiAzxQetTkXqxQrDIaqThpgu/WpO2fgODm5RzJ06Wo=
=Ujmm
-----END PGP SIGNATURE-----

--BuMv24cAhyp5d5JEUza4UDTERnV95gOs9--

