Date: Thu, 1 Dec 2022 15:03:16 +0100
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <Y4i0JBNkm0/77lzt@...2685...>
References: <20221122183706.12561-1-gert@...1296...>
 <20221130205718.79765-1-gert@...1296...>
MIME-Version: 1.0
In-Reply-To: <20221130205718.79765-1-gert@...1296...>
Subject: Re: [Openvpn-devel] [PATCH v14] Add DNS SRV remote host discovery
 support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

Smaller nitpicks:

On Wed, Nov 30, 2022 at 09:57:18PM +0100, Gert Doering wrote:
> From: Vladislav Grishenko <themiron@...2010...>
[...]
> diff --git a/src/openvpn/init.c b/src/openvpn/init.c
> index c2154b8d..3a70748e 100644
> --- a/src/openvpn/init.c
> +++ b/src/openvpn/init.c
> @@ -350,7 +350,12 @@ management_callback_remote_cmd(void *arg, const char **p)
>          }
>          else if (!strcmp(p[1], "MOD") && p[2] && p[3])
>          {
> -            if (strlen(p[2]) < RH_HOST_LEN && strlen(p[3]) < RH_PORT_LEN)
> +            if (ce->remote_srv && ce->proto == PROTO_AUTO)
> +            {
> +                /* can't mutate --remote-srv into --remote without protocol */
> +                ret = false;
> +            }
> +            else if (strlen(p[2]) < RH_HOST_LEN && strlen(p[3]) < RH_PORT_LEN)
>              {
>                  struct remote_host_store *rhs = c->options.rh_store;
>                  if (!rhs)
> @@ -363,6 +368,7 @@ management_callback_remote_cmd(void *arg, const char **p)
>  
>                  ce->remote = rhs->host;
>                  ce->remote_port = rhs->port;
> +                ce->remote_srv = false;
>                  flags = CE_MAN_QUERY_REMOTE_MOD;
>                  ret = true;
>              }
> @@ -462,6 +468,23 @@ clear_remote_addrlist(struct link_socket_addr *lsa, bool free)
>      lsa->current_remote = NULL;
>  }
>  
> +/*
> + * Clear the remote service list
> + */
> +static void
> +clear_remote_servlist(struct link_socket_addr *lsa, bool free)
> +{
> +    if (lsa->service_list && free)
> +    {
> +        freeservinfo(lsa->service_list);
> +    }
> +    lsa->service_list = NULL;
> +    lsa->current_service = NULL;
> +
> +    /* clear addrinfo objects as well */
> +    clear_remote_addrlist(lsa, free);
> +}
> +
>  /*
>   * Increment to next connection entry
>   */
> @@ -491,6 +514,24 @@ next_connection_entry(struct context *c)
>                  c->c1.link_socket_addr.current_remote =
>                      c->c1.link_socket_addr.current_remote->ai_next;
>              }
> +            /* Check if there is another resolved service to try for
> +             * the current connection unless persist-remote-ip was
> +             * requested and current service already has an address */
> +            else if (c->c1.link_socket_addr.current_service
> +                     && c->c1.link_socket_addr.current_service->next
> +                     && !(c->options.persist_remote_ip
> +                          && c->c1.link_socket_addr.remote_list))
> +            {
> +                c->c1.link_socket_addr.current_service =
> +                    c->c1.link_socket_addr.current_service->next;
> +
> +                /* Clear addrinfo object of the previous service */
> +                if (c->c1.link_socket_addr.remote_list)
> +                {
> +                    clear_remote_addrlist(&c->c1.link_socket_addr,
> +                                          !c->options.resolve_in_advance);
> +                }
> +            }
>              else
>              {
>                  c->options.advance_next_remote = false;
> @@ -500,20 +541,24 @@ next_connection_entry(struct context *c)
>                   */
>                  if (!c->options.persist_remote_ip)
>                  {
> -                    /* Connection entry addrinfo objects might have been
> +                    /* Connection entry addr/servinfo objects might have been
>                       * resolved earlier but the entry itself might have been
> -                     * skipped by management on the previous loop.
> -                     * If so, clear the addrinfo objects as close_instance does
> +                     * skipped on the previous loop either by management or
> +                     * due inappropriate service protocol.
> +                     * Clear the addr/servinfo objects as close_instance does.
>                       */
> -                    if (c->c1.link_socket_addr.remote_list)
> +                    if (c->c1.link_socket_addr.remote_list
> +                        || c->c1.link_socket_addr.service_list)
>                      {
> -                        clear_remote_addrlist(&c->c1.link_socket_addr,
> +                        clear_remote_servlist(&c->c1.link_socket_addr,
>                                                !c->options.resolve_in_advance);
>                      }
>  
>                      /* close_instance should have cleared the addrinfo objects */
>                      ASSERT(c->c1.link_socket_addr.current_remote == NULL);
>                      ASSERT(c->c1.link_socket_addr.remote_list == NULL);
> +                    ASSERT(c->c1.link_socket_addr.current_service == NULL);
> +                    ASSERT(c->c1.link_socket_addr.service_list == NULL);
>                  }
>                  else
>                  {
> @@ -549,6 +594,12 @@ next_connection_entry(struct context *c)
>          }
>  
>          c->options.ce = *ce;
> +        if (ce_defined && c->c1.link_socket_addr.current_service)
> +        {
> +            /* map in current service */
> +            struct servinfo *si = c->c1.link_socket_addr.current_service;
> +            ce_defined = options_mutate_ce_servinfo(&c->options, si);
> +        }
>  #ifdef ENABLE_MANAGEMENT
>          if (ce_defined && management && management_query_remote_enabled(management))
>          {
> @@ -3699,10 +3750,13 @@ do_close_link_socket(struct context *c)
>                 ( c->sig->source != SIG_SOURCE_HARD
>                   && ((c->c1.link_socket_addr.current_remote
>                        && c->c1.link_socket_addr.current_remote->ai_next)
> +                     || (c->c1.link_socket_addr.current_service
> +                         && c->c1.link_socket_addr.current_service->next)
>                       || c->options.no_advance))
>                 )))
>      {
> -        clear_remote_addrlist(&c->c1.link_socket_addr, !c->options.resolve_in_advance);
> +        clear_remote_servlist(&c->c1.link_socket_addr,
> +                              !c->options.resolve_in_advance);
>      }
>  
>      /* Clear the remote actual address when persist_remote_ip is not in use */
> @@ -4234,6 +4288,17 @@ init_instance(struct context *c, const struct env_set *env, const unsigned int f
>      /* map in current connection entry */
>      next_connection_entry(c);
>  
> +    /* map in current remote service */
> +    if (c->options.ce.remote_srv)
> +    {
> +        do_resolve_service(c);
> +        if (IS_SIG(c))
> +        {
> +            goto sig;
> +        }
> +        update_options_ce_post(&c->options);
> +    }
> +
>      /* link_socket_mode allows CM_CHILD_TCP
>       * instances to inherit acceptable fds
>       * from a top-level parent */
[...]
> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
> index b7b34c9c..897f1db4 100644
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
> @@ -128,7 +128,9 @@ static const char usage_message[] =
>      "Tunnel Options:\n"
>      "--local host    : Local host name or ip address. Implies --bind.\n"
>      "--remote host [port] : Remote host name or ip address.\n"
> -    "--remote-random : If multiple --remote options specified, choose one randomly.\n"
> +    "--remote-srv domain [service] : Perform DNS SRV remote host discovery.\n"

Missing [proto]

> +    "--remote-random : If multiple --remote or --remote-srv options specified,\n"
> +    "                  choose one randomly.\n"
>      "--remote-random-hostname : Add a random string to remote DNS name.\n"
>      "--mode m        : Major mode, m = 'p2p' (default, point-to-point) or 'server'.\n"
>      "--proto p       : Use protocol p for communicating with peer.\n"
> @@ -161,7 +163,7 @@ static const char usage_message[] =
>      "                  up is a file containing username/password on 2 lines, or\n"
>      "                  'stdin' to prompt for console.\n"
>      "--socks-proxy-retry : Retry indefinitely on Socks proxy errors.\n"
> -    "--resolv-retry n: If hostname resolve fails for --remote, retry\n"
> +    "--resolv-retry n: If hostname resolve fails for --remote or --remote-srv, retry\n"
>      "                  resolve for n seconds before failing (disabled by default).\n"
>      "                  Set n=\"infinite\" to retry indefinitely.\n"
>      "--float         : Allow remote to change its IP address/port, such as through\n"
> @@ -1695,6 +1697,7 @@ show_connection_entry(const struct connection_entry *o)
>      SHOW_STR(local_port);
>      SHOW_STR(remote);
>      SHOW_STR(remote_port);
> +    SHOW_BOOL(remote_srv);
>      SHOW_BOOL(remote_float);
>      SHOW_BOOL(bind_defined);
>      SHOW_BOOL(bind_local);
> @@ -2246,6 +2249,56 @@ connection_entry_load_re(struct connection_entry *ce, const struct remote_entry
>      {
>          ce->af = re->af;
>      }
> +    ce->remote_srv = re->remote_srv;
> +}
> +
> +/* Part of options_postprocess_verify_ce that can be used
> + * in runtime after connection entry proto/hostname change.
> + */
> +static bool
> +options_postprocess_verify_ce_proto(const struct options *options,
> +                                    const struct connection_entry *ce)
> +{
> +    int msglevel = M_WARN|M_NOPREFIX|M_OPTERR;
> +
> +    /*
> +     * Sanity check on --local, --remote, and --ifconfig
> +     */
> +
> +    if (proto_is_net(ce->proto)
> +        && string_defined_equal(ce->local, ce->remote)
> +        && string_defined_equal(ce->local_port, ce->remote_port))
> +    {
> +        msg(msglevel, "--remote and --local addresses are the same");
> +        return false;
> +    }
> +
> +    if (string_defined_equal(ce->remote, options->ifconfig_local)
> +        || string_defined_equal(ce->remote, options->ifconfig_remote_netmask))
> +    {
> +        msg(msglevel, "--local and --remote addresses must be distinct from --ifconfig addresses");
> +        return false;
> +    }
> +
> +    /*
> +     * Check that protocol options make sense.
> +     */
> +
> +#ifdef ENABLE_FRAGMENT
> +    if (!proto_is_udp(ce->proto) && ce->fragment)
> +    {
> +        msg(msglevel, "--fragment can only be used with --proto udp");
> +        return false;
> +    }
> +#endif
> +
> +    if ((ce->http_proxy_options) && ce->proto != PROTO_TCP_CLIENT)
> +    {
> +        msg(msglevel, "--http-proxy MUST be used in TCP Client mode (i.e. --proto tcp-client)");
> +        return false;
> +    }
> +
> +    return true;
>  }
>  
>  static void
> @@ -2322,6 +2375,11 @@ options_postprocess_verify_ce(const struct options *options,
>              "--proto tcp-server or --proto tcp-client");
>      }
>  
> +    if (ce->proto == PROTO_AUTO && !ce->remote_srv)
> +    {
> +        msg(M_USAGE, "--proto auto can be only used with --remote-srv");
> +    }
> +
>      if (options->lladdr && dev != DEV_TYPE_TAP)
>      {
>          msg(M_USAGE, "--lladdr can only be used in --dev tap mode");
> @@ -2335,7 +2393,9 @@ options_postprocess_verify_ce(const struct options *options,
>          msg(M_USAGE, "only one of --tun-mtu or --link-mtu may be defined");
>      }
>  
> -    if (!proto_is_udp(ce->proto) && options->mtu_test)
> +    /* Defer validation for --remote-srv with auto protocol */
> +    if (!proto_is_udp(ce->proto) && options->mtu_test
> +        && !(ce->remote_srv && ce->proto == PROTO_AUTO))
>      {
>          msg(M_USAGE, "--mtu-test only makes sense with --proto udp");

You disable this test here, but you don't add this in any of the
later checks. So it seems this test is just completely removed when
using remote-srv?

>      }
> @@ -2347,6 +2407,11 @@ options_postprocess_verify_ce(const struct options *options,
>       * Sanity check on --local, --remote, and --ifconfig
>       */
>  
> +    if (ce->remote_srv && options->ip_remote_hint)
> +    {
> +        msg(M_USAGE, "--ip-remote-hint can't be used with --remote-srv");
> +    }
> +
>      if (proto_is_net(ce->proto)
>          && string_defined_equal(ce->local, ce->remote)
>          && string_defined_equal(ce->local_port, ce->remote_port))
> @@ -2470,7 +2535,9 @@ options_postprocess_verify_ce(const struct options *options,
>       */
>  
>  #ifdef ENABLE_FRAGMENT
> -    if (!proto_is_udp(ce->proto) && ce->fragment)
> +    /* Defer validation for --remote-srv with auto protocol */
> +    if (!proto_is_udp(ce->proto) && ce->fragment
> +        && !(ce->remote_srv && ce->proto == PROTO_AUTO))
>      {
>          msg(M_USAGE, "--fragment can only be used with --proto udp");
>      }
> @@ -2481,11 +2548,11 @@ options_postprocess_verify_ce(const struct options *options,
>          msg(M_USAGE, "--remote MUST be used in TCP Client mode");
>      }
>  
> -    if ((ce->http_proxy_options) && ce->proto != PROTO_TCP_CLIENT)
> +    /* Defer validation for --remote-srv with auto protocol */
> +    if ((ce->http_proxy_options) && ce->proto != PROTO_TCP_CLIENT
> +        && !(ce->remote_srv && ce->proto == PROTO_AUTO))
>      {
> -        msg(M_USAGE,
> -            "--http-proxy MUST be used in TCP Client mode (i.e. --proto "
> -            "tcp-client)");
> +        msg(M_USAGE, "--http-proxy MUST be used in TCP Client mode (i.e. --proto tcp-client)");
>      }
>  
>      if ((ce->http_proxy_options) && !ce->http_proxy_options->server)
> @@ -2552,6 +2619,10 @@ options_postprocess_verify_ce(const struct options *options,
>          {
>              msg(M_USAGE, "--remote cannot be used with --mode server");
>          }
> +        if (ce->remote_srv)
> +        {
> +            msg(M_USAGE, "--remote-srv cannot be used with --mode server");
> +        }
>          if (!ce->bind_local)
>          {
>              msg(M_USAGE, "--nobind cannot be used with --mode server");
> @@ -3067,26 +3138,14 @@ options_postprocess_verify_ce(const struct options *options,
>      uninit_options(&defaults);
>  }
>  
> -static void
> -options_postprocess_mutate_ce(struct options *o, struct connection_entry *ce)
> +/* Part of options_postprocess_mutate_ce that can be used
> + * in runtime after connection entry proto/hostname change.
> + */
> +static bool
> +options_postprocess_mutate_ce_proto(struct options *o,
> +                                    struct connection_entry *ce)
>  {
> -    const int dev = dev_type_enum(o->dev, o->dev_type);
> -
> -    if (o->server_defined || o->server_bridge_defined || o->server_bridge_proxy_dhcp)
> -    {
> -        if (ce->proto == PROTO_TCP)
> -        {
> -            ce->proto = PROTO_TCP_SERVER;
> -        }
> -    }
> -
> -    if (o->client)
> -    {
> -        if (ce->proto == PROTO_TCP)
> -        {
> -            ce->proto = PROTO_TCP_CLIENT;
> -        }
> -    }
> +    bool result = true;
>  
>      /* an option is present that requires local bind to enabled */
>      bool need_bind = ce->local || ce->local_port_defined || ce->bind_defined;
> @@ -3110,7 +3169,61 @@ options_postprocess_mutate_ce(struct options *o, struct connection_entry *ce)
>      /* if protocol forcing is enabled, disable all protocols
>       * except for the forced one
>       */
> -    if (o->proto_force >= 0 && o->proto_force != ce->proto)
> +    if (o->proto_force >= 0 && o->proto_force != ce->proto
> +        && !(ce->remote_srv && ce->proto == PROTO_AUTO))
> +    {
> +        result = false;
> +    }
> +
> +    /* our socks code is not fully IPv6 enabled yet (TCP works, UDP not)
> +     * so fall back to IPv4-only (trac #1221)
> +     */
> +    if (ce->socks_proxy_server && proto_is_udp(ce->proto) && ce->af != AF_INET)
> +    {
> +        if (ce->af == AF_INET6)
> +        {
> +            msg(M_INFO, "WARNING: '--proto udp6' is not compatible with "
> +                "'--socks-proxy' today. Forcing IPv4 mode.");
> +        }
> +        else
> +        {
> +            msg(M_INFO, "NOTICE: dual-stack mode for '--proto udp' does not "
> +                "work correctly with '--socks-proxy' today. Forcing IPv4.");
> +        }
> +        ce->af = AF_INET;
> +    }
> +
> +    if (!proto_is_udp(ce->proto) && ce->explicit_exit_notification)
> +    {
> +        msg(M_WARN, "NOTICE: --explicit-exit-notify ignored for --proto tcp");
> +        ce->explicit_exit_notification = 0;
> +    }
> +
> +    return result;
> +}
> +
> +static void
> +options_postprocess_mutate_ce(struct options *o, struct connection_entry *ce)
> +{
> +    const int dev = dev_type_enum(o->dev, o->dev_type);
> +
> +    if (o->server_defined || o->server_bridge_defined || o->server_bridge_proxy_dhcp)
> +    {
> +        if (ce->proto == PROTO_TCP)
> +        {
> +            ce->proto = PROTO_TCP_SERVER;
> +        }
> +    }
> +
> +    if (o->client)
> +    {
> +        if (ce->proto == PROTO_TCP)
> +        {
> +            ce->proto = PROTO_TCP_CLIENT;
> +        }
> +    }
> +
> +    if (!options_postprocess_mutate_ce_proto(o, ce))
>      {
>          ce->flags |= CE_DISABLED;
>      }
> @@ -3214,12 +3327,32 @@ options_postprocess_mutate_ce(struct options *o, struct connection_entry *ce)
>          connection_entry_preload_key(&ce->tls_crypt_v2_file,
>                                       &ce->tls_crypt_v2_file_inline, &o->gc);
>      }
> +}
>  
> -    if (!proto_is_udp(ce->proto) && ce->explicit_exit_notification)
> +/*
> + * Merges servinfo's hostname, servname and proto into current connection
> + * entry if possible and doesn't conflict with the options.
> + * Used by runtime DNS SRV discovery.
> + */
> +bool
> +options_mutate_ce_servinfo(struct options *o, struct servinfo *si)
> +{
> +    struct connection_entry ce = o->ce;
> +
> +    ASSERT(ce.remote_srv);
> +
> +    ce.remote = si->hostname;
> +    ce.remote_port = si->servname;
> +    ce.proto = si->proto;
> +
> +    if (options_postprocess_mutate_ce_proto(o, &ce)
> +        && options_postprocess_verify_ce_proto(o, &ce))
>      {
> -        msg(M_WARN, "NOTICE: --explicit-exit-notify ignored for --proto tcp");
> -        ce->explicit_exit_notification = 0;
> +        o->ce = ce;
> +        return true;
>      }
> +
> +    return false;
>  }
>  
>  #ifdef _WIN32
> @@ -6062,7 +6195,8 @@ add_option(struct options *options,
>                                 OPT_P_CONNECTION, option_types_found, es);
>              if (!sub.ce.remote)
>              {
> -                msg(msglevel, "Each 'connection' block must contain exactly one 'remote' directive");
> +                msg(msglevel, "Each 'connection' block must contain exactly one 'remote' "
> +                    "or 'remote-srv' directive");
>                  uninit_options(&sub);
>                  goto err;
>              }
> @@ -6140,6 +6274,7 @@ add_option(struct options *options,
>      {
>          struct remote_entry re;
>          re.remote = re.remote_port = NULL;
> +        re.remote_srv = false;
>          re.proto = -1;
>          re.af = 0;
>  
> @@ -6174,9 +6309,66 @@ add_option(struct options *options,
>          }
>          else if (permission_mask & OPT_P_CONNECTION)
>          {
> +            if (options->ce.remote && options->ce.remote_srv)
> +            {
> +                msg(msglevel, "Each 'connection' block must contain exactly one 'remote' "
> +                    "or 'remote-srv' directive");
> +                goto err;
> +            }
> +            connection_entry_load_re(&options->ce, &re);
> +        }
> +    }
> +#if !defined(TARGET_OPENBSD)
> +    else if (streq(p[0], "remote-srv") && p[1] && !p[4])
> +    {
> +        struct remote_entry re;
> +        re.remote = NULL;
> +        re.remote_port = OPENVPN_SERVICE;
> +        re.remote_srv = true;
> +        re.proto = PROTO_AUTO;
> +        re.af = 0;
> +
> +        VERIFY_PERMISSION(OPT_P_GENERAL|OPT_P_CONNECTION);
> +        re.remote = p[1];
> +        if (p[2])
> +        {
> +            re.remote_port = p[2];
> +            if (p[3])
> +            {
> +                const int proto = ascii2proto(p[3]);
> +                const sa_family_t af = ascii2af(p[3]);
> +                if (proto < 0)
> +                {
> +                    msg(msglevel,
> +                        "remote-srv: bad protocol associated with domain %s: "
> +                        "'%s'", p[1], p[3]);
> +                    goto err;
> +                }
> +                re.proto = proto;
> +                re.af = af;
> +            }
> +        }
> +        if (permission_mask & OPT_P_GENERAL)
> +        {
> +            struct remote_entry *e = alloc_remote_entry(options, msglevel);
> +            if (!e)
> +            {
> +                goto err;
> +            }
> +            *e = re;
> +        }
> +        else if (permission_mask & OPT_P_CONNECTION)
> +        {
> +            if (options->ce.remote && !options->ce.remote_srv)
> +            {
> +                msg(msglevel, "Each 'connection' block must contain exactly one 'remote' "
> +                    "or 'remote-srv' directive");
> +                goto err;
> +            }
>              connection_entry_load_re(&options->ce, &re);
>          }
>      }
> +#endif /* if !defined(TARGET_OPENBSD) */
>      else if (streq(p[0], "resolv-retry") && p[1] && !p[2])
>      {
>          VERIFY_PERMISSION(OPT_P_GENERAL);
> @@ -6691,7 +6883,7 @@ add_option(struct options *options,
>          int proto_force;
>          VERIFY_PERMISSION(OPT_P_GENERAL);
>          proto_force = ascii2proto(p[1]);
> -        if (proto_force < 0)
> +        if (proto_force < 0 || proto_force == PROTO_AUTO)
>          {
>              msg(msglevel, "Bad --proto-force protocol: '%s'", p[1]);
>              goto err;
[...]
> diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
> index 4a982561..aa057f61 100644
> --- a/src/openvpn/socket.c
> +++ b/src/openvpn/socket.c
> @@ -271,6 +271,37 @@ get_cached_dns_entry(struct cached_dns_entry *dns_cache,
>      return -1;
>  }
>  
> +/*
> + * get_cached_srv_entry return 0 on success and -1

"returns"

> + * otherwise. (like getservinfo)
> + */
> +static int
> +get_cached_srv_entry(struct cached_dns_entry *dns_cache,
> +                     const char *hostname,
> +                     const char *servname,
> +                     int ai_family,
> +                     int resolve_flags,
> +                     struct servinfo **si)
> +{
> +    struct cached_dns_entry *ph;
> +    int flags;
> +
> +    /* Only use flags that are relevant for the structure */
> +    flags = resolve_flags & GETADDR_CACHE_SERVICE_MASK;
> +    flags |= GETADDR_SERVICE;
> +
> +    for (ph = dns_cache; ph; ph = ph->next)
> +    {
> +        if (streqnull(ph->hostname, hostname)
> +            && streqnull(ph->servname, servname)
> +            && ph->flags == flags)
> +        {
> +            *si = ph->si;
> +            return 0;
> +        }
> +    }
> +    return -1;
> +}
>  
>  static int
>  do_preresolve_host(struct context *c,
> @@ -326,6 +357,77 @@ do_preresolve_host(struct context *c,
>      return status;
>  }
>  
> +static int
> +do_preresolve_service(struct context *c,
> +                      const char *hostname,
> +                      const char *servname,
> +                      const int af,
> +                      const int flags,
> +                      bool preresolve_host)
> +{
> +    struct servinfo *si;
> +    int status;
> +
> +    if (get_cached_srv_entry(c->c1.dns_cache,
> +                             hostname,
> +                             servname,
> +                             af,
> +                             flags,
> +                             &si) == 0)
> +    {
> +        /* entry already cached, return success */
> +        return 0;
> +    }
> +
> +    status = openvpn_getservinfo(flags, hostname, servname,
> +                                 c->options.resolve_retry_seconds, NULL,
> +                                 af, &si);
> +    if (status == 0)
> +    {
> +        struct cached_dns_entry *ph;
> +
> +        ALLOC_OBJ_CLEAR_GC(ph, struct cached_dns_entry, &c->gc);
> +        ph->si = si;
> +        ph->hostname = hostname;
> +        ph->servname = servname;
> +        ph->flags = flags & GETADDR_CACHE_SERVICE_MASK;
> +
> +        if (!c->c1.dns_cache)
> +        {
> +            c->c1.dns_cache = ph;
> +        }
> +        else
> +        {
> +            struct cached_dns_entry *prev = c->c1.dns_cache;
> +            while (prev->next)
> +            {
> +                prev = prev->next;
> +            }
> +            prev->next = ph;
> +        }
> +
> +        gc_addspecial(si, &gc_freeservinfo_callback, &c->gc);
> +
> +        /* preresolve service targets unless disabled */
> +        if (preresolve_host)
> +        {
> +            while (si)
> +            {
> +                int host_flags = flags & ~GETADDR_PROTO_MASK;
> +                if (proto_is_dgram(si->proto))
> +                {
> +                    host_flags |= GETADDR_DATAGRAM;
> +                }
> +                /* ignore errors */
> +                do_preresolve_host(c, si->hostname, si->servname,
> +                                   af, host_flags);
> +                si = si->next;
> +            }
> +        }
> +    }
> +    return status;
> +}
> +
>  void
>  do_preresolve(struct context *c)
>  {
> @@ -364,8 +466,31 @@ do_preresolve(struct context *c)
>              remote = ce->remote;
>          }
>  
> +        /* Preresolve remote services */
> +        if (ce->remote_srv)
> +        {
> +            int service_flags = flags|GETADDR_SERVICE;
> +
> +            if (proto_is_dgram(ce->proto) || ce->proto == PROTO_AUTO)
> +            {
> +                service_flags |= GETADDR_DATAGRAM;
> +            }
> +            if (proto_is_stream(ce->proto) || ce->proto == PROTO_AUTO)
> +            {
> +                service_flags |= GETADDR_STREAM;
> +            }
> +
> +            /* HTTP remote hostnames does not need to be resolved */
> +            status = do_preresolve_service(c, remote, ce->remote_port,
> +                                           ce->af, service_flags,
> +                                           !ce->http_proxy_options);
> +            if (status != 0)
> +            {
> +                goto err;
> +            }
> +        }
>          /* HTTP remote hostname does not need to be resolved */
> -        if (!ce->http_proxy_options)
> +        else if (!ce->http_proxy_options)
>          {
>              status = do_preresolve_host(c, remote, ce->remote_port,
>                                          ce->af, flags);
> @@ -423,6 +548,638 @@ err:
>      throw_signal_soft(SIGHUP, "Preresolving failed");
>  }
>  
> +/**
> + * Allocates new service structure on heap and stores
> + * its initial values.
> + *
> + * @param hostname - The peer host name or ip address
> + * @param port     - The peer TCP/UDP port
> + * @param proto    - Protocol for communicating with the peer
> + *
> + * @return A pointer to servinfo structure or NULL in case of
> + *     allocation error.
> + */
> +static struct servinfo *
> +alloc_servinfo(const char *hostname, uint16_t port, int proto)
> +{
> +    size_t namesize = hostname ? strlen(hostname) + 1 : 0;
> +
> +    char servname[sizeof("65535")];
> +    openvpn_snprintf(servname, sizeof(servname), "%u", port);
> +    size_t servsize = strlen(servname) + 1;
> +
> +    struct servinfo *si = calloc(1, sizeof(*si) + namesize + servsize);
> +    if (si)
> +    {
> +        if (hostname)
> +        {
> +            si->hostname = (char *)(si + 1);
> +            memcpy((char *)si->hostname, hostname, namesize);
> +        }
> +        si->servname = (char *)(si + 1) + namesize;
> +        memcpy((char *)si->servname, servname, servsize);
> +        si->proto = proto;
> +    }
> +    return si;
> +}
> +
> +#ifdef _WIN32
> +/**
> + * Queries DNS SRV records for specified DNS domain.
> + *
> + * @param domain - The DNS domain name
> + * @param proto  - TCP/UDP protocol for communicating with the peer
> + * @param next   - The servinfo structure list to be chained to
> + *                 the resulting servinfo list
> + * @param res    - The pointer to the resulting servinfo list
> + *
> + * @return 0 on success, a EAI-* status code otherwise
> + */
> +static int
> +query_servinfo(const char *domain, int proto,
> +               struct servinfo *next, struct servinfo **res)
> +{
> +    PDNS_RECORD pDnsRecord;
> +    int status;
> +
> +    ASSERT(res);
> +
> +    DNS_STATUS DnsStatus = DnsQuery(domain, DNS_TYPE_SRV, DNS_QUERY_STANDARD,
> +                                    NULL, &pDnsRecord, NULL);
> +    dmsg(D_SOCKET_DEBUG, "DNSQUERY type=%d domain=%s result=%d",
> +         DNS_TYPE_SRV, domain, DnsStatus);
> +    switch (DnsStatus)
> +    {
> +        case ERROR_SUCCESS:
> +            break;
> +
> +        case DNS_ERROR_RCODE_NAME_ERROR:
> +        case DNS_INFO_NO_RECORDS:
> +            return EAI_NONAME; /* HOST_NOT_FOUND */
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
> +            return EAI_FAIL;
> +    }
> +
> +    struct servinfo *list = NULL, *first = NULL;
> +    for (PDNS_RECORD rr = pDnsRecord; rr; rr = rr->pNext)
> +    {
> +        if (rr->wType == DNS_TYPE_SRV)
> +        {
> +            PDNS_SRV_DATA rdata = &rr->Data.Srv;
> +
> +            if (rr->wDataLength >= sizeof(DNS_SRV_DATA)
> +                && *rdata->pNameTarget)
> +            {
> +                struct servinfo *si = alloc_servinfo(rdata->pNameTarget,
> +                                                     rdata->wPort,
> +                                                     proto);
> +                if (!si)
> +                {
> +                    freeservinfo(list);
> +                    status = EAI_MEMORY;
> +                    goto done;
> +                }
> +                si->prio = rdata->wPriority;
> +                si->weight = rdata->wWeight;
> +                si->next = list, list = si;
> +                if (!first)
> +                {
> +                    first = si;
> +                }
> +            }
> +        }
> +    }
> +    if (list)
> +    {
> +        first->next = next;
> +        *res = list;
> +        status = 0;
> +    }
> +    else
> +    {
> +        status = EAI_FAIL;
> +    }
> +
> +done:
> +    DnsRecordListFree(pDnsRecord, DnsFreeRecordList);
> +    return status;
> +}
> +
> +#else  /* ifdef _WIN32 */
> +/**
> + * Queries DNS SRV records for specified DNS domain.
> + *
> + * @param domain - The DNS domain name
> + * @param proto  - TCP/UDP protocol for communicating with the peer
> + * @param next   - The servinfo structure list to be chained to
> + *                 the resulting servinfo list
> + * @param res    - The pointer to the resulting servinfo list
> + *
> + * @return 0 on success, a EAI-* status code otherwise
> + */
> +
> +static int
> +query_servinfo(const char *domain, int proto,
> +               struct servinfo *next, struct servinfo **res)
> +{
> +#if !defined(TARGET_OPENBSD)
> +    unsigned char answer[65535];
> +    int status;
> +
> +    int n = res_query(domain, ns_c_in, ns_t_srv, answer, sizeof(answer));
> +    dmsg(D_SOCKET_DEBUG, "RES_QUERY class=%d type=%d domain=%s result=%d",
> +         ns_c_in, ns_t_srv, domain, n);
> +    if (n < 0)
> +    {
> +        switch (h_errno)
> +        {
> +            case HOST_NOT_FOUND:
> +            case NO_ADDRESS:
> +#if NO_ADDRESS != NO_DATA
> +            case NO_DATA:
> +#endif
> +                return EAI_NONAME;
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
> +    struct servinfo *list = NULL, *first = NULL;
> +    for (int i = 0; i < ns_msg_count(msg, ns_s_an); i++)
> +    {
> +        ns_rr rr;
> +
> +        if (ns_parserr(&msg, ns_s_an, i, &rr) == 0
> +            && ns_rr_type(rr) == ns_t_srv)
> +        {
> +            const unsigned char *rdata = ns_rr_rdata(rr);
> +            char name[NS_MAXDNAME];
> +
> +            if (ns_rr_rdlen(rr) > 6
> +                && dn_expand(ns_msg_base(msg), ns_msg_end(msg),
> +                             rdata + 6, name, sizeof(name)) > 0 && *name)
> +            {
> +                struct servinfo *si = alloc_servinfo(name,
> +                                                     ns_get16(rdata + 4),
> +                                                     proto);
> +                if (!si)
> +                {
> +                    freeservinfo(list);
> +                    status = EAI_MEMORY;
> +                    goto done;
> +                }
> +                si->prio = ns_get16(rdata);
> +                si->weight = ns_get16(rdata + 2);
> +                si->next = list, list = si;
> +                if (!first)
> +                {
> +                    first = si;
> +                }
> +            }
> +        }
> +    }
> +    if (list)
> +    {
> +        first->next = next;
> +        *res = list;
> +        status = 0;
> +    }
> +    else
> +    {
> +        status = EAI_FAIL;
> +    }
> +
> +done:
> +    return status;
> +#else   /* defined(TARGET_OPENBSD) */
> +    /* OpenBSD's native resolver library has a better API - getrrsetbyname() -
> +     * but this is not implemented yet
> +     */
> +    return EAI_FAIL;
> +#endif  /* defined(TARGET_OPENBSD) */
> +}
> +#endif /* ifdef _WIN32 */
> +
> +/**
> + * Servinfo qsort compare function for the server selection
> + * mechanism, defined in RFC 2782.
> + *
> + * @param a - Pointer to first servinfo structure
> + * @param b - Pointer to second servinfo structure
> + *
> + * @return
> + * @li 0, if equal
> + * @li 1, if "a" should be ordered after "b"
> + * @li -1, if "a" should be ordered before "b"
> + */
> +static int
> +servinfo_cmp(const void *a, const void *b)
> +{
> +    const struct servinfo *ae = *(struct servinfo **)a;
> +    const struct servinfo *be = *(struct servinfo **)b;
> +
> +    /* lowest-numbered priority first */
> +    if (ae->prio != be->prio)
> +    {
> +        return ae->prio < be->prio ? -1 : 1;
> +    }
> +
> +    /* zero-weighted first */
> +    if ((ae->weight == 0 && be->weight)
> +        || (ae->weight && be->weight == 0))
> +    {
> +        return ae->weight < be->weight ? -1 : 1;
> +    }
> +
> +    /* else keep received order, can't be equal */
> +    return ae->order > be->order ? -1 : 1;
> +}
> +
> +/**
> + * Sorts service list according the server selection mechanism,
> + * defined in RFC 2782.
> + *
> + * @param list - The pointer to servinfo list
> + *
> + * @return A pointer to the sorted servinfo list
> + */
> +static struct servinfo *
> +sort_servinfo(struct servinfo *list)
> +{
> +    struct servinfo ordered, *tail = &ordered;
> +    int count = 0;
> +    struct gc_arena gc = gc_new();
> +
> +    ASSERT(list);
> +
> +    /* count and number entries in reverse order */
> +    for (struct servinfo *si = list; si; si = si->next)
> +    {
> +        si->order = count++;
> +    }
> +
> +    struct servinfo **sorted;
> +    ALLOC_ARRAY_CLEAR_GC(sorted, struct servinfo *, count, &gc);
> +    for (struct servinfo *si = list; si; si = si->next)
> +    {
> +        sorted[si->order] = si;
> +    }
> +
> +    /* sort records by priority and zero weight */
> +    qsort(sorted, count, sizeof(sorted[0]), servinfo_cmp);
> +
> +    /* apply weighted selection mechanism */
> +    ordered.next = NULL;
> +    for (int i = 0; i < count; )
> +    {
> +        struct servinfo unordered;
> +
> +        /* compute the sum of the weights of records of the same
> +         * priority and put them in the unordered list */
> +        unordered.prio = sorted[i]->prio;
> +        unordered.weight = 0;
> +        unordered.next = NULL;
> +        for (struct servinfo *prev = &unordered;
> +             i < count && sorted[i]->prio == unordered.prio; i++)
> +        {
> +            unordered.weight += sorted[i]->weight;
> +
> +            /* add entry to the tail of unordered list */
> +            sorted[i]->next = NULL;
> +            prev->next = sorted[i], prev = sorted[i];
> +        }
> +
> +        /* process the unordered list */
> +        while (unordered.next)
> +        {
> +            /* choose a uniform random number between 0 and the sum
> +             * computed (inclusive) */
> +            int weight = get_random() % (unordered.weight + 1);
> +
> +            /* select the entries whose running sum value is the first
> +             * in the selected order which is greater than or equal
> +             * to the random number selected */
> +            for (struct servinfo *si = unordered.next, *prev = &unordered;
> +                 si; prev = si, si = si->next)
> +            {
> +                /* selected entry is the next one to be contacted */
> +                if (si->weight >= weight)
> +                {
> +                    unordered.weight -= si->weight;
> +
> +                    /* move entry to the ordered list */
> +                    prev->next = si->next;
> +                    si->next = NULL;
> +                    tail->next = si, tail = si;
> +
> +                    /*
> +                     * RFC 2782 is ambiguous, it says:
> +                     *   In the presence of records containing weights greater
> +                     *   than 0, records with weight 0 should have a very
> +                     *   small chance of being selected.
> +                     * According that, within the same priority, after all
> +                     * records containing weights greater than 0 were selected,
> +                     * the rest of records with weight 0 should be skipped.
> +                     * At the same time, it says:
> +                     *   The following algorithm SHOULD be used to order the
> +                     *   SRV RRs of the same priority:
> +                     *   ...
> +                     *   Continue the ordering process until there are no
> +                     *   unordered SRV RRs.
> +                     * This means records with wight 0 should always be
> +                     * selected, as last ones in worst case.
> +                     *
> +                     * We implement the second option and do not skip any of
> +                     * the records with unordered.weight == 0 after the last
> +                     * one with weight greater than 0.
> +                     */
> +                }
> +                weight -= si->weight;
> +            }
> +        }
> +    }
> +
> +    gc_free(&gc);
> +    return ordered.next;
> +}
> +
> +/**
> + * Resolves DNS SRV records for given domain and service names.
> + *
> + * @param domain  - The DNS SRV domain name
> + * @param service - The DNS SRV service name
> + * @param flags   - GETADDR_* DNS resultion flags
> + * @param res     - The pointer to the resulting servinfo list
> + *
> + * @return 0 on success, a EAI-* status code otherwise
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
> +    } proto[] = {
> +        { GETADDR_DATAGRAM, PROTO_UDP, "udp" },
> +        { GETADDR_STREAM, PROTO_TCP_CLIENT, "tcp" }
> +    };
> +    struct servinfo *list = NULL;
> +    int status = EAI_SOCKTYPE;
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
> +    int proto_flags = flags & GETADDR_PROTO_MASK;
> +    for (int i = 0; i < SIZE(proto); i++)
> +    {
> +        if (proto_flags & proto[i].flags)
> +        {
> +            proto_flags &= ~proto[i].flags;
> +
> +            char qname[256];
> +            if (!openvpn_snprintf(qname, sizeof(qname), "_%s._%s.%s",
> +                                  service, proto[i].name, domain))
> +            {
> +                freeservinfo(list);
> +                return EAI_MEMORY;
> +            }
> +
> +            status = query_servinfo(qname, proto[i].proto, list, &list);
> +        }
> +    }
> +
> +    if (list)
> +    {
> +        *res = sort_servinfo(list);
> +        status = 0;
> +    }
> +
> +    return status;
> +}
> +
> +void
> +freeservinfo(struct servinfo *res)
> +{
> +    while (res)
> +    {
> +        struct servinfo *si = res;
> +        res = res->next;
> +        free(si);
> +    }
> +}
> +
> +/*
> + * Translate IPv4/IPv6 hostname and service name into struct servinfo
> + * If resolve error, try again for resolve_retry_seconds seconds.
> + */
> +int
> +openvpn_getservinfo(unsigned int flags,
> +                    const char *hostname,
> +                    const char *servname,
> +                    int resolve_retry_seconds,
> +                    volatile int *signal_received,
> +                    int family,
> +                    struct servinfo **res)
> +{
> +    int status;
> +    int sigrec = 0;
> +    int msglevel = (flags & GETADDR_FATAL) ? M_FATAL : D_RESOLVE_ERRORS;
> +    struct gc_arena gc = gc_new();
> +    const char *print_hostname;
> +    const char *print_servname;
> +
> +    ASSERT(res);
> +
> +    ASSERT(hostname || servname);
> +    ASSERT(!(flags & GETADDR_HOST_ORDER));
> +
> +    if (hostname)
> +    {
> +        print_hostname = hostname;
> +    }
> +    else
> +    {
> +        print_hostname = "undefined";
> +    }
> +
> +    if (servname)
> +    {
> +        print_servname = servname;
> +    }
> +    else
> +    {
> +        print_servname = "";
> +    }
> +
> +    if (flags & GETADDR_MSG_VIRT_OUT)
> +    {
> +        msglevel |= M_MSG_VIRT_OUT;
> +    }
> +
> +    if ((flags & (GETADDR_FATAL_ON_SIGNAL|GETADDR_WARN_ON_SIGNAL))
> +        && !signal_received)
> +    {
> +        signal_received = &sigrec;
> +    }
> +
> +    const int fail_wait_interval = 5; /* seconds */
> +    /* Add +4 to cause integer division rounding up (1 + 4) = 5, (0+4)/5=0 */
> +    int resolve_retries = (flags & GETADDR_TRY_ONCE) ? 1 :
> +                          ((resolve_retry_seconds + 4)/ fail_wait_interval);
> +    const char *fmt;
> +    int level = 0;
> +
> +    fmt = "RESOLVE: Cannot resolve remote service: %s:%s (%s)";
> +    if ((flags & GETADDR_MENTION_RESOLVE_RETRY)
> +        && !resolve_retry_seconds)
> +    {
> +        fmt = "RESOLVE: Cannot resolve remote service: %s:%s (%s) "
> +              "(I would have retried this name query if you had "
> +              "specified the --resolv-retry option.)";
> +    }
> +
> +#ifdef ENABLE_MANAGEMENT
> +    if (flags & GETADDR_UPDATE_MANAGEMENT_STATE)
> +    {
> +        if (management)
> +        {
> +            management_set_state(management,
> +                                 OPENVPN_STATE_RESOLVE,
> +                                 NULL,
> +                                 NULL,
> +                                 NULL,
> +                                 NULL,
> +                                 NULL);
> +        }
> +    }
> +#endif
> +
> +    /*
> +     * Resolve service
> +     */
> +    while (true)
> +    {
> +#ifndef _WIN32
> +        /* force resolv.conf reload */
> +        res_init();
> +#endif
> +        dmsg(D_SOCKET_DEBUG, "GETSERVINFO flags=0x%04x family=%d %s:%s",
> +             flags, family, print_hostname, print_servname);
> +        status = getservinfo(hostname, servname, flags, res);
> +
> +        if (signal_received)
> +        {
> +            get_signal(signal_received);
> +            if (*signal_received) /* were we interrupted by a signal? */
> +            {
> +                if (*signal_received == SIGUSR1) /* ignore SIGUSR1 */
> +                {
> +                    msg(level, "RESOLVE: Ignored SIGUSR1 signal received "
> +                        "during DNS resolution attempt");
> +                    *signal_received = 0;
> +                }
> +                else
> +                {
> +                    /* turn success into failure (interrupted syscall) */
> +                    if (0 == status)
> +                    {
> +                        ASSERT(res);
> +                        freeservinfo(*res);
> +                        *res = NULL;
> +                        status = EAI_AGAIN; /* = temporary failure */
> +                        errno = EINTR;
> +                    }
> +                    goto done;
> +                }
> +            }
> +        }
> +
> +        /* success? */
> +        if (0 == status)
> +        {
> +            break;
> +        }
> +
> +        /* resolve lookup failed, should we
> +         * continue or fail? */
> +        level = msglevel;
> +        if (resolve_retries > 0)
> +        {
> +            level = D_RESOLVE_ERRORS;
> +        }
> +
> +        msg(level,
> +            fmt,
> +            print_hostname,
> +            print_servname,
> +            gai_strerror(status));
> +
> +        if (--resolve_retries <= 0)
> +        {
> +            goto done;
> +        }
> +
> +        management_sleep(fail_wait_interval);
> +    }
> +
> +    ASSERT(res);
> +
> +    /* service resolve succeeded */
> +
> +done:
> +    if (signal_received && *signal_received)
> +    {
> +        int level = 0;
> +        if (flags & GETADDR_FATAL_ON_SIGNAL)
> +        {
> +            level = M_FATAL;
> +        }
> +        else if (flags & GETADDR_WARN_ON_SIGNAL)
> +        {
> +            level = M_WARN;
> +        }
> +        msg(level, "RESOLVE: signal received during DNS resolution attempt");
> +    }
> +
> +    gc_free(&gc);
> +    return status;
> +}
> +
>  /*
>   * Translate IPv4/IPv6 addr or hostname into struct addrinfo
>   * If resolve error, try again for resolve_retry_seconds seconds.
> @@ -557,8 +1314,9 @@ openvpn_getaddrinfo(unsigned int flags,
>              /* try hostname lookup */
>              hints.ai_flags &= ~AI_NUMERICHOST;
>              dmsg(D_SOCKET_DEBUG,
> -                 "GETADDRINFO flags=0x%04x ai_family=%d ai_socktype=%d",
> -                 flags, hints.ai_family, hints.ai_socktype);
> +                 "GETADDRINFO flags=0x%04x ai_family=%d ai_socktype=%d %s:%s",
> +                 flags, hints.ai_family, hints.ai_socktype,
> +                 print_hostname, print_servname);
>              status = getaddrinfo(hostname, servname, &hints, res);
>  
>              if (signal_received)
> @@ -1816,7 +2574,110 @@ done:
>      gc_free(&gc);
>  }
>  
> +void
> +do_resolve_service(struct context *c)
> +{
> +    struct connection_entry *ce = &c->options.ce;
>  
> +    if (ce->remote_srv
> +        && !c->c1.link_socket_addr.service_list)
> +    {
> +        if (ce->remote)
> +        {
> +            unsigned int flags = sf2gaf(GETADDR_RESOLVE
> +                                        |GETADDR_UPDATE_MANAGEMENT_STATE
> +                                        |GETADDR_SERVICE,
> +                                        c->options.sockflags);
> +            int retry = 0;
> +            int status = -1;
> +            struct servinfo *si;
> +
> +            if (proto_is_dgram(ce->proto) || ce->proto == PROTO_AUTO)
> +            {
> +                flags |= GETADDR_DATAGRAM;
> +            }
> +            if (proto_is_stream(ce->proto) || ce->proto == PROTO_AUTO)
> +            {
> +                flags |= GETADDR_STREAM;
> +            }
> +
> +            if (c->options.sockflags & SF_HOST_RANDOMIZE)
> +            {
> +                flags |= GETADDR_RANDOMIZE;
> +            }
> +
> +            if (c->options.resolve_retry_seconds == RESOLV_RETRY_INFINITE)
> +            {
> +                flags |= (GETADDR_TRY_ONCE | GETADDR_FATAL);
> +                retry = 0;
> +            }
> +            else if (c->options.resolve_retry_seconds)
> +            {
> +                flags |= GETADDR_FATAL;
> +                retry = c->options.resolve_retry_seconds;
> +            }
> +            else
> +            {
> +                flags |= (GETADDR_FATAL | GETADDR_MENTION_RESOLVE_RETRY);
> +                retry = 0;
> +            }
> +
> +            status = get_cached_srv_entry(c->c1.dns_cache,
> +                                          ce->remote,
> +                                          ce->remote_port,
> +                                          ce->af,
> +                                          flags, &si);
> +            if (status)
> +            {
> +                status = openvpn_getservinfo(flags, ce->remote, ce->remote_port,
> +                                             retry, &c->sig->signal_received,
> +                                             ce->af, &si);
> +            }
> +
> +            if (status == 0)
> +            {
> +                c->c1.link_socket_addr.service_list = si;
> +                c->c1.link_socket_addr.current_service = NULL;
> +
> +                /* advance to the first appropriate service */
> +                while (si)
> +                {
> +                    /* map in current service */
> +                    if (!c->c1.link_socket_addr.current_service
> +                        && options_mutate_ce_servinfo(&c->options, si))
> +                    {
> +                        c->c1.link_socket_addr.current_service = si;
> +                    }
> +
> +                    /* log discovered service hosts */
> +                    msg(D_RESOLVE,
> +                        "Resolved remote service host: %s:%s,%s prio %u weight %u",
> +                        np(si->hostname), np(si->servname),
> +                        proto2ascii(si->proto, ce->af, false),
> +                        si->prio, si->weight);
> +
> +                    si = si->next;
> +                }
> +                if (!c->c1.link_socket_addr.current_service)
> +                {
> +                    status = EAI_NONAME;
> +                }
> +
> +                dmsg(D_SOCKET_DEBUG,
> +                     "RESOLVE_SERVICE flags=0x%04x rrs=%d sig=%d status=%d",
> +                     flags,
> +                     retry,
> +                     c->sig->signal_received,
> +                     status);
> +            }
> +
> +            if (!c->sig->signal_received && status != 0)
> +            {
> +                c->sig->signal_received = SIGUSR1;
> +            }
> +        }
> +    }
> +}
>  
>  struct link_socket *
>  link_socket_new(void)
> @@ -3077,16 +3938,19 @@ static const struct proto_names proto_names[] = {
>      {"tcp-server",  "TCP_SERVER", AF_UNSPEC, PROTO_TCP_SERVER},
>      {"tcp-client",  "TCP_CLIENT", AF_UNSPEC, PROTO_TCP_CLIENT},
>      {"tcp",         "TCP", AF_UNSPEC, PROTO_TCP},
> +    {"auto",        "AUTO", AF_UNSPEC, PROTO_AUTO},
>      /* force IPv4 */
>      {"udp4",        "UDPv4", AF_INET, PROTO_UDP},
>      {"tcp4-server", "TCPv4_SERVER", AF_INET, PROTO_TCP_SERVER},
>      {"tcp4-client", "TCPv4_CLIENT", AF_INET, PROTO_TCP_CLIENT},
>      {"tcp4",        "TCPv4", AF_INET, PROTO_TCP},
> +    {"auto4",       "AUTOv4", AF_INET, PROTO_AUTO},
>      /* force IPv6 */
>      {"udp6",        "UDPv6", AF_INET6, PROTO_UDP},
>      {"tcp6-server", "TCPv6_SERVER", AF_INET6, PROTO_TCP_SERVER},
>      {"tcp6-client", "TCPv6_CLIENT", AF_INET6, PROTO_TCP_CLIENT},
>      {"tcp6",        "TCPv6", AF_INET6, PROTO_TCP},
> +    {"auto6",       "AUTOv6", AF_INET6, PROTO_AUTO},
>  };
>  
>  int
> @@ -3147,6 +4011,11 @@ proto2ascii_all(struct gc_arena *gc)
>  
>      for (i = 0; i < SIZE(proto_names); ++i)
>      {
> +        if (proto_names[i].proto == PROTO_NONE
> +            || proto_names[i].proto == PROTO_AUTO)
> +        {
> +            continue;
> +        }
>          if (i)
>          {
>              buf_printf(&out, " ");
[...]

-- 
  Frank Lichtenheld

