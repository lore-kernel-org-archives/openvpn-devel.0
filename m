References: <20201003095253.16026-1-themiron@...2010...>
 <20201004223614.12429-1-themiron@...2010...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <47dbed91-a26b-51ff-0171-c2878df92238@...1227...>
Date: Tue, 20 Oct 2020 08:57:40 +0200
MIME-Version: 1.0
In-Reply-To: <20201004223614.12429-1-themiron@...2010...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="7F5c0uzZGW0tXavIBMEFz0UMlSz9WObbi"
Subject: Re: [Openvpn-devel] [PATCH v8] Add DNS SRV remote host discovery
 support
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
--7F5c0uzZGW0tXavIBMEFz0UMlSz9WObbi
Content-Type: multipart/mixed; boundary="xSknv7qh3XD2tIc7gNnD0BKeKk2F5M7t1"

--xSknv7qh3XD2tIc7gNnD0BKeKk2F5M7t1
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 05.10.20 um 00:36 schrieb Vladislav Grishenko:
> DNS SRV remote host discovery allows to have multiple OpenVPN servers for
> a single domain w/o explicit profile enumeration, to move services from
> host to host with little fuss, and to designate hosts as primary servers
> for a service and others as backups.
> Feature has been asked several times already, should be useful in case of
> substantial number of clients & servers deployed.
>=20
> Patch introduces "--remote-srv domain [service] [proto]" option.
> The "service" and "proto" arguments are optional. Client will try
> to resolve DNS SRV record "_service._proto.domain" and use returned
> DNS SRV records as remote server list ordered by server selection
> mechanism defined in RFC2782 (https://tools.ietf.org/html/rfc2782):
>=20
>     A client MUST attempt to contact the target host with the
>     lowest-numbered priority field value it can reach, target hosts
>     with the same priority SHOULD be tried in an order defined by the
>     weight field.
>     The weight field specifies a relative weight for entries with the
>     same priority. Larger weights SHOULD be given a proportionately
>     higher probability of being selected.
>     Domain administrators SHOULD use Weight 0 when there isn't any
>     server selection to do. In the presence of records containing
>     weights greater than 0, records with Weight 0 SHOULD have a very
>     small chance of being selected.
>=20
> Note: OpenVPN server selection mechanism implementation indeed will
> give records with weight of zero a very small chance of being selected
> first, but never skip them.
>=20
> Example: instead of multiple --remote in order:
>     remote server1.example.net 1194 udp
>     remote server2.example.net 1194 udp
>     remote server3.example.net 1194 udp
>     remote server4.example.net 443 tcp
>=20
> now it's possible to specify just one --remote-srv:
>     remote-srv example.net
>=20
> and configure following DNS SRV records:
>     name                             prio weight port target
>     _openvpn._udp.example.net IN SRV 10   60     1194 server1.example.net
>     _openvpn._udp.example.net IN SRV 10   40     1194 server2.example.net
>     _openvpn._udp.example.net IN SRV 10   0      1194 server3.example.net
>     _openvpn._tcp.example.net IN SRV 20   0       443 server4.example.net

Missing . at the end at least if it should be in a bind zone file:


_openvpn._udp.example.net. IN SRV 10   60     1194 server1.example.net.

or

_openvpn._udp		 IN SRV 10   60     1194 server1.example.net.


>=20
> For "--remote-srv example.net" following will happen in order:
> 1. The client will first try to resolve "_openvpn._udp.example.net"
>    and "_openvpn._tcp.example.net".
> 2. Records "server1.example.net:1194", "server2.example.net:1194"
>    and "server3.example.net:1194" will be selected before record
>    "server4.example.net:443" as their priority 10 is smaller than 20.
> 3. Records "server1.example.net:1194", "server2.example.net:1194"
>    and "server3.example.net:1194" will be randomly selected with
>    weight probability: first will be either "server1.example.net:1194"
>    with 60% probability or "server2.example.net:1194" with 40% or
>    "server3.example.net:1194" with almost zero probability.
> 4. If "server1.example.net:1194" was selected, the second record will
>    be either "server2.example.net:1194" with almost 100% probability
>    or "server3.example.net:1194" with almost 0%.
> 5. If "server2.example.net:1194" was selected, the third record will
>    be the only last record of priority 10 - "server3.example.net:1194".
> 6. Record "server4.example.net:443" will be the last one selected as
>    the only record with priority 20.
> 7. Each of the resulting "target:port" remote hosts will be resolved
>    and accessed if its protocol has no conflict with the rest of the
>    OpenVPN options.
>=20
>   If DNS SRV name can't be resolved or no valid records were returned,
>   client will move on to the next connection entry.
>=20
> v2:
>   - use DNS SRV for feature naming
>   - change option name to --remote-service-discovery
>   - add --remote-service-discovery [service] optional parameter support
>   - rewrite man, add algo/prio/weight description and examples
>   - fix random weight selection was not implicit
>   - remove pulled REMOTE_DISCOVERY support, not needed
>   - split windows/unix-specific parts into extra functions
>   - put functions into servinfo scope, add doxygen comments
>   - remove addrinfo hack, use servinfo containers of addrinfo list
>   - better proxy support (tcp mode not supported so far)
>   - log discovery attempts and results, if enabled
>=20
> v3:
>   - complete logic rewrite
>   - use separate --remote-srv [service] [proto] option
>   - remove fallback, additional --remote/--remote-srv does the same
>   - add "auto" protocol support to allow both udp & tcp discoverery
>   - add support for tcp / http proxy (natively)
>   - man update
>=20
> v4:
>   - due RFC 2782 ambiguity, prefer to use all resolved DNS SRV records,
>     even ones with weight 0 after the records containing weights greater
>     than 0 were all selected, keep related code disabled for historical
>     reasons.
>   - man update
>=20
> v5: rebase against upstream with connection advancing fix
>   - allow management skip/accept for remote service hosts as for --remote
>   - improve compatibility with a way "--persist-remote-ip" is handled
>   - ensure max line length is 80
>=20
> v6:
>   - pick out code-style conformant changes into separate patch
>   - add more options checks and comments
>=20
> v7:
>   - prefer line breaks before long string parameters
>   - use win32/posix suffixes for query_servinfo
>=20
> v8:
>   - rework compatibility with --preresolve and --persist-remote-ip
>   - fix dns data structures leak on wine/win32
>   - add priority and weight logging
>=20
> Signed-off-by: Vladislav Grishenko <themiron@...2010...>
> ---
>  configure.ac                        |   2 +-
>  doc/man-sections/client-options.rst | 117 +++-
>  doc/management-notes.txt            |   6 +
>  src/openvpn/Makefile.am             |   2 +-
>  src/openvpn/buffer.h                |   5 -
>  src/openvpn/errlevel.h              |   1 +
>  src/openvpn/init.c                  |  79 ++-
>  src/openvpn/openvpn.vcxproj         |   8 +-
>  src/openvpn/options.c               | 268 +++++++--
>  src/openvpn/options.h               |   4 +
>  src/openvpn/socket.c                | 854 +++++++++++++++++++++++++++-
>  src/openvpn/socket.h                |  58 +-
>  src/openvpn/syshead.h               |   5 +
>  13 files changed, 1328 insertions(+), 81 deletions(-)
>=20
> diff --git a/configure.ac b/configure.ac
> index ebb32204..22088aaf 100644
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
> index af21fbcd..2ed9655d 100644
> --- a/doc/man-sections/client-options.rst
> +++ b/doc/man-sections/client-options.rst
> @@ -307,10 +307,117 @@ configuration.
>    specification (4/6 suffix), OpenVPN will try both IPv4 and IPv6
>    addresses, in the order getaddrinfo() returns them.
>=20=20
> +--remote-srv args
> +  Remote DNS SRV domain, service name and protocol.
> +
> +  Valid syntaxes:
> +  ::
> +
> +     remote-srv domain
> +     remote-srv domain service
> +     remote-srv domain service proto
> +
> +  The ``service`` and ``proto`` arguments are optional. Client will try
> +  to resolve DNS SRV record ``_service._proto.domain`` and use returned
> +  DNS SRV records as remote server list ordered by server selection
> +  mechanism defined in `RFC 2782 <https://tools.ietf.org/html/rfc2782>`_:
> +  ::
> +
> +    A client MUST attempt to contact the target host with the
> +    lowest-numbered priority field value it can reach, target hosts
> +    with the same priority SHOULD be tried in an order defined by the
> +    weight field.
> +    The weight field specifies a relative weight for entries with the
> +    same priority. Larger weights SHOULD be given a proportionately
> +    higher probability of being selected.
> +    Domain administrators SHOULD use Weight 0 when there isn't any
> +    server selection to do. In the presence of records containing
> +    weights greater than 0, records with Weight 0 SHOULD have a very
> +    small chance of being selected.
> +
> +  *Note:*
> +    OpenVPN server selection mechanism implementation indeed will give
> +    records with weight of zero a very small chance of being selected
> +    first, but never skip them.
> +
> +  The ``service`` argument indicates the symbolic name of the desired
> +  service. By default it is :code:`openvpn` registered service name.

The last sentenced feels odd to me. But I am no native speaker I would
word that as:

By default service is the registered service name :code:`openvpn`.

> +
> +  The ``proto`` argument indicates the symbolic name of the desired
> +  protocol and the protocol to use when connecting with the remote, and
> +  may either be :code:`tcp`, :code:`udp` or special value :code:`auto`
> +  used by default to try both. In this case all the discovered remote
> +  hosts will be ordered by server selection mechanism regardless their
> +  protocol. To enforce IPv4 or IPv6 connections add a :code:`4` or
> +  :code:`6` suffix; like :code:`udp4` / :code:`udp6` / :code:`tcp4` /
> +  :code:`tcp6` / :code:`auto4` / :code:`auto6`.
> +
> +  On the client, multiple ``--remote-srv`` options may be specified for
> +  redundancy, each referring to a different DNS SRV record name, in the
> +  order specified by the list of ``--remote-srv`` options. Specifying
> +  multiple ``--remote-srv`` options for this purpose is a special case
> +  of the more general connection-profile feature. See the
> +  ``<connection>`` documentation below.
> +
> +  The client will move on to the next DNS SRV record in the ordered list,
> +  in the event of connection failure. Note that at any given time, the
> +  OpenVPN client will at most be connected to one server.
> +
> +  If particular DNS SRV record next resolves to multiple IP addresses,
> +  OpenVPN will try them in the order that the system getaddrinfo()
> +  presents them, so prioritization and DNS randomization is done by the
> +  system library. Unless an IP version is forced by the protocol
> +  specification (4/6 suffix), OpenVPN will try both IPv4 and IPv6
> +  addresses, in the order getaddrinfo() returns them.
> +
> +  Examples:
> +  ::
> +
> +     remote-srv example.net
> +     remote-srv example.net openvpn
> +     remote-srv example.net openvpn tcp
> +
> +  Example of DNS SRV records:
> +  ::
> +
> +     name                             prio weight port target
> +     _openvpn._udp.example.net IN SRV 10   60     1194 server1.example.n=
et
> +     _openvpn._udp.example.net IN SRV 10   40     1194 server2.example.n=
et
> +     _openvpn._udp.example.net IN SRV 10   0      1194 server3.example.n=
et
> +     _openvpn._tcp.example.net IN SRV 20   0       443 server4.example.n=
et
> +

Same problem with missing . at the end of the domain. I ended up with:


2020-10-19 17:43:16 Resolved remote service host:
openpvn.blinkt.de.blinkt.de:1198,udp prio 10 weight 60

which is semi helpful.


> +  For ``--remote-srv example.net`` following will happen in order:
> +
> +  1. The client will first try to resolve ``_openvpn._udp.example.net``
> +     and ``_openvpn._tcp.example.net``.
> +  2. Records ``server1.example.net:1194``, ``server2.example.net:1194``
> +     and ``server3.example.net:1194`` will be selected before record
> +     ``server4.example.net:443`` as their priority 10 is smaller than 20.
> +  3. Records ``server1.example.net:1194``, ``server2.example.net:1194``
> +     and ``server3.example.net:1194`` will be randomly selected with
> +     weight probability: first will be either ``server1.example.net:1194=
``
> +     with 60% probability or ``server2.example.net:1194`` with 40% or
> +     ``server3.example.net:1194`` with almost zero probability.
> +  4. If ``server1.example.net:1194`` was selected, the second record will
> +     be either ``server2.example.net:1194`` with almost 100% probability
> +     or ``server3.example.net:1194`` with almost 0%.
> +  5. If ``server2.example.net:1194`` was selected, the third record will
> +     be the only last record of priority 10 - ``server3.example.net:1194=
``.
> +  6. Record ``server4.example.net:443`` will be the last one selected as
> +     the only record with priority 20.
> +  7. Each of the resulting ```target:port`` remote hosts will be resolved
> +     and accessed if its protocol has no conflict with the rest of the
> +     OpenVPN options.
> +
> +  If DNS SRV name can't be resolved or no valid records were returned,

If /a/ DNS SRV name.

Use cannot rather than the informal "can't".
Also are instead of were to keep tenses the same in both sentences.

> +  client will move on to the next connection entry.
> +

the client

> +  For more information on DNS SRV see https://tools.ietf.org/html/rfc2782
> +
>  --remote-random
> -  When multiple ``--remote`` address/ports are specified, or if connecti=
on
> -  profiles are being used, initially randomize the order of the list as a
> -  kind of basic load-balancing measure.
> +  When multiple ``--remote`` address/ports or ``--remote-srv`` records a=
re
> +  specified, or if connection profiles are being used, initially randomi=
ze
> +  the order of the list as a kind of basic load-balancing measure.

This is now even more confusing. I would completely rewrite it and not
that remote-srv is better.

--remote-random
  Randomises the order of ``--remote-srv``, ``remote-srv`` and
connection profiles on start. This randomisationof these entries as a
kind of basic load-balancing measure. Note that implementing DNS SRV
entries (with a short TTL if it should be dynamic) and remote-srv is a
better alternative for client-side load balancing.



> +}
> +
> +#else
> +/*
> + * Queries DNS SRV records for specified DNS domain.
> + * Returns EAI_* status and service list on success in order of receive.
> + */
> +static int
> +query_servinfo_posix(const char *domain, int proto,
> +                     struct servinfo *next, struct servinfo **res)
> +{
> +    unsigned char answer[NS_MAXMSG];
> +    int status;


on macOS:

../../../openvpn-git/src/openvpn/socket.c:672:26: error: use of undeclared
      identifier 'NS_MAXMSG'
    unsigned char answer[NS_MAXMSG];


I used

#ifndef NS_MAXMSG
#define NS_MAXMSG 65335
#endif

for my testing in that function


> +
> +    int n =3D res_query(domain, ns_c_in, ns_t_srv, answer, NS_MAXMSG);
> +    dmsg(D_SOCKET_DEBUG, "RES_QUERY class=3D%d type=3D%d domain=3D%s res=
ult=3D%d",
> +         ns_c_in, ns_t_srv, domain, n);
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
> +    struct servinfo *list =3D NULL, *first =3D NULL;
> +    for (int i =3D 0; i < ns_msg_count(msg, ns_s_an); i++)
> +    {
> +        ns_rr rr;
> +
> +        if (ns_parserr(&msg, ns_s_an, i, &rr) =3D=3D 0
> +            && ns_rr_type(rr) =3D=3D ns_t_srv)
> +        {
> +            const unsigned char *rdata =3D ns_rr_rdata(rr);
> +            char name[NS_MAXDNAME];
> +
> +            if (ns_rr_rdlen(rr) > 6
> +                && dn_expand(ns_msg_base(msg), ns_msg_end(msg),
> +                             rdata + 6, name, sizeof(name)) > 0 && *name)
> +            {
> +                struct servinfo *si =3D alloc_servinfo(name,
> +                                                     ns_get16(rdata + 4),
> +                                                     proto);
> +                if (!si)
> +                {
> +                    freeservinfo(list);
> +                    status =3D EAI_MEMORY;
> +                    goto done;
> +                }
> +                si->prio =3D ns_get16(rdata);
> +                si->weight =3D ns_get16(rdata + 2);
> +                si->next =3D list, list =3D si;
> +                if (!first)
> +                {
> +                    first =3D si;
> +                }
> +            }
> +        }
> +    }
> +    if (list)
> +    {
> +        first->next =3D next;
> +        *res =3D list;
> +        status =3D 0;
> +    }
> +    else
> +    {
> +        status =3D EAI_NODATA;
> +    }
> +
> +done:
> +    return status;
> +}
> +#endif
> +
> +/*
> + * Service structure compare function for server selection
> + * mechanism, defined in RFC 2782.
> + */
> +static int
> +servinfo_cmp(const void *a, const void *b)
> +{
> +    const struct servinfo *ae =3D *(struct servinfo **)a;
> +    const struct servinfo *be =3D *(struct servinfo **)b;
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
> +    /* else keep received order, can't be equal */
> +    return ae->order > be->order ? -1 : 1;
> +}
> +
> +/*
> + * Sort & order service list according server selection mechanism,
> + * defined in RFC 2782.
> + * Returns service list. Although specific elements can be freed,
> + * non-empty list can never become empty.
> + */

The comment about freed elements only applies if the #if 0 block is
enabled, right? I would remove this. And in general it is better to have
the function comments as doxygen style comments.


> +static struct servinfo *
> +sort_servinfo(struct servinfo *list)
> +{
> +    struct servinfo ordered, *tail =3D &ordered;
> +    int count =3D 0;
> +    struct gc_arena gc =3D gc_new();
> +
> +    ASSERT(list);
> +
> +    /* count and number entries in reverse order */
> +    for (struct servinfo *si =3D list; si; si =3D si->next)
> +    {
> +        si->order =3D count++;
> +    }
> +
> +    struct servinfo **sorted;
> +    ALLOC_ARRAY_CLEAR_GC(sorted, struct servinfo *, count, &gc);
> +    for (struct servinfo *si =3D list; si; si =3D si->next)
> +    {
> +        sorted[si->order] =3D si;
> +    }
> +
> +    /* sort records by priority and zero weight */
> +    qsort(sorted, count, sizeof(sorted[0]), servinfo_cmp);
> +
> +    /* apply weighted selection mechanism */
> +    ordered.next =3D NULL;
> +    for (int i =3D 0; i < count;)
> +    {
> +        struct servinfo unordered;
> +
> +        /* compute the sum of the weights of records of the same
> +         * priority and put them in the unordered list */
> +        unordered.prio =3D sorted[i]->prio;
> +        unordered.weight =3D 0;
> +        unordered.next =3D NULL;
> +        for (struct servinfo *prev =3D &unordered;
> +             i < count && sorted[i]->prio =3D=3D unordered.prio; i++)
> +        {
> +            unordered.weight +=3D sorted[i]->weight;
> +
> +            /* add entry to the tail of unordered list */
> +            sorted[i]->next =3D NULL;
> +            prev->next =3D sorted[i], prev =3D sorted[i];
> +        }
> +
> +        /* process the unordered list */
> +        while (unordered.next)
> +        {
> +            /* choose a uniform random number between 0 and the sum
> +             * computed (inclusive) */
> +            int weight =3D get_random() % (unordered.weight + 1);
> +
> +            /* select the entries whose running sum value is the first
> +             * in the selected order which is greater than or equal
> +             * to the random number selected */
> +            for (struct servinfo *si =3D unordered.next, *prev =3D &unor=
dered;
> +                 si; prev =3D si, si =3D si->next)
> +            {
> +                /* selected entry is the next one to be contacted */
> +                if (si->weight >=3D weight)
> +                {
> +                    unordered.weight -=3D si->weight;
> +
> +                    /* move entry to the ordered list */
> +                    prev->next =3D si->next;
> +                    si->next =3D NULL;
> +                    tail->next =3D si, tail =3D si;
> +
> +                    /*
> +                     * RFC 2782 is ambiguous, it says:
> +                     *   In the presence of records containing weights g=
reater
> +                     *   than 0, records with weight 0 should have a very
> +                     *   small chance of being selected.
> +                     * According that, within the same priority, after a=
ll
> +                     * records containing weights greater than 0 were se=
lected,
> +                     * the rest of records with weight 0 should be skipp=
ed.
> +                     * At the same time, it says:
> +                     *   The following algorithm SHOULD be used to order=
 the
> +                     *   SRV RRs of the same priority:
> +                     *   ...
> +                     *   Continue the ordering process until there are no
> +                     *   unordered SRV RRs.
> +                     * This means records with wight 0 should always be
> +                     * selected, as last ones in worst case.
> +                     */

.... We implement the second option.


> +#if 0
> +                    /*
> +                     * Skip all the rest records with weight 0 after the=
 last
> +                     * one with weight greater than 0.
> +                     */
> +                    if (unordered.weight =3D=3D 0 && si->weight)
> +                    {
> +                        freeservinfo(unordered.next);
> +                        unordered.next =3D NULL;
> +                    }
> +                    break;
> +#endif

Lets not add a #if 0 here

rather use a comment here that notes that we never skip records or
something like that.




> +                }
> +                weight -=3D si->weight;
> +            }
> +        }
> +    }
> +
> +    gc_free(&gc);
> +    return ordered.next;
> +}
> +
> +
> +/*
> + * Resolves DNS SRV records for specified domain and service.
> + * Returns EAI_* status (like getaddrinfo) and service list, ordered
> + * according server selection mechanism, defined in RFC 2782.
> + */
> +static int
> +getservinfo(const char *domain,
> +            const char *service,
> +            int flags,
> +            struct servinfo **res)
> +{
> +    static const struct {
> +        int flags;
> +        int proto;
> +        const char *name;
> +    } proto[] =3D {
> +        { GETADDR_DATAGRAM, PROTO_UDP, "udp" },
> +        { GETADDR_STREAM, PROTO_TCP_CLIENT, "tcp" }
> +    };
> +    struct servinfo *list =3D NULL;
> +    int status =3D EAI_SOCKTYPE;
> +
> +    ASSERT(res);
> +
> +    if (!domain)
> +    {
> +        return EAI_NONAME;
> +    }
> +    if (!service)
> +    {
> +        return EAI_SERVICE;
> +    }
> +
> +    int proto_flags =3D flags & GETADDR_PROTO_MASK;
> +    for (int i =3D 0; i < SIZE(proto); i++)
> +    {
> +        if (proto_flags & proto[i].flags)
> +        {
> +            proto_flags &=3D ~proto[i].flags;
> +
> +            char qname[256];
> +            if (!openvpn_snprintf(qname, sizeof(qname), "_%s._%s.%s",
> +                                  service, proto[i].name, domain))
> +            {
> +                freeservinfo(list);
> +                return EAI_MEMORY;
> +            }
> +
> +#ifdef _WIN32
> +            status =3D query_servinfo_win32(qname, proto[i].proto, list,=
 &list);
> +#else
> +            status =3D query_servinfo_posix(qname, proto[i].proto, list,=
 &list);
> +#endif

I think we should name those two function identical. They are doing
identical stuff, so need for this ifdef and different function names.



>  bool

> +/* struct to hold resolved service targets */
> +struct servinfo
> +{
> +    const char *hostname;
> +    const char *servname;
> +    int proto;
> +    int order;
> +    unsigned short prio;
> +    unsigned short weight;
> +    struct addrinfo *ai;
> +    struct servinfo *next;
> +};
> +
>  /* struct to hold preresolved host names */
>  struct cached_dns_entry {
>      const char *hostname;
>      const char *servname;
>      int ai_family;
>      int flags;
> -    struct addrinfo *ai;
> +    union {
> +        struct addrinfo *ai;
> +        struct servinfo *si;
> +    };

Is saving the space for one pointer really worth the potential danger of
accidentially using an addrinfo as servinfo or vice versa?


I tested the patch and it works as expected (apart from things mentioned
here).

But this should not be a legal config:

<connection>
remote foo.bar
remote-srv blinkt.de ovpn
</connection>

In a connection entry there should be only one of remote or remote-srv
be allowed.

Arne


--xSknv7qh3XD2tIc7gNnD0BKeKk2F5M7t1--

--7F5c0uzZGW0tXavIBMEFz0UMlSz9WObbi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl+OimUACgkQFRhsZwKx
RFTBAhAAqyzwj4kwYojMFLCfBhZz4/FspdnFi4Y85yZfVK4rKPPQGzp7zjiT0wu5
VhxMRFGTCE9SRF4Jdj5qVR8EK6V9tUaYD0mn39RWtmOFs0QhdF4WJ4zanS0LpWjD
4Dowx+C3bf3Et7lBT58krMOihJygPSTvgywq5oDA4vqWRIFiwcrnj2QMq3n05FKh
Lj/4EDJAKGxMS+uRKoip+45sLZv2k3P7EDoMMa5yCuNIv8TF3fE3hReECTCwDb4M
yFMMP5ZFexChKqY8PBWbdYvQpkZLtC/bXD80x8Yr8qzpm1J/O+I7z9gc+0ddH27y
OkVei8gKAw5Bpbu5b3kJidBCnWOt7h0m8xxmUQfczuFMfOJowz7zT06DvVHbjscf
GXfhs/F1/p0MJCRyHD9rpMrTaGTC3oYoI5znDN2+9c0LEGOQetsaX7Dwb6Q+9zk+
UApfv2PRsun3biiKeGc0a8sf7tjTvY51AkdQ5pvGOHo+EC1O8VmDD219sjRWJfBS
MfcCSz7GeYoAvPHV+45so3oGLe+qRNMX6p73LeHPodX5mNgipze8Qihghtirahht
kfTrhh1CHkY2KkJWMjNL7CAd94h1lWf4N3L7+dAGAQwHr0tZ2QaCOdNjXqYEP6aS
KGKC/0Q3LJuGEz6cutpv76JDhtaGRMTmdYTj9iZov6uCyHAWlaI=
=FCHf
-----END PGP SIGNATURE-----

--7F5c0uzZGW0tXavIBMEFz0UMlSz9WObbi--

