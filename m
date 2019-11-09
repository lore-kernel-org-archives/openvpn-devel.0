References: <20191009143422.9419-1-a@...2181...>
 <20191009143422.9419-10-a@...2181...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <16087503-d310-5aae-94f2-4123fcf7beb3@...2181...>
Date: Sat, 9 Nov 2019 12:46:49 +0100
MIME-Version: 1.0
In-Reply-To: <20191009143422.9419-10-a@...2181...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH 9/9] VLAN: allow user to avoid compiling
 VLAN handling code
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Hi all,

 today, during the hackathon, we discussed whether it makes sense to
allow a user to compile out the VLAN tagging code.

The only reason we could came up with is "binary size". A non-negligible
difference between the openvpn binary with and without VLAN code might
be a meaningful reason for introducing a compile time option.

The following are the output of the 'size' tool on the openvpn binary
without and with VLAN code:

$ size src/openvpn/openvpn
   text	   data	    bss	    dec	    hex	filename
 787428	   7224	   2136	 796788	  c2874	src/openvpn/openvpn


$ size src/openvpn/openvpn
   text	   data	    bss	    dec	    hex	filename
 791598	   7224	   2136	 800958	  c38be	src/openvpn/openvpn

The difference is around 4KB and none of us believes that this is enough
to justify having yet another compile time option.

For the reason explained above, we decided to NACK this patch.


Cheers,


On 09/10/2019 16:34, Antonio Quartulli wrote:
> To handle VLANs a whole lot of code has been introduced.
> However, there are a number of users who may not need this feature and
> would rather preserve disk space.
> 
> Implement a configure knob (--disable-vlan-tagging) to conditionally
> take the entire VLAN code out.
> 
> This patch introduces the conditional by keeping all the logic/ifdefs in
> vlan.h and avoid polluting the rest of code (exception made for
> options.h/c which is really troublesome to deal with).
> 
> Signed-off-by: Antonio Quartulli <a@...2181...>
> ---
>  configure.ac            | 12 ++++++
>  src/openvpn/Makefile.am |  5 ++-
>  src/openvpn/mroute.c    |  6 +--
>  src/openvpn/mroute.h    |  2 +
>  src/openvpn/multi.c     | 10 ++---
>  src/openvpn/options.c   | 15 ++++++++
>  src/openvpn/options.h   |  2 +
>  src/openvpn/vlan.h      | 83 +++++++++++++++++++++++++++++++++++++++++
>  8 files changed, 126 insertions(+), 9 deletions(-)
> 
> diff --git a/configure.ac b/configure.ac
> index c7fd7a84..66d58b91 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -256,6 +256,13 @@ AC_ARG_ENABLE(
>  	[enable_async_push="no"]
>  )
>  
> +AC_ARG_ENABLE(
> +	[vlan-tagging],
> +	[AS_HELP_STRING([--disable-vlan-tagging], [Disble support for 802.1Q-based VLAN tagging])],
> +	,
> +	[enable_vlan="yes"]
> +)
> +
>  AC_ARG_WITH(
>  	[special-build],
>  	[AS_HELP_STRING([--with-special-build=STRING], [specify special build string])],
> @@ -1321,6 +1328,10 @@ if test "${enable_async_push}" = "yes"; then
>  	)
>  fi
>  
> +if test "${enable_vlan}" = "yes"; then
> +   AC_DEFINE(ENABLE_VLAN_TAGGING, 1, [Enable 802.1Q-based VLAN tagging/untagging])
> +fi
> +
>  CONFIGURE_DEFINES="`set | grep '^enable_.*=' ; set | grep '^with_.*='`"
>  AC_DEFINE_UNQUOTED([CONFIGURE_DEFINES], ["`echo ${CONFIGURE_DEFINES}`"], [Configuration settings])
>  
> @@ -1349,6 +1360,7 @@ AC_SUBST([OPTIONAL_PKCS11_HELPER_LIBS])
>  AC_SUBST([PLUGIN_AUTH_PAM_CFLAGS])
>  AC_SUBST([PLUGIN_AUTH_PAM_LIBS])
>  
> +AM_CONDITIONAL([VLAN_TAGGING], [test "${enable_vlan}" = "yes"])
>  AM_CONDITIONAL([WIN32], [test "${WIN32}" = "yes"])
>  AM_CONDITIONAL([GIT_CHECKOUT], [test "${GIT_CHECKOUT}" = "yes"])
>  AM_CONDITIONAL([ENABLE_PLUGIN_AUTH_PAM], [test "${enable_plugin_auth_pam}" = "yes"])
> diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
> index bc976019..64df1df4 100644
> --- a/src/openvpn/Makefile.am
> +++ b/src/openvpn/Makefile.am
> @@ -123,7 +123,7 @@ openvpn_SOURCES = \
>  	syshead.h \
>  	tls_crypt.c tls_crypt.h \
>  	tun.c tun.h \
> -	vlan.c vlan.h \
> +	vlan.h \
>  	win32.h win32.c \
>  	cryptoapi.h cryptoapi.c
>  openvpn_LDADD = \
> @@ -136,6 +136,9 @@ openvpn_LDADD = \
>  	$(OPTIONAL_SELINUX_LIBS) \
>  	$(OPTIONAL_SYSTEMD_LIBS) \
>  	$(OPTIONAL_DL_LIBS)
> +if VLAN_TAGGING
> +openvpn_SOURCES += vlan.c
> +endif
>  if WIN32
>  openvpn_SOURCES += openvpn_win32_resources.rc block_dns.c block_dns.h
>  openvpn_LDADD += -lgdi32 -lws2_32 -lwininet -lcrypt32 -liphlpapi -lwinmm -lfwpuclnt -lrpcrt4 -lncrypt
> diff --git a/src/openvpn/mroute.c b/src/openvpn/mroute.c
> index bdb1b0c0..d6dc8d22 100644
> --- a/src/openvpn/mroute.c
> +++ b/src/openvpn/mroute.c
> @@ -35,6 +35,7 @@
>  #include "proto.h"
>  #include "error.h"
>  #include "socket.h"
> +#include "vlan.h"
>  
>  #include "memdbg.h"
>  
> @@ -256,8 +257,7 @@ mroute_copy_ether_to_addr(struct mroute_addr *maddr,
>      maddr->netbits = 0;
>      maddr->len = OPENVPN_ETH_ALEN;
>      memcpy(maddr->ether.addr, ether_addr, OPENVPN_ETH_ALEN);
> -    maddr->len += sizeof(vid);
> -    maddr->ether.vid = vid;
> +    vlan_maddr_copy_vid(maddr, vid);
>  }
>  
>  unsigned int
> @@ -467,7 +467,7 @@ mroute_addr_print_ex(const struct mroute_addr *ma,
>              case MR_ADDR_ETHER:
>                  buf_printf(&out, "%s", format_hex_ex(ma->ether.addr,
>                                                       sizeof(ma->ether.addr), 0, 1, ":", gc));
> -                buf_printf(&out, "@%hu", ma->ether.vid);
> +                vlan_maddr_print_vid(&out, ma);
>                  break;
>  
>              case MR_ADDR_IPV4:
> diff --git a/src/openvpn/mroute.h b/src/openvpn/mroute.h
> index 113aa8c5..4bbcd61d 100644
> --- a/src/openvpn/mroute.h
> +++ b/src/openvpn/mroute.h
> @@ -84,7 +84,9 @@ struct mroute_addr {
>          uint8_t raw_addr[MR_MAX_ADDR_LEN]; /* actual address */
>          struct {
>              uint8_t addr[OPENVPN_ETH_ALEN];
> +#ifdef ENABLE_VLAN_TAGGING
>              uint16_t vid;
> +#endif
>          } ether;
>          struct {
>              in_addr_t addr;     /* _network order_ IPv4 address */
> diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
> index d594dd25..13e81315 100644
> --- a/src/openvpn/multi.c
> +++ b/src/openvpn/multi.c
> @@ -2260,11 +2260,12 @@ multi_bcast(struct multi_context *m,
>                      }
>                  }
>  #endif /* ifdef ENABLE_PF */
> -                if (vid != 0 && vid != mi->context.options.vlan_pvid)
> +                if (!vlan_match_pvid(vid, &mi->context.options))
>                  {
>                      continue;
>                  }
>                  multi_add_mbuf(m, mi, mb);
> +
>              }
>          }
>  
> @@ -2648,8 +2649,7 @@ multi_process_incoming_link(struct multi_context *m, struct multi_instance *inst
>                  struct mroute_addr edest;
>                  mroute_addr_reset(&edest);
>  #endif
> -
> -                if (m->top.options.vlan_tagging)
> +                if (vlan_is_enabled(&m->top.options))
>                  {
>                      if (vlan_is_tagged(&c->c2.to_tun))
>                      {
> @@ -2659,7 +2659,7 @@ multi_process_incoming_link(struct multi_context *m, struct multi_instance *inst
>                      }
>                      else
>                      {
> -                        vid = c->options.vlan_pvid;
> +                        vid = vlan_get_pvid(&c->options);
>                      }
>                  }
>                  /* extract packet source and dest addresses */
> @@ -2788,7 +2788,7 @@ multi_process_incoming_tun(struct multi_context *m, const unsigned int mpp_flags
>              return true;
>          }
>  
> -        if (dev_type == DEV_TYPE_TAP && m->top.options.vlan_tagging)
> +        if (dev_type == DEV_TYPE_TAP && vlan_is_enabled(&m->top.options))
>          {
>              vid = vlan_decapsulate(&m->top, &m->top.c2.buf);
>              if (vid < 0)
> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
> index 3bcb9063..2c41eeda 100644
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
> @@ -405,9 +405,11 @@ static const char usage_message[] =
>      "--plugin m [str]: Load plug-in module m passing str as an argument\n"
>      "                  to its initialization function.\n"
>  #endif
> +#ifdef ENABLE_VLAN_TAGGING
>      "--vlan-tagging  : Enable 802.1Q-based VLAN tagging.\n"
>      "--vlan-accept tagged|untagged|all : Set VLAN tagging mode. Default is 'all'.\n"
>      "--vlan-pvid v   : Sets the Port VLAN Identifier. Defaults to 1.\n"
> +#endif /* ifdef ENABLE_VLAN_TAGGING */
>  #if P2MP
>  #if P2MP_SERVER
>      "\n"
> @@ -853,8 +855,10 @@ init_options(struct options *o, const bool init_gc)
>      o->route_method = ROUTE_METHOD_ADAPTIVE;
>      o->block_outside_dns = false;
>  #endif
> +#ifdef ENABLE_VLAN_TAGGING
>      o->vlan_accept = VLAN_ALL;
>      o->vlan_pvid = 1;
> +#endif /* ifdef ENABLE_VLAN_TAGGING */
>  #if P2MP_SERVER
>      o->real_hash_size = 256;
>      o->virtual_hash_size = 256;
> @@ -1230,6 +1234,7 @@ dhcp_option_address_parse(const char *name, const char *parm, in_addr_t *array,
>  
>  #endif /* if defined(_WIN32) || defined(TARGET_ANDROID) */
>  
> +#ifdef ENABLE_VLAN_TAGGING
>  static const char *
>  print_vlan_accept(enum vlan_acceptable_frames mode)
>  {
> @@ -1244,6 +1249,7 @@ print_vlan_accept(enum vlan_acceptable_frames mode)
>      }
>      return NULL;
>  }
> +#endif /* ifdef ENABLE_VLAN_TAGGING */
>  
>  #if P2MP
>  
> @@ -1314,9 +1320,11 @@ show_p2mp_parms(const struct options *o)
>      SHOW_STR(port_share_host);
>      SHOW_STR(port_share_port);
>  #endif
> +#ifdef ENABLE_VLAN_TAGGING
>      SHOW_BOOL(vlan_tagging);
>      msg(D_SHOW_PARMS, "  vlan_accept = %s", print_vlan_accept (o->vlan_accept));
>      SHOW_INT(vlan_pvid);
> +#endif /* ifdef ENABLE_VLAN_TAGGING */
>  #endif /* P2MP_SERVER */
>  
>      SHOW_BOOL(client);
> @@ -2380,6 +2388,7 @@ options_postprocess_verify_ce(const struct options *options, const struct connec
>              }
>          }
>  
> +#ifdef ENABLE_VLAN_TAGGING
>          if (options->vlan_tagging && dev != DEV_TYPE_TAP)
>          {
>              msg(M_USAGE, "--vlan-tagging must be used with --dev tap");
> @@ -2395,6 +2404,8 @@ options_postprocess_verify_ce(const struct options *options, const struct connec
>                  msg(M_USAGE, "--vlan-pvid requires --vlan-tagging");
>              }
>          }
> +#endif /* ifdef ENABLE_VLAN_TAGGING */
> +
>      }
>      else
>      {
> @@ -2485,10 +2496,12 @@ options_postprocess_verify_ce(const struct options *options, const struct connec
>              msg(M_USAGE, "--stale-routes-check requires --mode server");
>          }
>  
> +#ifdef ENABLE_VLAN_TAGGING
>          if (options->vlan_tagging)
>          {
>              msg(M_USAGE, "--vlan-tagging requires --mode server");
>          }
> +#endif /* ifdef ENABLE_VLAN_TAGGING */
>      }
>  #endif /* P2MP_SERVER */
>  
> @@ -8404,6 +8417,7 @@ add_option(struct options *options,
>          VERIFY_PERMISSION(OPT_P_GENERAL);
>          options->allow_recursive_routing = true;
>      }
> +#ifdef ENABLE_VLAN_TAGGING
>      else if (streq(p[0], "vlan-tagging") && !p[1])
>      {
>          VERIFY_PERMISSION(OPT_P_GENERAL);
> @@ -8443,6 +8457,7 @@ add_option(struct options *options,
>              goto err;
>          }
>      }
> +#endif /* ifdef ENABLE_VLAN_TAGGING */
>      else
>      {
>          int i;
> diff --git a/src/openvpn/options.h b/src/openvpn/options.h
> index 6f5e1f53..0192bfb0 100644
> --- a/src/openvpn/options.h
> +++ b/src/openvpn/options.h
> @@ -639,9 +639,11 @@ struct options
>      int keying_material_exporter_length;
>  #endif
>  
> +#ifdef ENABLE_VLAN_TAGGING
>      bool vlan_tagging;
>      enum vlan_acceptable_frames vlan_accept;
>      uint16_t vlan_pvid;
> +#endif /* ifdef ENABLE_VLAN_TAGGING */
>  
>      struct pull_filter_list *pull_filter_list;
>  
> diff --git a/src/openvpn/vlan.h b/src/openvpn/vlan.h
> index a67ad0e1..44b3193b 100644
> --- a/src/openvpn/vlan.h
> +++ b/src/openvpn/vlan.h
> @@ -29,11 +29,14 @@
>  
>  #include "buffer.h"
>  #include "mroute.h"
> +#include "options.h"
>  #include "openvpn.h"
>  
>  struct multi_context;
>  struct multi_instance;
>  
> +#ifdef ENABLE_VLAN_TAGGING
> +
>  int16_t
>  vlan_decapsulate(const struct context *c, struct buffer *buf);
>  
> @@ -43,6 +46,86 @@ vlan_is_tagged(const struct buffer *buf);
>  void
>  vlan_process_outgoing_tun(struct multi_context *m, struct multi_instance *mi);
>  
> +static inline bool
> +vlan_is_enabled(struct options *opt)
> +{
> +    return opt->vlan_tagging;
> +}
> +
> +static inline bool
> +vlan_match_pvid(uint16_t vid, struct options *opt)
> +{
> +    return vid != 0 && vid == opt->vlan_pvid;
> +}
> +
> +static inline uint16_t
> +vlan_get_pvid(struct options *opt)
> +{
> +    return opt->vlan_pvid;
> +}
> +
> +static inline void
> +vlan_maddr_copy_vid(struct mroute_addr *maddr, uint16_t vid)
> +{
> +    maddr->len += sizeof(vid);
> +    maddr->ether.vid = vid;
> +}
> +
> +static inline void
> +vlan_maddr_print_vid(struct buffer *out, const struct mroute_addr *maddr)
> +{
> +    buf_printf(out, "@%hu", maddr->ether.vid);
> +}
> +
> +#else
> +
> +static inline int16_t
> +vlan_decapsulate(const struct context *c, struct buffer *buf)
> +{
> +    return 1;
> +}
> +
> +static inline bool
> +vlan_tagged_drop(const struct buffer *buf)
> +{
> +    return false;
> +}
> +
> +static inline void
> +vlan_process_outgoing_tun(struct multi_context *m, struct multi_instance *mi)
> +{
> +}
> +
> +static inline bool
> +vlan_is_enabled(struct options *opt)
> +{
> +    return false;
> +}
> +
> +static inline bool
> +vlan_match_pvid(uint16_t vid, struct options *opt)
> +{
> +    return true;
> +}
> +
> +static inline uint16_t
> +vlan_get_pvid(struct options *opt)
> +{
> +    return 0;
> +}
> +
> +static inline void
> +vlan_maddr_copy_vid(struct mroute_addr *maddr, uint16_t vid)
> +{
> +}
> +
> +static inline void
> +vlan_maddr_print_vid(struct buffer *out, const struct mroute_addr *maddr)
> +{
> +}
> +
> +#endif
> +
>  #endif /* P2MP_SERVER */
>  
>  #endif /* VLAN_H */
> 

-- 
Antonio Quartulli

