References: <20171111161836.23356-1-a@...2181...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <c512d70e-c608-e7e3-8463-b115c285fa12@...1856...>
Date: Sat, 11 Nov 2017 17:48:42 +0100
MIME-Version: 1.0
In-Reply-To: <20171111161836.23356-1-a@...2181...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH v5 1/3] pf: restyle pf_c2c/addr_test()
 to make them 'struct context' agnostic
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Antonio Quartulli <a@...2181...>, openvpn-devel@lists.sourceforge.net

Hi,

On 11-11-17 17:18, Antonio Quartulli wrote:
> In the attempt of getting rid of any pf-inline.h file, we need
> to make sure that inline functions do not trigger any circular
> include dependency.
> 
> For this reason, avoid pf_c2c/addr_test() to be 'struct context'
> aware, so that pf-inline.h does not need to rely on the content
> of openvpn.h.
> 
> Cc: Steffan Karger <steffan@...1856...>
> Signed-off-by: Antonio Quartulli <a@...2181...>
> ---
> 
> v1-v3: skipped
> v4: this is the first version of this patch, but named v4 for convenience
> v5: follow Steffan's suggestion and make pf_c2c_test() take tls_multi as argument 
> 
> 
>  src/openvpn/multi.c     | 28 +++++++++++++++++++++-------
>  src/openvpn/pf-inline.h | 14 +++++++++-----
>  2 files changed, 30 insertions(+), 12 deletions(-)
> 
> diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
> index 82a0b9d9..5c2c8e69 100644
> --- a/src/openvpn/multi.c
> +++ b/src/openvpn/multi.c
> @@ -2230,7 +2230,11 @@ multi_bcast(struct multi_context *m,
>  #ifdef ENABLE_PF
>                  if (sender_instance)
>                  {
> -                    if (!pf_c2c_test(&sender_instance->context, &mi->context, "bcast_c2c"))
> +                    if (!pf_c2c_test(&sender_instance->context.c2.pf,
> +                                     sender_instance->context.c2.tls_multi,
> +                                     &mi->context.c2.pf,
> +                                     mi->context.c2.tls_multi,
> +                                     "bcast_c2c"))
>                      {
>                          msg(D_PF_DROPPED_BCAST, "PF: client[%s] -> client[%s] packet dropped by BCAST packet filter",
>                              mi_prefix(sender_instance),
> @@ -2240,7 +2244,8 @@ multi_bcast(struct multi_context *m,
>                  }
>                  if (sender_addr)
>                  {
> -                    if (!pf_addr_test(&mi->context, sender_addr, "bcast_src_addr"))
> +                    if (!pf_addr_test(&mi->context.c2.pf, &mi->context,
> +                                      sender_addr, "bcast_src_addr"))
>                      {
>                          struct gc_arena gc = gc_new();
>                          msg(D_PF_DROPPED_BCAST, "PF: addr[%s] -> client[%s] packet dropped by BCAST packet filter",
> @@ -2599,7 +2604,10 @@ multi_process_incoming_link(struct multi_context *m, struct multi_instance *inst
>                          if (mi)
>                          {
>  #ifdef ENABLE_PF
> -                            if (!pf_c2c_test(c, &mi->context, "tun_c2c"))
> +                            if (!pf_c2c_test(&c->c2.pf, c->c2.tls_multi,
> +                                             &mi->context.c2.pf,
> +                                             mi->context.c2.tls_multi,
> +                                             "tun_c2c"))
>                              {
>                                  msg(D_PF_DROPPED, "PF: client -> client[%s] packet dropped by TUN packet filter",
>                                      mi_prefix(mi));
> @@ -2615,7 +2623,8 @@ multi_process_incoming_link(struct multi_context *m, struct multi_instance *inst
>                      }
>                  }
>  #ifdef ENABLE_PF
> -                if (c->c2.to_tun.len && !pf_addr_test(c, &dest, "tun_dest_addr"))
> +                if (c->c2.to_tun.len && !pf_addr_test(&c->c2.pf, c, &dest,
> +                                                      "tun_dest_addr"))
>                  {
>                      msg(D_PF_DROPPED, "PF: client -> addr[%s] packet dropped by TUN packet filter",
>                          mroute_addr_print_ex(&dest, MAPF_SHOW_ARP, &gc));
> @@ -2660,7 +2669,10 @@ multi_process_incoming_link(struct multi_context *m, struct multi_instance *inst
>                                  if (mi)
>                                  {
>  #ifdef ENABLE_PF
> -                                    if (!pf_c2c_test(c, &mi->context, "tap_c2c"))
> +                                    if (!pf_c2c_test(&c->c2.pf, c->c2.tls_multi,
> +                                                     &mi->context.c2.pf,
> +                                                     mi->context.c2.tls_multi,
> +                                                     "tap_c2c"))
>                                      {
>                                          msg(D_PF_DROPPED, "PF: client -> client[%s] packet dropped by TAP packet filter",
>                                              mi_prefix(mi));
> @@ -2676,7 +2688,9 @@ multi_process_incoming_link(struct multi_context *m, struct multi_instance *inst
>                              }
>                          }
>  #ifdef ENABLE_PF
> -                        if (c->c2.to_tun.len && !pf_addr_test(c, &edest, "tap_dest_addr"))
> +                        if (c->c2.to_tun.len && !pf_addr_test(&c->c2.pf, c,
> +                                                              &edest,
> +                                                              "tap_dest_addr"))
>                          {
>                              msg(D_PF_DROPPED, "PF: client -> addr[%s] packet dropped by TAP packet filter",
>                                  mroute_addr_print_ex(&edest, MAPF_SHOW_ARP, &gc));
> @@ -2789,7 +2803,7 @@ multi_process_incoming_tun(struct multi_context *m, const unsigned int mpp_flags
>                      set_prefix(m->pending);
>  
>  #ifdef ENABLE_PF
> -                    if (!pf_addr_test(c, e2, "tun_tap_src_addr"))
> +                    if (!pf_addr_test(&c->c2.pf, c, e2, "tun_tap_src_addr"))
>                      {
>                          msg(D_PF_DROPPED, "PF: addr[%s] -> client packet dropped by packet filter",
>                              mroute_addr_print_ex(&src, MAPF_SHOW_ARP, &gc));
> diff --git a/src/openvpn/pf-inline.h b/src/openvpn/pf-inline.h
> index ac19ac4c..3ba90ccf 100644
> --- a/src/openvpn/pf-inline.h
> +++ b/src/openvpn/pf-inline.h
> @@ -31,20 +31,24 @@
>  #define PCT_SRC  1
>  #define PCT_DEST 2
>  static inline bool
> -pf_c2c_test(const struct context *src, const struct context *dest, const char *prefix)
> +pf_c2c_test(const struct pf_context *src_pf, const struct tls_multi *src,
> +            const struct pf_context *dest_pf, const struct tls_multi *dest,
> +            const char *prefix)
>  {
>      bool pf_cn_test(struct pf_set *pfs, const struct tls_multi *tm, const int type, const char *prefix);
>  
> -    return (!src->c2.pf.enabled  || pf_cn_test(src->c2.pf.pfs,  dest->c2.tls_multi, PCT_DEST, prefix))
> -           && (!dest->c2.pf.enabled || pf_cn_test(dest->c2.pf.pfs, src->c2.tls_multi,  PCT_SRC,  prefix));
> +    return (!src_pf->enabled || pf_cn_test(src_pf->pfs, dest, PCT_DEST, prefix))
> +           && (!dest_pf->enabled || pf_cn_test(dest_pf->pfs, src, PCT_SRC,
> +                                               prefix));
>  }
>  
>  static inline bool
> -pf_addr_test(const struct context *src, const struct mroute_addr *dest, const char *prefix)
> +pf_addr_test(const struct pf_context *src_pf, const struct context *src,
> +             const struct mroute_addr *dest, const char *prefix)
>  {
>      bool pf_addr_test_dowork(const struct context *src, const struct mroute_addr *dest, const char *prefix);
>  
> -    if (src->c2.pf.enabled)
> +    if (src_pf->enabled)
>      {
>          return pf_addr_test_dowork(src, dest, prefix);
>      }
> 

Looks good to me now.

Reviewed-by: Steffan Karger <steffan@...1856...>
Acked-by: Steffan Karger <steffan@...1856...>

-Steffan

