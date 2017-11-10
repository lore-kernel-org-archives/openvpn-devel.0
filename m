References: <20170918181343.12924-1-a@...2181...>
 <9e5acca1-ab96-5951-0c29-1691b9ce7da7@...1856...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <a8f9411b-42a9-0916-617e-c2a29a61377a@...2181...>
Date: Sat, 11 Nov 2017 07:57:38 +0800
MIME-Version: 1.0
In-Reply-To: <9e5acca1-ab96-5951-0c29-1691b9ce7da7@...1856...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="7jPNsrHhHMR4j2tb7pck1vHiOffFj7IgF"
Subject: Re: [Openvpn-devel] [PATCH v4 1/3] pf: restyle pf_c2c/addr_test()
 to make them 'struct context' agnostic
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
--7jPNsrHhHMR4j2tb7pck1vHiOffFj7IgF
Content-Type: multipart/mixed; boundary="KCHxFUDx6r5Ekuld8TTpbVehdcx57XNpq";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net
Message-ID: <a8f9411b-42a9-0916-617e-c2a29a61377a@...2181...>
Subject: Re: [Openvpn-devel] [PATCH v4 1/3] pf: restyle pf_c2c/addr_test() to
 make them 'struct context' agnostic
References: <20170918181343.12924-1-a@...2181...>
 <9e5acca1-ab96-5951-0c29-1691b9ce7da7@...1856...>
In-Reply-To: <9e5acca1-ab96-5951-0c29-1691b9ce7da7@...1856...>

--KCHxFUDx6r5Ekuld8TTpbVehdcx57XNpq
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On 30/09/17 00:10, Steffan Karger wrote:
> Hi,
>=20
> On 18-09-17 20:13, Antonio Quartulli wrote:
>> In the attempt of getting rid of any pf-inline.h file, we need
>> to make sure that inline functions do not trigger any circular
>> include dependency.
>>
>> For this reason, avoid pf_c2c/addr_test() to be 'struct context'
>> aware, so that pf-inline.h does not need to rely on the content
>> of openvpn.h.
>>
>> Cc: Steffan Karger <steffan@...1856...>
>> Signed-off-by: Antonio Quartulli <a@...2181...>
>> ---
>>
>> v1-v3: skipped
>> v4: this is the first version of this patch, but named v4 for conveniency
>>
>>
>>  src/openvpn/multi.c     | 25 ++++++++++++++++++-------
>>  src/openvpn/pf-inline.h | 16 ++++++++++------
>>  src/openvpn/pf.c        |  6 +++++-
>>  3 files changed, 33 insertions(+), 14 deletions(-)
>>
>> diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
>> index c798c438..641b825a 100644
>> --- a/src/openvpn/multi.c
>> +++ b/src/openvpn/multi.c
>> @@ -2233,7 +2233,10 @@ multi_bcast(struct multi_context *m,
>>  #ifdef ENABLE_PF
>>                  if (sender_instance)
>>                  {
>> -                    if (!pf_c2c_test(&sender_instance->context,
> &mi->context, "bcast_c2c"))
>> +                    if (!pf_c2c_test(&sender_instance->context.c2.pf,
>> +                                     &sender_instance->context,
>> +                                     &mi->context.c2.pf, &mi->context,
>> +                                     "bcast_c2c"))
>>                      {
>>                          msg(D_PF_DROPPED_BCAST, "PF: client[%s] ->
> client[%s] packet dropped by BCAST packet filter",
>>                              mi_prefix(sender_instance),
>> @@ -2243,7 +2246,8 @@ multi_bcast(struct multi_context *m,
>>                  }
>>                  if (sender_addr)
>>                  {
>> -                    if (!pf_addr_test(&mi->context, sender_addr,
> "bcast_src_addr"))
>> +                    if (!pf_addr_test(&mi->context.c2.pf, &mi->context,
>> +                                      sender_addr, "bcast_src_addr"))
>>                      {
>>                          struct gc_arena gc =3D gc_new();
>>                          msg(D_PF_DROPPED_BCAST, "PF: addr[%s] ->
> client[%s] packet dropped by BCAST packet filter",
>> @@ -2602,7 +2606,8 @@ multi_process_incoming_link(struct multi_context
> *m, struct multi_instance *inst
>>                          if (mi)
>>                          {
>>  #ifdef ENABLE_PF
>> -                            if (!pf_c2c_test(c, &mi->context, "tun_c2c"=
))
>> +                            if (!pf_c2c_test(&c->c2.pf, c,
> &mi->context.c2.pf,
>> +                                             &mi->context, "tun_c2c"))
>>                              {
>>                                  msg(D_PF_DROPPED, "PF: client ->
> client[%s] packet dropped by TUN packet filter",
>>                                      mi_prefix(mi));
>> @@ -2618,7 +2623,8 @@ multi_process_incoming_link(struct multi_context
> *m, struct multi_instance *inst
>>                      }
>>                  }
>>  #ifdef ENABLE_PF
>> -                if (c->c2.to_tun.len && !pf_addr_test(c, &dest,
> "tun_dest_addr"))
>> +                if (c->c2.to_tun.len && !pf_addr_test(&c->c2.pf, c,
> &dest,
>> +                                                      "tun_dest_addr"))
>>                  {
>>                      msg(D_PF_DROPPED, "PF: client -> addr[%s] packet
> dropped by TUN packet filter",
>>                          mroute_addr_print_ex(&dest, MAPF_SHOW_ARP, &gc)=
);
>> @@ -2663,7 +2669,10 @@ multi_process_incoming_link(struct
> multi_context *m, struct multi_instance *inst
>>                                  if (mi)
>>                                  {
>>  #ifdef ENABLE_PF
>> -                                    if (!pf_c2c_test(c, &mi->context,
> "tap_c2c"))
>> +                                    if (!pf_c2c_test(&c->c2.pf, c,
>> +                                                     &mi->context.c2.pf,
>> +                                                     &mi->context,
>> +                                                     "tap_c2c"))
>>                                      {
>>                                          msg(D_PF_DROPPED, "PF: client
> -> client[%s] packet dropped by TAP packet filter",
>>                                              mi_prefix(mi));
>> @@ -2679,7 +2688,9 @@ multi_process_incoming_link(struct multi_context
> *m, struct multi_instance *inst
>>                              }
>>                          }
>>  #ifdef ENABLE_PF
>> -                        if (c->c2.to_tun.len && !pf_addr_test(c,
> &edest, "tap_dest_addr"))
>> +                        if (c->c2.to_tun.len &&
> !pf_addr_test(&c->c2.pf, c,
>> +                                                              &edest,
>> +
> "tap_dest_addr"))
>>                          {
>>                              msg(D_PF_DROPPED, "PF: client -> addr[%s]
> packet dropped by TAP packet filter",
>>                                  mroute_addr_print_ex(&edest,
> MAPF_SHOW_ARP, &gc));
>> @@ -2792,7 +2803,7 @@ multi_process_incoming_tun(struct multi_context
> *m, const unsigned int mpp_flags
>>                      set_prefix(m->pending);
>>
>>  #ifdef ENABLE_PF
>> -                    if (!pf_addr_test(c, e2, "tun_tap_src_addr"))
>> +                    if (!pf_addr_test(&c->c2.pf, c, e2,
> "tun_tap_src_addr"))
>>                      {
>>                          msg(D_PF_DROPPED, "PF: addr[%s] -> client
> packet dropped by packet filter",
>>                              mroute_addr_print_ex(&src, MAPF_SHOW_ARP,
> &gc));
>> diff --git a/src/openvpn/pf-inline.h b/src/openvpn/pf-inline.h
>> index ac19ac4c..7e38e674 100644
>> --- a/src/openvpn/pf-inline.h
>> +++ b/src/openvpn/pf-inline.h
>> @@ -31,20 +31,24 @@
>>  #define PCT_SRC  1
>>  #define PCT_DEST 2
>>  static inline bool
>> -pf_c2c_test(const struct context *src, const struct context *dest,
> const char *prefix)
>> +pf_c2c_test(const struct pf_context *src_pf, const struct context *src,
>> +            const struct pf_context *dest_pf, const struct context *des=
t,
>> +            const char *prefix)
>=20
> If you make this function take a const struct tls_multi * as 2nd and 4th
> argument, you don't have to change the pf_cn_test function prototype
> (and it doesn't have to know about struct context internals, which is
> useful for testing modules separately).


Sorry for forgetting about this comment. This is actually a good idea!

v5 will come soon.


Cheers,


>=20
>>  {
>> -    bool pf_cn_test(struct pf_set *pfs, const struct tls_multi *tm,
> const int type, const char *prefix);
>> +    bool pf_cn_test(const struct context *src, const struct context
> *dest,
>> +                    const int type, const char *prefix);
>>
>> -    return (!src->c2.pf.enabled  || pf_cn_test(src->c2.pf.pfs,
> dest->c2.tls_multi, PCT_DEST, prefix))
>> -           && (!dest->c2.pf.enabled || pf_cn_test(dest->c2.pf.pfs,
> src->c2.tls_multi,  PCT_SRC,  prefix));
>> +    return (!src_pf->enabled || pf_cn_test(src, dest, PCT_DEST, prefix))
>> +           && (!dest_pf->enabled || pf_cn_test(dest, src, PCT_SRC,
> prefix));
>>  }
>>
>>  static inline bool
>> -pf_addr_test(const struct context *src, const struct mroute_addr
> *dest, const char *prefix)
>> +pf_addr_test(const struct pf_context *src_pf, const struct context *src,
>> +             const struct mroute_addr *dest, const char *prefix)
>>  {
>>      bool pf_addr_test_dowork(const struct context *src, const struct
> mroute_addr *dest, const char *prefix);
>>
>> -    if (src->c2.pf.enabled)
>> +    if (src_pf->enabled)
>>      {
>>          return pf_addr_test_dowork(src, dest, prefix);
>>      }
>> diff --git a/src/openvpn/pf.c b/src/openvpn/pf.c
>> index 5cb002bf..135cb15d 100644
>> --- a/src/openvpn/pf.c
>> +++ b/src/openvpn/pf.c
>> @@ -442,8 +442,12 @@ lookup_cn_rule(struct hash *h, const char *cn,
> const uint32_t cn_hash)
>>  }
>>
>>  bool
>> -pf_cn_test(struct pf_set *pfs, const struct tls_multi *tm, const int
> type, const char *prefix)
>> +pf_cn_test(const struct context *src, const struct context *dest,
>> +           const int type, const char *prefix)
>>  {
>> +    struct pf_set *pfs =3D src->c2.pf.pfs;
>> +    struct tls_multi *tm =3D dest->c2.tls_multi;
>> +
>>      if (pfs && !pfs->kill)
>>      {
>>          const char *cn;
>>
>=20
> Otherwise this looks good to me.
>=20
> -Steffan
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


--KCHxFUDx6r5Ekuld8TTpbVehdcx57XNpq--

--7jPNsrHhHMR4j2tb7pck1vHiOffFj7IgF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAloGPPYACgkQB6U8WA7y
zXRDCg//ZpqhAvExlPMt24JpEO9Bkh69aUemHn7vEHjTB2XeRGbUtiNSZyEQ6I10
pVCEE7RAzD7du9Jxnd/lR78ppNRL0P9pZVmcoQdKXsvGcM+/1Yi+NxPWYvowS1Hn
grzDuZfOwQEnG82W5LRUt1E2CR1sPFf2PBTZbJRI5ycmwv4SMknx+iioXTBSA6od
s5yI2Z5Si3NK5JAfVP0F/9a8uiFGslmz4thcbNEbQZsdUYXAPCkrBoiLCd81dPby
yx6+qtWCF2Wkh6xSUlhc1Su0pzFRQ5l7h6/Nw2MXNcbCGVndS/B+h6KI0r3Vfl/6
fbwC7f2EnHXFa+2hXNtWO61LmAqxyayPtsHUOEjH85RocC0cZsKuGtb3gaatOqv3
xQ63lE6XbOc+S4eNHIcOqhtgUnu6gz8DQBwMbsbIFJ0A70BNE8fIYjyjRycg7Bmx
upy7CPDhGwylGWYNbZoFmyu90rdveRR7KQ8w7CzlrQ3E3GNNGa/AbuzpkxppXbnI
KhumcKWeIqXsfx5ERIW445zKMXYngfbW1FpFynO1McF5mKb9w2qX7r8a8uAQ29he
itI/RVKeWuJz9fKb4DW3uLIfsme9yDLT+RP3xzBijxeq0GIwwzFYq0pa+A1TR2qq
PWjK0mJ9LWFFpWffiQcGiIoTHoGxLWjFGoQMtRJLxBRXSXZZ/PM=
=u4IJ
-----END PGP SIGNATURE-----

--7jPNsrHhHMR4j2tb7pck1vHiOffFj7IgF--

