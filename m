Message-ID: <64d76726-d294-b93b-e876-df8873727685@...2181...>
Date: Wed, 27 Jul 2022 15:06:23 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <YtmWiHwRXkt/m7Si@...1296...>
 <20220721182425.1569798-1-gert@...1296...>
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <20220721182425.1569798-1-gert@...1296...>
Subject: Re: [Openvpn-devel] [PATCH v11 05/25] dco: introduce
 open_tun_dco_generic() to open dynamic or fixed-name DCO devices
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

Hi,

On 21/07/2022 20:24, Gert Doering wrote:
> From: Antonio Quartulli <a@...2181...>
> 
> This function is similar to the essence of open_tun_generic(), but
> calling open_tun_dco() instead of trying to do a file open on
> "/dev/%s"
> 
> Previous attempts to save code duplication by including this into
> open_tun_generic() created additional #ifdef plus confusing call
> paths.  So this is a clean new function, leaving the door open for
> a cleanup of open_tun_generic().
> 
> Also, introduce tun_dco_enabled(tt) to avoid the negative
> "!tt->options.disable_dco" calls.
> 
> Signed-off-by: Antonio Quartulli <a@...2181...>
> Signed-off-by: Gert Doering <gert@...1296...>

Thanks for providing a new revision of this tremendous patch :-D

> 
> --
> v11:
>    - add new function open_tun_dco_generic() for Linux (and FreeBSD, later)
>      instead of lumping this into open_tun_generic()
>    - pick up tun_dco_enabled() from a later patch in the series
>      (easier to bring this in right now than to convert the code back
>      and then patch it again later)
> ---
>   src/openvpn/init.c    |  24 +++++++-
>   src/openvpn/init.h    |   2 +-
>   src/openvpn/options.c |   7 +++
>   src/openvpn/tun.c     | 129 +++++++++++++++++++++++++++++++++++++-----
>   src/openvpn/tun.h     |   2 +-
>   5 files changed, 147 insertions(+), 17 deletions(-)
> 
> diff --git a/src/openvpn/init.c b/src/openvpn/init.c
> index 1bfbf4eb..779fc4a5 100644
> --- a/src/openvpn/init.c
> +++ b/src/openvpn/init.c
> @@ -1054,7 +1054,7 @@ do_genkey(const struct options *options)
>    * Persistent TUN/TAP device management mode?
>    */
>   bool
> -do_persist_tuntap(const struct options *options, openvpn_net_ctx_t *ctx)
> +do_persist_tuntap(struct options *options, openvpn_net_ctx_t *ctx)
>   {
>       if (options->persist_config)
>       {
> @@ -1069,6 +1069,26 @@ do_persist_tuntap(const struct options *options, openvpn_net_ctx_t *ctx)
>               msg(M_FATAL|M_OPTERR,
>                   "options --mktun or --rmtun should only be used together with --dev");
>           }
> +
> +#if defined(ENABLE_DCO)
> +        if (dco_enabled(options))
> +        {
> +            /* creating a DCO interface via --mktun is not supported as it does not
> +             * make much sense. Since DCO is enabled by default, people may run into
> +             * this without knowing, therefore this case should be properly handled.
> +             *
> +             * Disable DCO if --mktun was provided and print a message to let
> +             * user know.
> +             */
> +            if (dev_type_enum(options->dev, options->dev_type) == DEV_TYPE_TUN)
> +            {
> +                msg(M_WARN, "Note: --mktun does not support DCO. Creating TUN interface.");
> +            }
> +
> +            options->tuntap_options.disable_dco = true;
> +        }
> +#endif
> +
>   #ifdef ENABLE_FEATURE_TUN_PERSIST
>           tuncfg(options->dev, options->dev_type, options->dev_node,
>                  options->persist_mode,
> @@ -1763,7 +1783,7 @@ do_open_tun(struct context *c)
>   #endif
>       /* open the tun device */
>       open_tun(c->options.dev, c->options.dev_type, c->options.dev_node,
> -             c->c1.tuntap);
> +             c->c1.tuntap, &c->net_ctx);
>   
>       /* set the hardware address */
>       if (c->options.lladdr)
> diff --git a/src/openvpn/init.h b/src/openvpn/init.h
> index 2b8c2dcc..5f412a33 100644
> --- a/src/openvpn/init.h
> +++ b/src/openvpn/init.h
> @@ -56,7 +56,7 @@ bool print_openssl_info(const struct options *options);
>   
>   bool do_genkey(const struct options *options);
>   
> -bool do_persist_tuntap(const struct options *options, openvpn_net_ctx_t *ctx);
> +bool do_persist_tuntap(struct options *options, openvpn_net_ctx_t *ctx);
>   
>   bool possibly_become_daemon(const struct options *options);
>   
> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
> index b00acf7e..87d6fc31 100644
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
> @@ -3667,6 +3667,13 @@ options_postprocess_mutate(struct options *o, struct env_set *es)
>       o->tuntap_options.disable_dco = !dco_check_option_conflict(D_DCO, o);
>   #endif
>   
> +    if (dco_enabled(o) && o->dev_node)
> +    {
> +        msg(M_WARN, "Note: ignoring --dev-node as it has no effect when using "
> +            "data channel offload");
> +        o->dev_node = NULL;
> +    }
> +
>       /*
>        * Save certain parms before modifying options during connect, especially
>        * when using --pull
> diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
> index 3f9aa6ae..30abfdd1 100644
> --- a/src/openvpn/tun.c
> +++ b/src/openvpn/tun.c
> @@ -37,6 +37,7 @@
>   
>   #include "syshead.h"
>   
> +#include "openvpn.h"
>   #include "tun.h"
>   #include "fdmisc.h"
>   #include "common.h"
> @@ -1723,6 +1724,15 @@ tun_name_is_fixed(const char *dev)
>       return has_digit(dev);
>   }
>   
> +#if defined(TARGET_LINUX)
> +static bool
> +tun_dco_enabled(struct tuntap *tt)
> +{
> +    return !tt->options.disable_dco;
> +}
> +#endif
> +
> +
>   #if !(defined(_WIN32) || defined(TARGET_LINUX))
>   static void
>   open_tun_generic(const char *dev, const char *dev_type, const char *dev_node,
> @@ -1831,6 +1841,76 @@ open_tun_generic(const char *dev, const char *dev_type, const char *dev_node,
>   }
>   #endif /* !_WIN32 && !TARGET_LINUX */
>   
> +#if defined(TARGET_LINUX)
> +static void
> +open_tun_dco_generic(const char *dev, const char *dev_type,
> +                     struct tuntap *tt, openvpn_net_ctx_t *ctx)
> +{
> +    char dynamic_name[256];
> +    bool dynamic_opened = false;
> +
> +    if (tt->type == DEV_TYPE_NULL)
> +    {
> +        open_null(tt);
> +        return;
> +    }
> +
> +    /*
> +     * dynamic open is indicated by --dev specified without
> +     * explicit unit number.  Try opening /dev/[dev]n

I guess "/dev/[dev]n" should just be "[dev]n" ?

> +     * where n = [0, 255].
> +     */
> +
> +    if (!tun_name_is_fixed(dev))
> +    {
> +        for (int i = 0; i < 256; ++i)
> +        {
> +            openvpn_snprintf(dynamic_name, sizeof(dynamic_name),
> +                             "%s%d", dev, i);
> +            if (open_tun_dco(tt, ctx, dynamic_name) == 0)
> +            {
> +                dynamic_opened = true;
> +                msg(M_INFO, "DCO device %s opened", dynamic_name);
> +                break;
> +            }
> +            msg(D_READ_WRITE | M_ERRNO, "Tried opening %s (failed)", dynamic_name);
> +        }
> +        if (!dynamic_opened)
> +        {
> +            msg(M_FATAL, "Cannot allocate DCO dev dynamically");
> +        }
> +        /* tt->actual_name is passed to up and down scripts and used as
> +         * the ifconfig dev name */
> +        tt->actual_name = string_alloc(dynamic_name, NULL);
> +    }
> +    /*
> +     * explicit unit number specified
> +     */
> +    else
> +    {
> +        int ret = open_tun_dco(tt, ctx, dev);
> +        if (ret == -EEXIST)
> +        {
> +            msg(M_INFO, "DCO device %s already exists, won't be destroyed at shutdown",
> +                dev);
> +            tt->persistent_if = true;
> +        }
> +        else if (ret < 0)
> +        {
> +            msg(M_ERR, "Cannot open DCO device %s: %s (%d)", dev,
> +                strerror(-ret), ret);
> +        }
> +        else
> +        {
> +            msg(M_INFO, "DCO device %s opened", dev);
> +        }
> +
> +        /* tt->actual_name is passed to up and down scripts and used as the ifconfig dev name */
> +        tt->actual_name = string_alloc(dev, NULL);
> +    }
> +}
> +#endif /* TARGET_LINUX */
> +
>   #if !defined(_WIN32)
>   static void
>   close_tun_generic(struct tuntap *tt)
> @@ -1847,7 +1927,8 @@ close_tun_generic(struct tuntap *tt)
>   
>   #if defined (TARGET_ANDROID)
>   void
> -open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tuntap *tt)
> +open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tuntap *tt,
> +         openvpn_net_ctx_t *ctx)
>   {
>   #define ANDROID_TUNNAME "vpnservice-tun"
>       struct user_pass up;
> @@ -1944,7 +2025,8 @@ read_tun(struct tuntap *tt, uint8_t *buf, int len)
>   #if !PEDANTIC
>   
>   void
> -open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tuntap *tt)
> +open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tuntap *tt,
> +         openvpn_net_ctx_t *ctx)
>   {
>       struct ifreq ifr;
>   
> @@ -1955,6 +2037,10 @@ open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tun
>       {
>           open_null(tt);
>       }
> +    else if (tun_dco_enabled(tt))
> +    {
> +        open_tun_dco_generic(dev, dev_type, tt, ctx);
> +    }
>       else
>       {
>           /*
> @@ -2061,7 +2147,8 @@ open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tun
>   #else  /* if !PEDANTIC */
>   
>   void
> -open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tuntap *tt)
> +open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tuntap *tt,
> +         openvpn_net_ctx_t *ctx)
>   {
>       ASSERT(0);
>   }
> @@ -2086,7 +2173,8 @@ tuncfg(const char *dev, const char *dev_type, const char *dev_node,
>       clear_tuntap(tt);
>       tt->type = dev_type_enum(dev, dev_type);
>       tt->options = *options;
> -    open_tun(dev, dev_type, dev_node, tt);
> +
> +    open_tun(dev, dev_type, dev_node, tt, ctx);
>       if (ioctl(tt->fd, TUNSETPERSIST, persist_mode) < 0)
>       {
>           msg(M_ERR, "Cannot ioctl TUNSETPERSIST(%d) %s", persist_mode, dev);
> @@ -2204,6 +2292,12 @@ close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx)
>           net_ctx_reset(ctx);
>       }
>   
> +#ifdef TARGET_LINUX
> +    if (tun_dco_enabled(tt))
> +    {
> +        close_tun_dco(tt, ctx);
> +    }
> +#endif
>       close_tun_generic(tt);
>       free(tt);
>   }
> @@ -2227,7 +2321,8 @@ read_tun(struct tuntap *tt, uint8_t *buf, int len)
>   #endif
>   
>   void
> -open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tuntap *tt)
> +open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tuntap *tt,
> +         openvpn_net_ctx_t *ctx)
>   {
>       int if_fd, ip_muxid, arp_muxid, arp_fd, ppa = -1;
>       struct lifreq ifr;
> @@ -2579,7 +2674,8 @@ read_tun(struct tuntap *tt, uint8_t *buf, int len)
>   #elif defined(TARGET_OPENBSD)
>   
>   void
> -open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tuntap *tt)
> +open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tuntap *tt,
> +         openvpn_net_ctx_t *ctx)
>   {
>       open_tun_generic(dev, dev_type, dev_node, true, tt);
>   
> @@ -2673,7 +2769,8 @@ read_tun(struct tuntap *tt, uint8_t *buf, int len)
>    */
>   
>   void
> -open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tuntap *tt)
> +open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tuntap *tt,
> +         openvpn_net_ctx_t *ctx)
>   {
>       open_tun_generic(dev, dev_type, dev_node, true, tt);
>   
> @@ -2813,7 +2910,8 @@ freebsd_modify_read_write_return(int len)
>   }
>   
>   void
> -open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tuntap *tt)
> +open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tuntap *tt,
> +         openvpn_net_ctx_t *ctx)
>   {
>       open_tun_generic(dev, dev_type, dev_node, true, tt);
>   
> @@ -2941,7 +3039,8 @@ dragonfly_modify_read_write_return(int len)
>   }
>   
>   void
> -open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tuntap *tt)
> +open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tuntap *tt,
> +         openvpn_net_ctx_t *ctx)
>   {
>       open_tun_generic(dev, dev_type, dev_node, true, tt);
>   
> @@ -3169,7 +3268,8 @@ open_darwin_utun(const char *dev, const char *dev_type, const char *dev_node, st
>   #endif /* ifdef HAVE_NET_IF_UTUN_H */
>   
>   void
> -open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tuntap *tt)
> +open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tuntap *tt,
> +         openvpn_net_ctx_t *ctx)
>   {
>   #ifdef HAVE_NET_IF_UTUN_H
>       /* If dev_node does not start start with utun assume regular tun/tap */
> @@ -3276,7 +3376,8 @@ read_tun(struct tuntap *tt, uint8_t *buf, int len)
>   #elif defined(TARGET_AIX)
>   
>   void
> -open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tuntap *tt)
> +open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tuntap *tt,
> +         openvpn_net_ctx_t *ctx)
>   {
>       char tunname[256];
>       char dynamic_name[20];
> @@ -6585,7 +6686,8 @@ tuntap_post_open(struct tuntap *tt, const char *device_guid)
>   }
>   
>   void
> -open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tuntap *tt)
> +open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tuntap *tt,
> +         openvpn_net_ctx_t *ctx)
>   {
>       const char *device_guid = NULL;
>   
> @@ -6894,7 +6996,8 @@ ipset2ascii_all(struct gc_arena *gc)
>   #else /* generic */
>   
>   void
> -open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tuntap *tt)
> +open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tuntap *tt,
> +         openvpn_net_ctx_t *ctx)
>   {
>       open_tun_generic(dev, dev_type, dev_node, true, tt);
>   }
> diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h
> index b7786f46..8ec8f51f 100644
> --- a/src/openvpn/tun.h
> +++ b/src/openvpn/tun.h
> @@ -249,7 +249,7 @@ tuntap_ring_empty(struct tuntap *tt)
>    */
>   
>   void open_tun(const char *dev, const char *dev_type, const char *dev_node,
> -              struct tuntap *tt);
> +              struct tuntap *tt, openvpn_net_ctx_t *ctx);
>   
>   void close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx);
>   

The rest looks good!

Basically the code is the same but it was moved out to a separate 
functon in order to avoid more ifdefs ugliness. We are now duplicating 
the loop that creates the varios devX strings, but we can live with that.

Not sure my own ACK makes sense, but FWIW:

Acked-by: Antonio Quartulli <a@...2181...>


-- 
Antonio Quartulli

