References: <20171202134541.7688-1-a@...2181...>
 <20171202134541.7688-7-a@...2181...>
 <d78b43c2-0140-7b15-34ed-949636ad444d@...1856...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <edf531f0-4e73-9015-1dd1-725fe9682263@...2181...>
Date: Mon, 4 Dec 2017 14:39:28 +0800
MIME-Version: 1.0
In-Reply-To: <d78b43c2-0140-7b15-34ed-949636ad444d@...1856...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="AjpBQf2jHAg6jlfp88Oxtdp5vUAmSCRGU"
Subject: Re: [Openvpn-devel] [PATCH 7/7] Remove TLS_MODE
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--AjpBQf2jHAg6jlfp88Oxtdp5vUAmSCRGU
Content-Type: multipart/mixed; boundary="aLgiDsFaTpg56KLcEjmWqQw5ALPpUUiWN";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net
Message-ID: <edf531f0-4e73-9015-1dd1-725fe9682263@...2181...>
Subject: Re: [Openvpn-devel] [PATCH 7/7] Remove TLS_MODE
References: <20171202134541.7688-1-a@...2181...>
 <20171202134541.7688-7-a@...2181...>
 <d78b43c2-0140-7b15-34ed-949636ad444d@...1856...>
In-Reply-To: <d78b43c2-0140-7b15-34ed-949636ad444d@...1856...>

--aLgiDsFaTpg56KLcEjmWqQw5ALPpUUiWN
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable



On 03/12/17 22:45, Steffan Karger wrote:
> Hi,
>=20
> On 02-12-17 14:45, Antonio Quartulli wrote:
>> Now that ENABLE_CRYPTO has been removed, TLS_MODE is basically
>> a useless shortcut which does not really help the readability of the
>> code.
>=20
> So I don't really agree here.  As we've just experienced while
> discussing this on IRC, the meaning of 'c->c2.tls_multi !=3D NULL' is not
> that trivial.  At first sight it seems to suggest 'we have multiple
> peers' (i.e. mode server), but it really does just mean 'this is a TLS
> mode connection' (ie, not a static key connection).
>=20
> So even though I would have preferred this to be an inline function, I
> think it *does* add to readability.  So I'd prefer to either keep it, or
> change it to a static inline function for type safety.


Let's drop this patch then.

With another patch we can convert all these macros to inline static
functions.

Cheers,

>=20
>> Remove it and use its expanded expression instead.
>>
>> Signed-off-by: Antonio Quartulli <a@...2181...>
>> ---
>>  src/openvpn/forward.c | 2 +-
>>  src/openvpn/init.c    | 2 +-
>>  src/openvpn/occ.c     | 3 ++-
>>  src/openvpn/openvpn.h | 1 -
>>  4 files changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
>> index 9bf9483e..85ec71ae 100644
>> --- a/src/openvpn/forward.c
>> +++ b/src/openvpn/forward.c
>> @@ -948,7 +948,7 @@ process_incoming_link_part2(struct context *c, struc=
t link_socket_info *lsi, con
>>           *
>>           * Also, update the persisted version of our packet-id.
>>           */
>> -        if (!TLS_MODE(c))
>> +        if (!c->c2.tls_multi)
>>          {
>>              link_socket_set_outgoing_addr(&c->c2.buf, lsi, &c->c2.from,=
 NULL, c->c2.es);
>>          }
>> diff --git a/src/openvpn/init.c b/src/openvpn/init.c
>> index f8034ec7..7fe50628 100644
>> --- a/src/openvpn/init.c
>> +++ b/src/openvpn/init.c
>> @@ -1306,7 +1306,7 @@ do_init_timers(struct context *c, bool deferred)
>>          /* initialize occ timers */
>>=20=20
>>          if (c->options.occ
>> -            && !TLS_MODE(c)
>> +            && !c->c2.tls_multi
>>              && c->c2.options_string_local && c->c2.options_string_remot=
e)
>>          {
>>              event_timeout_init(&c->c2.occ_interval, OCC_INTERVAL_SECOND=
S, now);
>> diff --git a/src/openvpn/occ.c b/src/openvpn/occ.c
>> index 40f7e768..8434920c 100644
>> --- a/src/openvpn/occ.c
>> +++ b/src/openvpn/occ.c
>> @@ -378,7 +378,8 @@ process_received_occ_msg(struct context *c)
>>=20=20
>>          case OCC_REPLY:
>>              dmsg(D_PACKET_CONTENT, "RECEIVED OCC_REPLY");
>> -            if (c->options.occ && !TLS_MODE(c) && c->c2.options_string_=
remote)
>> +            if (c->options.occ && !c->c2.tls_multi
>> +                && c->c2.options_string_remote)
>>              {
>>                  if (!options_cmp_equal_safe((char *) BPTR(&c->c2.buf),
>>                                              c->c2.options_string_remote,
>> diff --git a/src/openvpn/openvpn.h b/src/openvpn/openvpn.h
>> index fe8324ab..b36ca319 100644
>> --- a/src/openvpn/openvpn.h
>> +++ b/src/openvpn/openvpn.h
>> @@ -556,7 +556,6 @@ struct context
>>   * have been compiled in.
>>   */
>>=20=20
>> -#define TLS_MODE(c) ((c)->c2.tls_multi !=3D NULL)
>>  #define PROTO_DUMP_FLAGS (check_debug_level(D_LINK_RW_VERBOSE) ? (PD_SH=
OW_DATA|PD_VERBOSE) : 0)
>>  #define PROTO_DUMP(buf, gc) protocol_dump((buf), \
>>                                            PROTO_DUMP_FLAGS   \
>>
>=20
> -------------------------------------------------------------------------=
-----
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>=20

--=20
Antonio Quartulli


--aLgiDsFaTpg56KLcEjmWqQw5ALPpUUiWN--

--AjpBQf2jHAg6jlfp88Oxtdp5vUAmSCRGU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAlok7aAACgkQB6U8WA7y
zXTgNQ//UcuCnmfil6Sn2QBt/tgy5+m3uE1WOKVcpfCS6xG3Y4TxBuT+fwncuqsN
xMcDqH8tCPpwOxW5Bau3h/3SJT7VEjhxqs9wDeXhl6LIjl6B+HZS7j7le6av5PFN
FkQfYusdJxTJ8DPXqIoKK+RRrYsdbZyqe/PBojeGmONJxPT0nEhXFPKsoXch8Kpm
lI1+B9r5kSxhjfaX7Ho6pZ5fu9NXA4DEPczSaOvT3fW+sgjmzO3VpB/aOmnY0XI0
mxWpGCb2gqMj/SlRjpYAbCedMBpuTqz2d3u06KjGJZb9P+sLmYiei+96y1A+zonP
yhGPdecCDgsTiGLGS8G61BvzR9M1a3hI22c/EJSGiTIMXwUtobHzifTn/Ro+iY4r
ow1Lo9b1mpP3PhUEPoMMe6hbxTZDiJVpLwULKST3kHsWdhzV8DUB4uFIELFNRfQW
xaEF6NRB4cFlc10PQB6ZTmBloBxca6K1RkMGBpW7zWBLJYFxMYqbpI53Z6UmALW2
a3wIs5h7h86cAFNMQ9PkpypTAqaJDYdDvBW85dk78jixviL9Omx2fFciUzWkuC5B
I/GaDRR/TISWks3JDVnLEEcnf8gDXQD8XxvHivjwv7oNxY8kRUbGDALnjCpP5q+g
C2Feyb2Xq85fPaUYJnCN5MzJIUf2LHNKGVLcUS76cgATt/XJK8w=
=uw+9
-----END PGP SIGNATURE-----

--AjpBQf2jHAg6jlfp88Oxtdp5vUAmSCRGU--

