MIME-Version: 1.0
In-Reply-To: <1474104227-13974-1-git-send-email-arne@...1227...>
References: <20160916161354.GM78279@...1296...>
	<1474104227-13974-1-git-send-email-arne@...1227...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Sat, 17 Sep 2016 14:40:35 +0500
Message-ID: <CAFHpkQGHJxm8kb=3JDwaUk7HK4v-s2qyUCi=TQBU9xPWGpTeBg@...278...>
Content-Type: multipart/alternative; boundary=089e0141a202efbd76053cb0de0a
Subject: Re: [Openvpn-devel] [[PATCH v2]] Remove tun-ipv6 Option. Instead
 assume that IPv6 is always supported.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--089e0141a202efbd76053cb0de0a
Content-Type: text/plain; charset=UTF-8

funny enough, neither Azure, nor GCP are running ipv6.
well, GCP images are compiled with ipv6 support actually.

2016-09-17 14:23 GMT+05:00 Arne Schwabe <arne@...1227...>:

> This option was useful when Ipv6 tun support was non standard and was an
> internal/user specified flag that tracked the Ipv6 capability of the tun
> device.
>
> All supported OS support IPv6. Also tun-ipv6 is pushable by the remote so
> not putting tun-ipv6 does not forbid ipv6 addresses.
>
> This commit also clean up a bit of the ipv6 related tun.c. Changes for
> most platforms are minimal.
>
> For linux a bit more cleanup is done:
>
> - Remove compatibility defines that were added 2008
> - Always use IFF_NO_PI for the linux tun and not only for IPv4 only tun
> setups (Android also always IFF_NO_PI works fine with Ipv6).
>
> This commit also remove a non ipv6 fallback for tap driver from OpenVPN
> 2.2-beta or earlier and only warns.
>
> Patch V2: Integrate Gert's comments
> ---
>  src/openvpn/helper.c  |   2 -
>  src/openvpn/init.c    |   7 +---
>  src/openvpn/multi.c   |   8 ++--
>  src/openvpn/options.c |  11 +----
>  src/openvpn/options.h |   1 -
>  src/openvpn/route.c   |  13 ++----
>  src/openvpn/tun.c     | 110 ++++++++++--------------------
> --------------------
>  src/openvpn/tun.h     |   2 -
>  8 files changed, 30 insertions(+), 124 deletions(-)
>
> diff --git a/src/openvpn/helper.c b/src/openvpn/helper.c
> index 62f88ec..229523d 100644
> --- a/src/openvpn/helper.c
> +++ b/src/openvpn/helper.c
> @@ -200,8 +200,6 @@ helper_client_server (struct options *o)
>                 add_in6_addr( o->server_network_ipv6, 0x1000 );
>         o->ifconfig_ipv6_pool_netbits = o->server_netbits_ipv6;
>
> -       o->tun_ipv6 = true;
> -
>         push_option( o, "tun-ipv6", M_USAGE );
>       }
>
> diff --git a/src/openvpn/init.c b/src/openvpn/init.c
> index 9236a9f..e9eb6c7 100644
> --- a/src/openvpn/init.c
> +++ b/src/openvpn/init.c
> @@ -1400,9 +1400,6 @@ do_init_tun (struct context *c)
>                            !c->options.ifconfig_nowarn,
>                            c->c2.es);
>
> -  /* flag tunnel for IPv6 config if --tun-ipv6 is set */
> -  c->c1.tuntap->ipv6 = c->options.tun_ipv6;
> -
>    init_tun_post (c->c1.tuntap,
>                  &c->c2.frame,
>                  &c->options.tuntap_options);
> @@ -1420,8 +1417,8 @@ do_open_tun (struct context *c)
>    struct gc_arena gc = gc_new ();
>    bool ret = false;
>
> -  c->c2.ipv4_tun = (!c->options.tun_ipv6
> -                   && is_dev_type (c->options.dev, c->options.dev_type,
> "tun"));
> +  //c->c2.ipv4_tun = (!c->options.tun_ipv6
> + //                && is_dev_type (c->options.dev, c->options.dev_type,
> "tun"));
>
>  #ifndef TARGET_ANDROID
>    if (!c->c1.tuntap)
> diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
> index ba7f2c0..228b393 100644
> --- a/src/openvpn/multi.c
> +++ b/src/openvpn/multi.c
> @@ -1377,8 +1377,7 @@ multi_select_virtual_addr (struct multi_context *m,
> struct multi_instance *mi)
>         * (see below) so issue a warning if that happens - don't break the
>         * session, though, as we don't even know if this client WANTS IPv6
>         */
> -      if ( mi->context.c1.tuntap->ipv6 &&
> -          mi->context.options.ifconfig_ipv6_pool_defined &&
> +      if ( mi->context.options.ifconfig_ipv6_pool_defined &&
>            ! mi->context.options.push_ifconfig_ipv6_defined )
>         {
>           msg( M_INFO, "MULTI_sva: WARNING: if --ifconfig-push is used for
> IPv4, automatic IPv6 assignment from --ifconfig-ipv6-pool does not work.
> Use --ifconfig-ipv6-push for IPv6 then." );
> @@ -1451,8 +1450,7 @@ multi_select_virtual_addr (struct multi_context *m,
> struct multi_instance *mi)
>     * way round ("dynamic IPv4, static IPv6") or "both static" makes sense
>     * -> and so it's implemented right now
>     */
> -  if ( mi->context.c1.tuntap->ipv6 &&
> -       mi->context.options.push_ifconfig_ipv6_defined )
> +  if ( mi->context.options.push_ifconfig_ipv6_defined )
>      {
>        mi->context.c2.push_ifconfig_ipv6_local =
>             mi->context.options.push_ifconfig_ipv6_local;
> @@ -1510,7 +1508,7 @@ multi_set_virtual_addr_env (struct multi_context *m,
> struct multi_instance *mi)
>    setenv_del (mi->context.c2.es, "ifconfig_pool_remote_ip6");
>    setenv_del (mi->context.c2.es, "ifconfig_pool_ip6_netbits");
>
> -  if (mi->context.c1.tuntap->ipv6 && mi->context.c2.push_ifconfig_
> ipv6_defined)
> +  if (mi->context.c2.push_ifconfig_ipv6_defined)
>      {
>        setenv_in6_addr (mi->context.c2.es,
>                         "ifconfig_pool_remote",
> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
> index e052042..0bab660 100644
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
> @@ -1496,7 +1496,6 @@ show_settings (const struct options *o)
>    SHOW_STR (dev_node);
>    SHOW_STR (lladdr);
>    SHOW_INT (topology);
> -  SHOW_BOOL (tun_ipv6);
>    SHOW_STR (ifconfig_local);
>    SHOW_STR (ifconfig_remote_netmask);
>    SHOW_BOOL (ifconfig_noexec);
> @@ -2099,10 +2098,6 @@ options_postprocess_verify_ce (const struct options
> *options, const struct conne
>                    options->connection_list->array[0]->remote)
>            msg (M_USAGE, "<connection> cannot be used with --mode server");
>
> -#if 0
> -      if (options->tun_ipv6)
> -       msg (M_USAGE, "--tun-ipv6 cannot be used with --mode server");
> -#endif
>        if (options->shaper)
>         msg (M_USAGE, "--shaper cannot be used with --mode server");
>        if (options->inetd)
> @@ -2126,9 +2121,6 @@ options_postprocess_verify_ce (const struct options
> *options, const struct conne
>         msg (M_USAGE, "--ifconfig-pool-persist must be used with
> --ifconfig-pool");
>        if (options->ifconfig_ipv6_pool_defined &&
> !options->ifconfig_ipv6_local )
>         msg (M_USAGE, "--ifconfig-ipv6-pool needs --ifconfig-ipv6");
> -      if (options->ifconfig_ipv6_local && !options->tun_ipv6 )
> -       msg (M_INFO, "Warning: --ifconfig-ipv6 without --tun-ipv6 will not
> do IPv6");
> -
>        if (options->auth_user_pass_file)
>         msg (M_USAGE, "--auth-user-pass cannot be used with --mode server
> (it should be used on the client side only)");
>        if (options->ccd_exclusive && !options->client_config_dir)
> @@ -3077,7 +3069,7 @@ options_string (const struct options *o,
>    /* send tun_ipv6 only in peer2peer mode - in client/server mode, it
>     * is usually pushed by the server, triggering a non-helpful warning
>     */
> -  if (o->tun_ipv6 && o->mode == MODE_POINT_TO_POINT && !PULL_DEFINED(o))
> +  if (o->ifconfig_ipv6_local && o->mode == MODE_POINT_TO_POINT &&
> !PULL_DEFINED(o))
>      buf_printf (&out, ",tun-ipv6");
>
>    /*
> @@ -4578,7 +4570,6 @@ add_option (struct options *options,
>    else if (streq (p[0], "tun-ipv6") && !p[1])
>      {
>        VERIFY_PERMISSION (OPT_P_UP);
> -      options->tun_ipv6 = true;
>      }
>  #ifdef ENABLE_IPROUTE
>    else if (streq (p[0], "iproute") && p[1] && !p[2])
> diff --git a/src/openvpn/options.h b/src/openvpn/options.h
> index 9b7b57c..b7453a0 100644
> --- a/src/openvpn/options.h
> +++ b/src/openvpn/options.h
> @@ -251,7 +251,6 @@ struct options
>    int ping_send_timeout;        /* Send a TCP/UDP ping to remote every n
> seconds */
>    int ping_rec_timeout;         /* Expect a TCP/UDP ping from remote at
> least once every n seconds */
>    bool ping_timer_remote;       /* Run ping timer only if we have a
> remote address */
> -  bool tun_ipv6;                /* Build tun dev that supports IPv6 */
>
>  # define PING_UNDEF   0
>  # define PING_EXIT    1
> diff --git a/src/openvpn/route.c b/src/openvpn/route.c
> index 85aec71..82855d6 100644
> --- a/src/openvpn/route.c
> +++ b/src/openvpn/route.c
> @@ -1729,10 +1729,10 @@ add_route_ipv6 (struct route_ipv6 *r6, const
> struct tuntap *tt, unsigned int fla
>      }
>  #endif
>
> -  if ( !tt->ipv6 )
> +  if (!tt->did_ifconfig_ipv6_setup)
>      {
> -      msg( M_INFO, "add_route_ipv6(): not adding %s/%d, no IPv6 on if %s",
> -                   network, r6->netbits, device );
> +      msg( M_INFO, "add_route_ipv6(): not adding %s/%d, no IPv6 ifconfig
> on if %s",
> +                   network, r6->netbits, device);
>        return;
>      }
>
> @@ -2159,13 +2159,6 @@ delete_route_ipv6 (const struct route_ipv6 *r6,
> const struct tuntap *tt, unsigne
>      }
>  #endif
>
> -  if ( !tt->ipv6 )
> -    {
> -      msg( M_INFO, "delete_route_ipv6(): not deleting %s/%d, no IPv6 on
> if %s",
> -                   network, r6->netbits, device );
> -      return;
> -    }
> -
>    msg( M_INFO, "delete_route_ipv6(%s/%d)", network, r6->netbits );
>
>    /* if we used a gateway on "add route", we also need to specify it on
> diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
> index b7a29f7..2fbb33c 100644
> --- a/src/openvpn/tun.c
> +++ b/src/openvpn/tun.c
> @@ -741,8 +741,8 @@ do_ifconfig (struct tuntap *tt,
>
>        argv_init (&argv);
>
> -      msg( M_INFO, "do_ifconfig, tt->ipv6=%d,
> tt->did_ifconfig_ipv6_setup=%d",
> -                  tt->ipv6, tt->did_ifconfig_ipv6_setup );
> +      msg( M_INFO, "do_ifconfig, tt->did_ifconfig_ipv6_setup=%d",
> +                   tt->did_ifconfig_ipv6_setup );
>
>        /*
>         * We only handle TUN/TAP devices here, not --dev null devices.
> @@ -755,7 +755,7 @@ do_ifconfig (struct tuntap *tt,
>        ifconfig_local = print_in_addr_t (tt->local, 0, &gc);
>        ifconfig_remote_netmask = print_in_addr_t (tt->remote_netmask, 0,
> &gc);
>
> -      if ( tt->ipv6 && tt->did_ifconfig_ipv6_setup )
> +      if (tt->did_ifconfig_ipv6_setup )
>          {
>           ifconfig_ipv6_local = print_in6_addr (tt->local_ipv6, 0, &gc);
>           ifconfig_ipv6_remote = print_in6_addr (tt->remote_ipv6, 0, &gc);
> @@ -1127,6 +1127,8 @@ do_ifconfig (struct tuntap *tt,
>        if ( do_ipv6 )
>         {
>  #ifdef NETBSD_MULTI_AF
> +#error no IPv6 support for tun interfaces on NetBSD before 4.0, upgrade
> your system.
> +#endif
>           argv_printf (&argv,
>                           "%s %s inet6 %s/%d",
>                           IFCONFIG_PATH,
> @@ -1139,10 +1141,6 @@ do_ifconfig (struct tuntap *tt,
>
>           /* and, hooray, we explicitely need to add a route... */
>           add_route_connected_v6_net(tt, es);
> -#else
> -         msg( M_INFO, "no IPv6 support for tun interfaces on NetBSD
> before 4.0 (if your system is newer, recompile openvpn)" );
> -         tt->ipv6 = false;
> -#endif
>         }
>        tt->did_ifconfig = true;
>
> @@ -1425,7 +1423,6 @@ clear_tuntap (struct tuntap *tuntap)
>  #ifdef TARGET_SOLARIS
>    tuntap->ip_fd = -1;
>  #endif
> -  tuntap->ipv6 = false;
>  }
>
>  static void
> @@ -1478,7 +1475,7 @@ write_tun_header (struct tuntap* tt, uint8_t *buf,
> int len)
>
>          iph = (struct ip *) buf;
>
> -        if (tt->ipv6 && iph->ip_v == 6)
> +        if (iph->ip_v == 6)
>              type = htonl (AF_INET6);
>          else
>              type = htonl (AF_INET);
> @@ -1526,7 +1523,7 @@ open_tun_generic (const char *dev, const char
> *dev_type, const char *dev_node,
>    bool dynamic_opened = false;
>
>
> -  if ( tt->ipv6 && ! ipv6_explicitly_supported )
> +  if (  ! ipv6_explicitly_supported )
>      msg (M_WARN, "NOTE: explicit support for IPv6 tun devices is not
> provided for this OS");
>
>    if (tt->type == DEV_TYPE_NULL)
> @@ -1710,7 +1707,6 @@ read_tun (struct tuntap* tt, uint8_t *buf, int len)
>  }
>
>  #elif defined(TARGET_LINUX)
> -#ifdef HAVE_LINUX_IF_TUN_H     /* New driver support */
>
>  #ifndef HAVE_LINUX_SOCKIOS_H
>  #error header file linux/sockios.h required
> @@ -1751,8 +1747,7 @@ open_tun (const char *dev, const char *dev_type,
> const char *dev_node, struct tu
>         * Process --tun-ipv6
>         */
>        CLEAR (ifr);
> -      if (!tt->ipv6)
> -       ifr.ifr_flags = IFF_NO_PI;
> +      ifr.ifr_flags = IFF_NO_PI;
>
>  #if defined(IFF_ONE_QUEUE) && defined(SIOCSIFTXQLEN)
>        ifr.ifr_flags |= IFF_ONE_QUEUE;
> @@ -1833,32 +1828,10 @@ open_tun (const char *dev, const char *dev_type,
> const char *dev_node, struct tu
>    ASSERT (0);
>  }
>
> -#endif
> -
> -#else
> -
> -void
> -open_tun (const char *dev, const char *dev_type, const char *dev_node,
> struct tuntap *tt)
> -{
> -  open_tun_generic (dev, dev_type, dev_node, false, true, tt);
> -}
> -
> -#endif /* HAVE_LINUX_IF_TUN_H */
> +#endif /* !PENDANTIC */
>
>  #ifdef ENABLE_FEATURE_TUN_PERSIST
>
> -/*
> - * This can be removed in future
> - * when all systems will use newer
> - * linux-headers
> - */
> -#ifndef TUNSETOWNER
> -#define TUNSETOWNER    _IOW('T', 204, int)
> -#endif
> -#ifndef TUNSETGROUP
> -#define TUNSETGROUP    _IOW('T', 206, int)
> -#endif
> -
>  void
>  tuncfg (const char *dev, const char *dev_type, const char *dev_node, int
> persist_mode, const char *username, const char *groupname, const struct
> tuntap_options *options)
>  {
> @@ -1940,7 +1913,7 @@ close_tun (struct tuntap *tt)
>             argv_msg (M_INFO, &argv);
>             openvpn_execve_check (&argv, NULL, 0, "Linux ip addr del
> failed");
>
> -            if (tt->ipv6 && tt->did_ifconfig_ipv6_setup)
> +            if (tt->did_ifconfig_ipv6_setup)
>                {
>                  const char * ifconfig_ipv6_local = print_in6_addr
> (tt->local_ipv6, 0, &gc);
>
> @@ -1977,53 +1950,13 @@ close_tun (struct tuntap *tt)
>  int
>  write_tun (struct tuntap* tt, uint8_t *buf, int len)
>  {
> -  if (tt->ipv6)
> -    {
> -      struct tun_pi pi;
> -      struct iphdr *iph;
> -      struct iovec vect[2];
> -      int ret;
> -
> -      iph = (struct iphdr *)buf;
> -
> -      pi.flags = 0;
> -
> -      if(iph->version == 6)
> -       pi.proto = htons(OPENVPN_ETH_P_IPV6);
> -      else
> -       pi.proto = htons(OPENVPN_ETH_P_IPV4);
> -
> -      vect[0].iov_len = sizeof(pi);
> -      vect[0].iov_base = &pi;
> -      vect[1].iov_len = len;
> -      vect[1].iov_base = buf;
> -
> -      ret = writev(tt->fd, vect, 2);
> -      return(ret - sizeof(pi));
> -    }
> -  else
> -    return write (tt->fd, buf, len);
> +  return write (tt->fd, buf, len);
>  }
>
>  int
>  read_tun (struct tuntap* tt, uint8_t *buf, int len)
>  {
> -  if (tt->ipv6)
> -    {
> -      struct iovec vect[2];
> -      struct tun_pi pi;
> -      int ret;
> -
> -      vect[0].iov_len = sizeof(pi);
> -      vect[0].iov_base = &pi;
> -      vect[1].iov_len = len;
> -      vect[1].iov_base = buf;
> -
> -      ret = readv(tt->fd, vect, 2);
> -      return(ret - sizeof(pi));
> -    }
> -  else
> -    return read (tt->fd, buf, len);
> +  return read (tt->fd, buf, len);
>  }
>
>  #elif defined(TARGET_SOLARIS)
> @@ -2227,7 +2160,7 @@ solaris_close_tun (struct tuntap *tt)
>    if (tt)
>      {
>        /* IPv6 interfaces need to be 'manually' de-configured */
> -      if ( tt->ipv6 && tt->did_ifconfig_ipv6_setup )
> +      if ( tt->did_ifconfig_ipv6_setup )
>         {
>           struct argv argv;
>           argv_init (&argv);
> @@ -2518,7 +2451,7 @@ write_tun (struct tuntap* tt, uint8_t *buf, int len)
>
>        iph = (struct openvpn_iphdr *) buf;
>
> -      if (tt->ipv6 && OPENVPN_IPH_GET_VER(iph->version_len) == 6)
> +      if (OPENVPN_IPH_GET_VER(iph->version_len) == 6)
>          type = htonl (AF_INET6);
>        else
>          type = htonl (AF_INET);
> @@ -2644,7 +2577,7 @@ write_tun (struct tuntap* tt, uint8_t *buf, int len)
>
>        iph = (struct ip *) buf;
>
> -      if (tt->ipv6 && iph->ip_v == 6)
> +      if (iph->ip_v == 6)
>          type = htonl (AF_INET6);
>        else
>          type = htonl (AF_INET);
> @@ -2727,7 +2660,7 @@ write_tun (struct tuntap* tt, uint8_t *buf, int len)
>
>        iph = (struct ip *) buf;
>
> -      if (tt->ipv6 && iph->ip_v == 6)
> +      if (iph->ip_v == 6)
>          type = htonl (AF_INET6);
>        else
>          type = htonl (AF_INET);
> @@ -2954,7 +2887,7 @@ close_tun (struct tuntap* tt)
>        struct argv argv;
>        argv_init (&argv);
>
> -      if ( tt->ipv6 && tt->did_ifconfig_ipv6_setup )
> +      if (tt->did_ifconfig_ipv6_setup )
>         {
>           const char * ifconfig_ipv6_local =
>                                 print_in6_addr (tt->local_ipv6, 0, &gc);
> @@ -5182,7 +5115,7 @@ open_tun (const char *dev, const char *dev_type,
> const char *dev_node, struct tu
>
>    /*netcmd_semaphore_lock ();*/
>
> -  msg( M_INFO, "open_tun, tt->ipv6=%d", tt->ipv6 );
> +  msg( M_INFO, "open_tun");
>
>    if (tt->type == DEV_TYPE_NULL)
>      {
> @@ -5308,11 +5241,10 @@ open_tun (const char *dev, const char *dev_type,
> const char *dev_node, struct tu
>      /* usage of numeric constants is ugly, but this is really tied to
>       * *this* version of the driver
>       */
> -    if ( tt->ipv6 && tt->type == DEV_TYPE_TUN &&
> +    if (tt->type == DEV_TYPE_TUN &&
>           info[0] == 9 && info[1] < 8)
>        {
> -       msg( M_INFO, "WARNING:  Tap-Win32 driver version %d.%d does not
> support IPv6 in TUN mode.  IPv6 will be disabled.  Upgrade to Tap-Win32 9.8
> (2.2-beta3 release or later) or use TAP mode to get IPv6", (int) info[0],
> (int) info[1] );
> -       tt->ipv6 = false;
> +       msg( M_INFO, "WARNING:  Tap-Win32 driver version %d.%d does not
> support IPv6 in TUN mode.  IPv6 will not work.  Upgrade to Tap-Win32 9.8
> (2.2-beta3 release or later) or use TAP mode to get IPv6", (int) info[0],
> (int) info[1] );
>        }
>
>      /* tap driver 9.8 (2.2.0 and 2.2.1 release) is buggy
> @@ -5653,7 +5585,7 @@ close_tun (struct tuntap *tt)
>
>    if (tt)
>      {
> -      if ( tt->ipv6 && tt->did_ifconfig_ipv6_setup )
> +      if ( tt->did_ifconfig_ipv6_setup )
>          {
>            if (tt->options.msg_channel)
>              {
> diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h
> index 4e93a3f..88431fb 100644
> --- a/src/openvpn/tun.h
> +++ b/src/openvpn/tun.h
> @@ -139,8 +139,6 @@ struct tuntap
>    bool did_ifconfig_ipv6_setup;
>    bool did_ifconfig;
>
> -  bool ipv6;
> -
>    bool persistent_if;          /* if existed before, keep on program end
> */
>
>    struct tuntap_options options; /* options set on command line */
> --
> 2.8.4 (Apple Git-73)
>
>
> ------------------------------------------------------------
> ------------------
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>

--089e0141a202efbd76053cb0de0a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>funny enough, neither Azure, nor GCP are running ipv6=
.<br></div>well, GCP images are compiled with ipv6 support actually.<br></d=
iv><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">2016-09-17 14:=
23 GMT+05:00 Arne Schwabe <span dir=3D"ltr">&lt;<a href=3D"mailto:arne@...1386...=
227..." target=3D"_blank">arne@...1227...</a>&gt;</span>:<br><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;p=
adding-left:1ex">This option was useful when Ipv6 tun support was non stand=
ard and was an internal/user specified flag that tracked the Ipv6 capabilit=
y of the tun device.<br>
<br>
All supported OS support IPv6. Also tun-ipv6 is pushable by the remote so n=
ot putting tun-ipv6 does not forbid ipv6 addresses.<br>
<br>
This commit also clean up a bit of the ipv6 related tun.c. Changes for most=
 platforms are minimal.<br>
<br>
For linux a bit more cleanup is done:<br>
<br>
- Remove compatibility defines that were added 2008<br>
- Always use IFF_NO_PI for the linux tun and not only for IPv4 only tun set=
ups (Android also always IFF_NO_PI works fine with Ipv6).<br>
<br>
This commit also remove a non ipv6 fallback for tap driver from OpenVPN 2.2=
-beta or earlier and only warns.<br>
<br>
Patch V2: Integrate Gert&#39;s comments<br>
---<br>
=C2=A0src/openvpn/helper.c=C2=A0 |=C2=A0 =C2=A02 -<br>
=C2=A0src/openvpn/init.c=C2=A0 =C2=A0 |=C2=A0 =C2=A07 +---<br>
=C2=A0src/openvpn/multi.c=C2=A0 =C2=A0|=C2=A0 =C2=A08 ++--<br>
=C2=A0src/openvpn/options.c |=C2=A0 11 +----<br>
=C2=A0src/openvpn/options.h |=C2=A0 =C2=A01 -<br>
=C2=A0src/openvpn/route.c=C2=A0 =C2=A0|=C2=A0 13 ++----<br>
=C2=A0src/openvpn/tun.c=C2=A0 =C2=A0 =C2=A0| 110 ++++++++++----------------=
----<wbr>--------------------<br>
=C2=A0src/openvpn/tun.h=C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A02 -<br>
=C2=A08 files changed, 30 insertions(+), 124 deletions(-)<br>
<br>
diff --git a/src/openvpn/helper.c b/src/openvpn/helper.c<br>
index 62f88ec..229523d 100644<br>
--- a/src/openvpn/helper.c<br>
+++ b/src/openvpn/helper.c<br>
@@ -200,8 +200,6 @@ helper_client_server (struct options *o)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 add_in6_addr( o-&gt=
;server_network_ipv6, 0x1000 );<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 o-&gt;ifconfig_ipv6_pool_netbits =3D o-&gt;serv=
er_netbits_ipv6;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0o-&gt;tun_ipv6 =3D true;<br>
-<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 push_option( o, &quot;tun-ipv6&quot;, M_USAGE )=
;<br>
=C2=A0 =C2=A0 =C2=A0 }<br>
<br>
diff --git a/src/openvpn/init.c b/src/openvpn/init.c<br>
index 9236a9f..e9eb6c7 100644<br>
--- a/src/openvpn/init.c<br>
+++ b/src/openvpn/init.c<br>
@@ -1400,9 +1400,6 @@ do_init_tun (struct context *c)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0!c-&gt;options.ifconfig_nowarn,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0c-&gt;<a href=3D"http://c2.es" rel=3D"noreferrer" t=
arget=3D"_blank">c2.es</a>);<br>
<br>
-=C2=A0 /* flag tunnel for IPv6 config if --tun-ipv6 is set */<br>
-=C2=A0 c-&gt;c1.tuntap-&gt;ipv6 =3D c-&gt;options.tun_ipv6;<br>
-<br>
=C2=A0 =C2=A0init_tun_post (c-&gt;c1.tuntap,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;c-&gt;c2=
.frame,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;c-&gt;op=
tions.tuntap_options);<br>
@@ -1420,8 +1417,8 @@ do_open_tun (struct context *c)<br>
=C2=A0 =C2=A0struct gc_arena gc =3D gc_new ();<br>
=C2=A0 =C2=A0bool ret =3D false;<br>
<br>
-=C2=A0 c-&gt;c2.ipv4_tun =3D (!c-&gt;options.tun_ipv6<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;=
&amp; is_dev_type (c-&gt;options.dev, c-&gt;options.dev_type, &quot;tun&quo=
t;));<br>
+=C2=A0 //c-&gt;c2.ipv4_tun =3D (!c-&gt;options.tun_ipv6<br>
+ //=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;&amp; is_d=
ev_type (c-&gt;options.dev, c-&gt;options.dev_type, &quot;tun&quot;));<br>
<br>
=C2=A0#ifndef TARGET_ANDROID<br>
=C2=A0 =C2=A0if (!c-&gt;c1.tuntap)<br>
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c<br>
index ba7f2c0..228b393 100644<br>
--- a/src/openvpn/multi.c<br>
+++ b/src/openvpn/multi.c<br>
@@ -1377,8 +1377,7 @@ multi_select_virtual_addr (struct multi_context *m, s=
truct multi_instance *mi)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 * (see below) so issue a warning if that happen=
s - don&#39;t break the<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 * session, though, as we don&#39;t even know if=
 this client WANTS IPv6<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
-=C2=A0 =C2=A0 =C2=A0 if ( mi-&gt;context.c1.tuntap-&gt;ipv6 &amp;&amp;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mi-&gt;context.options.ifconfig_<wbr>ip=
v6_pool_defined &amp;&amp;<br>
+=C2=A0 =C2=A0 =C2=A0 if ( mi-&gt;context.options.ifconfig_<wbr>ipv6_pool_d=
efined &amp;&amp;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0! mi-&gt;context.options.push_<wbr=
>ifconfig_ipv6_defined )<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg( M_INFO, &quot;MULTI_sva: WARNING: i=
f --ifconfig-push is used for IPv4, automatic IPv6 assignment from --ifconf=
ig-ipv6-pool does not work.=C2=A0 Use --ifconfig-ipv6-push for IPv6 then.&q=
uot; );<br>
@@ -1451,8 +1450,7 @@ multi_select_virtual_addr (struct multi_context *m, s=
truct multi_instance *mi)<br>
=C2=A0 =C2=A0 * way round (&quot;dynamic IPv4, static IPv6&quot;) or &quot;=
both static&quot; makes sense<br>
=C2=A0 =C2=A0 * -&gt; and so it&#39;s implemented right now<br>
=C2=A0 =C2=A0 */<br>
-=C2=A0 if ( mi-&gt;context.c1.tuntap-&gt;ipv6 &amp;&amp;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0mi-&gt;context.options.push_<wbr>ifconfig_ipv6_=
defined )<br>
+=C2=A0 if ( mi-&gt;context.options.push_<wbr>ifconfig_ipv6_defined )<br>
=C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0mi-&gt;context.c2.push_ifconfig_<wbr>ipv6_local =
=3D<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mi-&gt;context.options.push_<wbr>=
ifconfig_ipv6_local;<br>
@@ -1510,7 +1508,7 @@ multi_set_virtual_addr_env (struct multi_context *m, =
struct multi_instance *mi)<br>
=C2=A0 =C2=A0setenv_del (mi-&gt;<a href=3D"http://context.c2.es" rel=3D"nor=
eferrer" target=3D"_blank">context.c2.es</a>, &quot;ifconfig_pool_remote_ip=
6&quot;);<br>
=C2=A0 =C2=A0setenv_del (mi-&gt;<a href=3D"http://context.c2.es" rel=3D"nor=
eferrer" target=3D"_blank">context.c2.es</a>, &quot;ifconfig_pool_ip6_netbi=
ts&quot;);<br>
<br>
-=C2=A0 if (mi-&gt;context.c1.tuntap-&gt;ipv6 &amp;&amp; mi-&gt;context.c2.=
push_ifconfig_<wbr>ipv6_defined)<br>
+=C2=A0 if (mi-&gt;context.c2.push_ifconfig_<wbr>ipv6_defined)<br>
=C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0setenv_in6_addr (mi-&gt;<a href=3D"http://contex=
t.c2.es" rel=3D"noreferrer" target=3D"_blank">context.c2.es</a>,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &quot;ifconfig_pool_remote&quot;,<br>
diff --git a/src/openvpn/options.c b/src/openvpn/options.c<br>
index e052042..0bab660 100644<br>
--- a/src/openvpn/options.c<br>
+++ b/src/openvpn/options.c<br>
@@ -1496,7 +1496,6 @@ show_settings (const struct options *o)<br>
=C2=A0 =C2=A0SHOW_STR (dev_node);<br>
=C2=A0 =C2=A0SHOW_STR (lladdr);<br>
=C2=A0 =C2=A0SHOW_INT (topology);<br>
-=C2=A0 SHOW_BOOL (tun_ipv6);<br>
=C2=A0 =C2=A0SHOW_STR (ifconfig_local);<br>
=C2=A0 =C2=A0SHOW_STR (ifconfig_remote_netmask);<br>
=C2=A0 =C2=A0SHOW_BOOL (ifconfig_noexec);<br>
@@ -2099,10 +2098,6 @@ options_postprocess_verify_ce (const struct options =
*options, const struct conne<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0option=
s-&gt;connection_list-&gt;<wbr>array[0]-&gt;remote)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0msg (M_USAGE, &quot;&lt;connection=
&gt; cannot be used with --mode server&quot;);<br>
<br>
-#if 0<br>
-=C2=A0 =C2=A0 =C2=A0 if (options-&gt;tun_ipv6)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0msg (M_USAGE, &quot;--tun-ipv6 cannot be used w=
ith --mode server&quot;);<br>
-#endif<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0if (options-&gt;shaper)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 msg (M_USAGE, &quot;--shaper cannot be used wit=
h --mode server&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0if (options-&gt;inetd)<br>
@@ -2126,9 +2121,6 @@ options_postprocess_verify_ce (const struct options *=
options, const struct conne<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 msg (M_USAGE, &quot;--ifconfig-pool-persist mus=
t be used with --ifconfig-pool&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0if (options-&gt;ifconfig_ipv6_pool_<wbr>defined =
&amp;&amp; !options-&gt;ifconfig_ipv6_local )<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 msg (M_USAGE, &quot;--ifconfig-ipv6-pool needs =
--ifconfig-ipv6&quot;);<br>
-=C2=A0 =C2=A0 =C2=A0 if (options-&gt;ifconfig_ipv6_local &amp;&amp; !optio=
ns-&gt;tun_ipv6 )<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0msg (M_INFO, &quot;Warning: --ifconfig-ipv6 wit=
hout --tun-ipv6 will not do IPv6&quot;);<br>
-<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0if (options-&gt;auth_user_pass_file)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 msg (M_USAGE, &quot;--auth-user-pass cannot be =
used with --mode server (it should be used on the client side only)&quot;);=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0if (options-&gt;ccd_exclusive &amp;&amp; !option=
s-&gt;client_config_dir)<br>
@@ -3077,7 +3069,7 @@ options_string (const struct options *o,<br>
=C2=A0 =C2=A0/* send tun_ipv6 only in peer2peer mode - in client/server mod=
e, it<br>
=C2=A0 =C2=A0 * is usually pushed by the server, triggering a non-helpful w=
arning<br>
=C2=A0 =C2=A0 */<br>
-=C2=A0 if (o-&gt;tun_ipv6 &amp;&amp; o-&gt;mode =3D=3D MODE_POINT_TO_POINT=
 &amp;&amp; !PULL_DEFINED(o))<br>
+=C2=A0 if (o-&gt;ifconfig_ipv6_local &amp;&amp; o-&gt;mode =3D=3D MODE_POI=
NT_TO_POINT &amp;&amp; !PULL_DEFINED(o))<br>
=C2=A0 =C2=A0 =C2=A0buf_printf (&amp;out, &quot;,tun-ipv6&quot;);<br>
<br>
=C2=A0 =C2=A0/*<br>
@@ -4578,7 +4570,6 @@ add_option (struct options *options,<br>
=C2=A0 =C2=A0else if (streq (p[0], &quot;tun-ipv6&quot;) &amp;&amp; !p[1])<=
br>
=C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0VERIFY_PERMISSION (OPT_P_UP);<br>
-=C2=A0 =C2=A0 =C2=A0 options-&gt;tun_ipv6 =3D true;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0#ifdef ENABLE_IPROUTE<br>
=C2=A0 =C2=A0else if (streq (p[0], &quot;iproute&quot;) &amp;&amp; p[1] &am=
p;&amp; !p[2])<br>
diff --git a/src/openvpn/options.h b/src/openvpn/options.h<br>
index 9b7b57c..b7453a0 100644<br>
--- a/src/openvpn/options.h<br>
+++ b/src/openvpn/options.h<br>
@@ -251,7 +251,6 @@ struct options<br>
=C2=A0 =C2=A0int ping_send_timeout;=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Send a TC=
P/UDP ping to remote every n seconds */<br>
=C2=A0 =C2=A0int ping_rec_timeout;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Expe=
ct a TCP/UDP ping from remote at least once every n seconds */<br>
=C2=A0 =C2=A0bool ping_timer_remote;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Run ping =
timer only if we have a remote address */<br>
-=C2=A0 bool tun_ipv6;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 /* Build tun dev that supports IPv6 */<br>
<br>
=C2=A0# define PING_UNDEF=C2=A0 =C2=A00<br>
=C2=A0# define PING_EXIT=C2=A0 =C2=A0 1<br>
diff --git a/src/openvpn/route.c b/src/openvpn/route.c<br>
index 85aec71..82855d6 100644<br>
--- a/src/openvpn/route.c<br>
+++ b/src/openvpn/route.c<br>
@@ -1729,10 +1729,10 @@ add_route_ipv6 (struct route_ipv6 *r6, const struct=
 tuntap *tt, unsigned int fla<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0#endif<br>
<br>
-=C2=A0 if ( !tt-&gt;ipv6 )<br>
+=C2=A0 if (!tt-&gt;did_ifconfig_ipv6_setup)<br>
=C2=A0 =C2=A0 =C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 msg( M_INFO, &quot;add_route_ipv6(): not adding %s/%d=
, no IPv6 on if %s&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0netwo=
rk, r6-&gt;netbits, device );<br>
+=C2=A0 =C2=A0 =C2=A0 msg( M_INFO, &quot;add_route_ipv6(): not adding %s/%d=
, no IPv6 ifconfig on if %s&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0netwo=
rk, r6-&gt;netbits, device);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
@@ -2159,13 +2159,6 @@ delete_route_ipv6 (const struct route_ipv6 *r6, cons=
t struct tuntap *tt, unsigne<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0#endif<br>
<br>
-=C2=A0 if ( !tt-&gt;ipv6 )<br>
-=C2=A0 =C2=A0 {<br>
-=C2=A0 =C2=A0 =C2=A0 msg( M_INFO, &quot;delete_route_ipv6(): not deleting =
%s/%d, no IPv6 on if %s&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0netwo=
rk, r6-&gt;netbits, device );<br>
-=C2=A0 =C2=A0 =C2=A0 return;<br>
-=C2=A0 =C2=A0 }<br>
-<br>
=C2=A0 =C2=A0msg( M_INFO, &quot;delete_route_ipv6(%s/%d)&quot;, network, r6=
-&gt;netbits );<br>
<br>
=C2=A0 =C2=A0/* if we used a gateway on &quot;add route&quot;, we also need=
 to specify it on<br>
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c<br>
index b7a29f7..2fbb33c 100644<br>
--- a/src/openvpn/tun.c<br>
+++ b/src/openvpn/tun.c<br>
@@ -741,8 +741,8 @@ do_ifconfig (struct tuntap *tt,<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0argv_init (&amp;argv);<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 msg( M_INFO, &quot;do_ifconfig, tt-&gt;ipv6=3D%d, tt-=
&gt;did_ifconfig_ipv6_setup=3D%<wbr>d&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tt-&gt;ipv6=
, tt-&gt;did_ifconfig_ipv6_setup );<br>
+=C2=A0 =C2=A0 =C2=A0 msg( M_INFO, &quot;do_ifconfig, tt-&gt;did_ifconfig_i=
pv6_setup=3D%<wbr>d&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tt-&g=
t;did_ifconfig_ipv6_setup );<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 * We only handle TUN/TAP devices here, not --de=
v null devices.<br>
@@ -755,7 +755,7 @@ do_ifconfig (struct tuntap *tt,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0ifconfig_local =3D print_in_addr_t (tt-&gt;local=
, 0, &amp;gc);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0ifconfig_remote_netmask =3D print_in_addr_t (tt-=
&gt;remote_netmask, 0, &amp;gc);<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 if ( tt-&gt;ipv6 &amp;&amp; tt-&gt;did_ifconfig_ipv6_=
setup )<br>
+=C2=A0 =C2=A0 =C2=A0 if (tt-&gt;did_ifconfig_ipv6_setup )<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ifconfig_ipv6_local =3D print_in6_addr (=
tt-&gt;local_ipv6, 0, &amp;gc);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ifconfig_ipv6_remote =3D print_in6_addr =
(tt-&gt;remote_ipv6, 0, &amp;gc);<br>
@@ -1127,6 +1127,8 @@ do_ifconfig (struct tuntap *tt,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0if ( do_ipv6 )<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
=C2=A0#ifdef NETBSD_MULTI_AF<br>
+#error no IPv6 support for tun interfaces on NetBSD before 4.0, upgrade yo=
ur system.<br>
+#endif<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 argv_printf (&amp;argv,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 &quot;%s %s inet6 %s/%d&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 IFCONFIG_PATH,<br>
@@ -1139,10 +1141,6 @@ do_ifconfig (struct tuntap *tt,<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* and, hooray, we explicitely need to a=
dd a route... */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 add_route_connected_v6_net(tt, es);<br>
-#else<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0msg( M_INFO, &quot;no IPv6 support for t=
un interfaces on NetBSD before 4.0 (if your system is newer, recompile open=
vpn)&quot; );<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tt-&gt;ipv6 =3D false;<br>
-#endif<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0tt-&gt;did_ifconfig =3D true;<br>
<br>
@@ -1425,7 +1423,6 @@ clear_tuntap (struct tuntap *tuntap)<br>
=C2=A0#ifdef TARGET_SOLARIS<br>
=C2=A0 =C2=A0tuntap-&gt;ip_fd =3D -1;<br>
=C2=A0#endif<br>
-=C2=A0 tuntap-&gt;ipv6 =3D false;<br>
=C2=A0}<br>
<br>
=C2=A0static void<br>
@@ -1478,7 +1475,7 @@ write_tun_header (struct tuntap* tt, uint8_t *buf, in=
t len)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0iph =3D (struct ip *) buf;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (tt-&gt;ipv6 &amp;&amp; iph-&gt;ip_v =3D=3D=
 6)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (iph-&gt;ip_v =3D=3D 6)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0type =3D htonl (AF_INET6);<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0type =3D htonl (AF_INET);<b=
r>
@@ -1526,7 +1523,7 @@ open_tun_generic (const char *dev, const char *dev_ty=
pe, const char *dev_node,<br>
=C2=A0 =C2=A0bool dynamic_opened =3D false;<br>
<br>
<br>
-=C2=A0 if ( tt-&gt;ipv6 &amp;&amp; ! ipv6_explicitly_supported )<br>
+=C2=A0 if (=C2=A0 ! ipv6_explicitly_supported )<br>
=C2=A0 =C2=A0 =C2=A0msg (M_WARN, &quot;NOTE: explicit support for IPv6 tun =
devices is not provided for this OS&quot;);<br>
<br>
=C2=A0 =C2=A0if (tt-&gt;type =3D=3D DEV_TYPE_NULL)<br>
@@ -1710,7 +1707,6 @@ read_tun (struct tuntap* tt, uint8_t *buf, int len)<b=
r>
=C2=A0}<br>
<br>
=C2=A0#elif defined(TARGET_LINUX)<br>
-#ifdef HAVE_LINUX_IF_TUN_H=C2=A0 =C2=A0 =C2=A0/* New driver support */<br>
<br>
=C2=A0#ifndef HAVE_LINUX_SOCKIOS_H<br>
=C2=A0#error header file linux/sockios.h required<br>
@@ -1751,8 +1747,7 @@ open_tun (const char *dev, const char *dev_type, cons=
t char *dev_node, struct tu<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 * Process --tun-ipv6<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0CLEAR (ifr);<br>
-=C2=A0 =C2=A0 =C2=A0 if (!tt-&gt;ipv6)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0ifr.ifr_flags =3D IFF_NO_PI;<br>
+=C2=A0 =C2=A0 =C2=A0 ifr.ifr_flags =3D IFF_NO_PI;<br>
<br>
=C2=A0#if defined(IFF_ONE_QUEUE) &amp;&amp; defined(SIOCSIFTXQLEN)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0ifr.ifr_flags |=3D IFF_ONE_QUEUE;<br>
@@ -1833,32 +1828,10 @@ open_tun (const char *dev, const char *dev_type, co=
nst char *dev_node, struct tu<br>
=C2=A0 =C2=A0ASSERT (0);<br>
=C2=A0}<br>
<br>
-#endif<br>
-<br>
-#else<br>
-<br>
-void<br>
-open_tun (const char *dev, const char *dev_type, const char *dev_node, str=
uct tuntap *tt)<br>
-{<br>
-=C2=A0 open_tun_generic (dev, dev_type, dev_node, false, true, tt);<br>
-}<br>
-<br>
-#endif /* HAVE_LINUX_IF_TUN_H */<br>
+#endif /* !PENDANTIC */<br>
<br>
=C2=A0#ifdef ENABLE_FEATURE_TUN_PERSIST<br>
<br>
-/*<br>
- * This can be removed in future<br>
- * when all systems will use newer<br>
- * linux-headers<br>
- */<br>
-#ifndef TUNSETOWNER<br>
-#define TUNSETOWNER=C2=A0 =C2=A0 _IOW(&#39;T&#39;, 204, int)<br>
-#endif<br>
-#ifndef TUNSETGROUP<br>
-#define TUNSETGROUP=C2=A0 =C2=A0 _IOW(&#39;T&#39;, 206, int)<br>
-#endif<br>
-<br>
=C2=A0void<br>
=C2=A0tuncfg (const char *dev, const char *dev_type, const char *dev_node, =
int persist_mode, const char *username, const char *groupname, const struct=
 tuntap_options *options)<br>
=C2=A0{<br>
@@ -1940,7 +1913,7 @@ close_tun (struct tuntap *tt)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 argv_msg (M_INFO, &amp;argv);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 openvpn_execve_check (&amp;argv, =
NULL, 0, &quot;Linux ip addr del failed&quot;);<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (tt-&gt;ipv6 &amp;&amp; tt-&g=
t;did_ifconfig_ipv6_setup)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (tt-&gt;did_ifconfig_ipv6_set=
up)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const char * =
ifconfig_ipv6_local =3D print_in6_addr (tt-&gt;local_ipv6, 0, &amp;gc);<br>
<br>
@@ -1977,53 +1950,13 @@ close_tun (struct tuntap *tt)<br>
=C2=A0int<br>
=C2=A0write_tun (struct tuntap* tt, uint8_t *buf, int len)<br>
=C2=A0{<br>
-=C2=A0 if (tt-&gt;ipv6)<br>
-=C2=A0 =C2=A0 {<br>
-=C2=A0 =C2=A0 =C2=A0 struct tun_pi pi;<br>
-=C2=A0 =C2=A0 =C2=A0 struct iphdr *iph;<br>
-=C2=A0 =C2=A0 =C2=A0 struct iovec vect[2];<br>
-=C2=A0 =C2=A0 =C2=A0 int ret;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 iph =3D (struct iphdr *)buf;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 pi.flags =3D 0;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 if(iph-&gt;version =3D=3D 6)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0pi.proto =3D htons(OPENVPN_ETH_P_IPV6);<br>
-=C2=A0 =C2=A0 =C2=A0 else<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0pi.proto =3D htons(OPENVPN_ETH_P_IPV4);<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 vect[0].iov_len =3D sizeof(pi);<br>
-=C2=A0 =C2=A0 =C2=A0 vect[0].iov_base =3D &amp;pi;<br>
-=C2=A0 =C2=A0 =C2=A0 vect[1].iov_len =3D len;<br>
-=C2=A0 =C2=A0 =C2=A0 vect[1].iov_base =3D buf;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 ret =3D writev(tt-&gt;fd, vect, 2);<br>
-=C2=A0 =C2=A0 =C2=A0 return(ret - sizeof(pi));<br>
-=C2=A0 =C2=A0 }<br>
-=C2=A0 else<br>
-=C2=A0 =C2=A0 return write (tt-&gt;fd, buf, len);<br>
+=C2=A0 return write (tt-&gt;fd, buf, len);<br>
=C2=A0}<br>
<br>
=C2=A0int<br>
=C2=A0read_tun (struct tuntap* tt, uint8_t *buf, int len)<br>
=C2=A0{<br>
-=C2=A0 if (tt-&gt;ipv6)<br>
-=C2=A0 =C2=A0 {<br>
-=C2=A0 =C2=A0 =C2=A0 struct iovec vect[2];<br>
-=C2=A0 =C2=A0 =C2=A0 struct tun_pi pi;<br>
-=C2=A0 =C2=A0 =C2=A0 int ret;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 vect[0].iov_len =3D sizeof(pi);<br>
-=C2=A0 =C2=A0 =C2=A0 vect[0].iov_base =3D &amp;pi;<br>
-=C2=A0 =C2=A0 =C2=A0 vect[1].iov_len =3D len;<br>
-=C2=A0 =C2=A0 =C2=A0 vect[1].iov_base =3D buf;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 ret =3D readv(tt-&gt;fd, vect, 2);<br>
-=C2=A0 =C2=A0 =C2=A0 return(ret - sizeof(pi));<br>
-=C2=A0 =C2=A0 }<br>
-=C2=A0 else<br>
-=C2=A0 =C2=A0 return read (tt-&gt;fd, buf, len);<br>
+=C2=A0 return read (tt-&gt;fd, buf, len);<br>
=C2=A0}<br>
<br>
=C2=A0#elif defined(TARGET_SOLARIS)<br>
@@ -2227,7 +2160,7 @@ solaris_close_tun (struct tuntap *tt)<br>
=C2=A0 =C2=A0if (tt)<br>
=C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0/* IPv6 interfaces need to be &#39;manually&#39;=
 de-configured */<br>
-=C2=A0 =C2=A0 =C2=A0 if ( tt-&gt;ipv6 &amp;&amp; tt-&gt;did_ifconfig_ipv6_=
setup )<br>
+=C2=A0 =C2=A0 =C2=A0 if ( tt-&gt;did_ifconfig_ipv6_setup )<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 struct argv argv;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 argv_init (&amp;argv);<br>
@@ -2518,7 +2451,7 @@ write_tun (struct tuntap* tt, uint8_t *buf, int len)<=
br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0iph =3D (struct openvpn_iphdr *) buf;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 if (tt-&gt;ipv6 &amp;&amp; OPENVPN_IPH_GET_VER(iph-&g=
t;<wbr>version_len) =3D=3D 6)<br>
+=C2=A0 =C2=A0 =C2=A0 if (OPENVPN_IPH_GET_VER(iph-&gt;<wbr>version_len) =3D=
=3D 6)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0type =3D htonl (AF_INET6);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0else<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0type =3D htonl (AF_INET);<br>
@@ -2644,7 +2577,7 @@ write_tun (struct tuntap* tt, uint8_t *buf, int len)<=
br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0iph =3D (struct ip *) buf;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 if (tt-&gt;ipv6 &amp;&amp; iph-&gt;ip_v =3D=3D 6)<br>
+=C2=A0 =C2=A0 =C2=A0 if (iph-&gt;ip_v =3D=3D 6)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0type =3D htonl (AF_INET6);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0else<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0type =3D htonl (AF_INET);<br>
@@ -2727,7 +2660,7 @@ write_tun (struct tuntap* tt, uint8_t *buf, int len)<=
br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0iph =3D (struct ip *) buf;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 if (tt-&gt;ipv6 &amp;&amp; iph-&gt;ip_v =3D=3D 6)<br>
+=C2=A0 =C2=A0 =C2=A0 if (iph-&gt;ip_v =3D=3D 6)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0type =3D htonl (AF_INET6);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0else<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0type =3D htonl (AF_INET);<br>
@@ -2954,7 +2887,7 @@ close_tun (struct tuntap* tt)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0struct argv argv;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0argv_init (&amp;argv);<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 if ( tt-&gt;ipv6 &amp;&amp; tt-&gt;did_ifconfig_ipv6_=
setup )<br>
+=C2=A0 =C2=A0 =C2=A0 if (tt-&gt;did_ifconfig_ipv6_setup )<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const char * ifconfig_ipv6_local =3D<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 print_in6_addr (tt-&gt;local_ipv6, 0=
, &amp;gc);<br>
@@ -5182,7 +5115,7 @@ open_tun (const char *dev, const char *dev_type, cons=
t char *dev_node, struct tu<br>
<br>
=C2=A0 =C2=A0/*netcmd_semaphore_lock ();*/<br>
<br>
-=C2=A0 msg( M_INFO, &quot;open_tun, tt-&gt;ipv6=3D%d&quot;, tt-&gt;ipv6 );=
<br>
+=C2=A0 msg( M_INFO, &quot;open_tun&quot;);<br>
<br>
=C2=A0 =C2=A0if (tt-&gt;type =3D=3D DEV_TYPE_NULL)<br>
=C2=A0 =C2=A0 =C2=A0{<br>
@@ -5308,11 +5241,10 @@ open_tun (const char *dev, const char *dev_type, co=
nst char *dev_node, struct tu<br>
=C2=A0 =C2=A0 =C2=A0/* usage of numeric constants is ugly, but this is real=
ly tied to<br>
=C2=A0 =C2=A0 =C2=A0 * *this* version of the driver<br>
=C2=A0 =C2=A0 =C2=A0 */<br>
-=C2=A0 =C2=A0 if ( tt-&gt;ipv6 &amp;&amp; tt-&gt;type =3D=3D DEV_TYPE_TUN =
&amp;&amp;<br>
+=C2=A0 =C2=A0 if (tt-&gt;type =3D=3D DEV_TYPE_TUN &amp;&amp;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 info[0] =3D=3D 9 &amp;&amp; info[1] &lt;=
 8)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0msg( M_INFO, &quot;WARNING:=C2=A0 Tap-Win32 dri=
ver version %d.%d does not support IPv6 in TUN mode.=C2=A0 IPv6 will be dis=
abled.=C2=A0 Upgrade to Tap-Win32 9.8 (2.2-beta3 release or later) or use T=
AP mode to get IPv6&quot;, (int) info[0], (int) info[1] );<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0tt-&gt;ipv6 =3D false;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0msg( M_INFO, &quot;WARNING:=C2=A0 Tap-Win32 dri=
ver version %d.%d does not support IPv6 in TUN mode.=C2=A0 IPv6 will not wo=
rk.=C2=A0 Upgrade to Tap-Win32 9.8 (2.2-beta3 release or later) or use TAP =
mode to get IPv6&quot;, (int) info[0], (int) info[1] );<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* tap driver 9.8 (2.2.0 and 2.2.1 release) is buggy<br>
@@ -5653,7 +5585,7 @@ close_tun (struct tuntap *tt)<br>
<br>
=C2=A0 =C2=A0if (tt)<br>
=C2=A0 =C2=A0 =C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 if ( tt-&gt;ipv6 &amp;&amp; tt-&gt;did_ifconfig_ipv6_=
setup )<br>
+=C2=A0 =C2=A0 =C2=A0 if ( tt-&gt;did_ifconfig_ipv6_setup )<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (tt-&gt;options.msg_channel)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h<br>
index 4e93a3f..88431fb 100644<br>
--- a/src/openvpn/tun.h<br>
+++ b/src/openvpn/tun.h<br>
@@ -139,8 +139,6 @@ struct tuntap<br>
=C2=A0 =C2=A0bool did_ifconfig_ipv6_setup;<br>
=C2=A0 =C2=A0bool did_ifconfig;<br>
<br>
-=C2=A0 bool ipv6;<br>
-<br>
=C2=A0 =C2=A0bool persistent_if;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* if ex=
isted before, keep on program end */<br>
<br>
=C2=A0 =C2=A0struct tuntap_options options; /* options set on command line =
*/<br>
<span class=3D"HOEnZb"><font color=3D"#888888">--<br>
2.8.4 (Apple Git-73)<br>
<br>
<br>
------------------------------<wbr>------------------------------<wbr>-----=
-------------<br>
______________________________<wbr>_________________<br>
Openvpn-devel mailing list<br>
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net">Openvpn-devel@...2155...=
9...<wbr>sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" rel=
=3D"noreferrer" target=3D"_blank">https://lists.sourceforge.net/<wbr>lists/=
listinfo/openvpn-devel</a><br>
</font></span></blockquote></div><br></div>

--089e0141a202efbd76053cb0de0a--

